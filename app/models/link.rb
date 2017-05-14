class Link < ApplicationRecord

  validates :url, :short_url, presence: true
  validates_length_of :short_url, maximum: 8
  validates_uniqueness_of :short_url
  validate :valid_url

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

end
