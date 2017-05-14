class Link < ApplicationRecord

  validates :url, :short_url, presence: true
  validates_length_of :short_url, maximum: 8
  validates_uniqueness_of :short_url
  validate :valid_url

  before_validation :generate_short_url, if: Proc.new { |link| link.short_url.blank? }
  before_validation :sanitize_url

  def valid_url
    error = ': URL does not exist'
    begin
      # create URI::HTTP object from string
      url_object = URI.parse(self.url)
      # initialize HTTP request
      request = Net::HTTP.new(url_object.host, url_object.port)
      # use SSL if https protocol has been detected
      request.use_ssl = (url_object.scheme == 'https')
      # check the path
      path = url_object.path if url_object.path.present?
      # make a request to the given URL
      response = request.request_head(path || '/')
      errors.add(:url, error) if response.code == 404
    # in case HTTP request failed
    rescue SocketError
      errors.add(:url, error)
    # in case anything else crashed
    rescue
      errors.add(:url, ': Invalid URL')
    end
  end

  # Produces random Base36 8-character sequence
  def generate_short_url
    self.short_url = ("%d%d" % [rand(100), Time.now.to_i]).to_i.to_s(36)
  end

  # Adds protocol to url if it's missing
  def sanitize_url
    self.url = "http://#{self.url}" unless self.url=~/^https?:\/\//
  end

end
