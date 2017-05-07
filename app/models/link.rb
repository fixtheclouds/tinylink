class Link < ApplicationRecord

  validates :url, :short_url, presence: true
  validates_length_of :short_url, maximum: 8
  validates_uniqueness_of :short_url
  validate :url_exists

  before_save do |link|
    link.url = "http://#{url}" unless link.url=~/^https?:\/\//
  end

  private

  def url_exists
    begin
      url_object = URI.parse(sanitize_url(url))
      request = Net::HTTP.new(url_object.host, url_object.port)
      request.use_ssl = (url_object.scheme == 'https')
      path = url_object.path if url_object.path.present?
      response = request.request_head(path || '/')
      errors.add(:url, 'URL does not exist') if response.code == 404
    rescue SocketError => e
      errors.add(:url, "Error while fetching URL: #{e.to_s}")
    end
  end

  def sanitize_url(url)
    url=~/^https?:\/\// ? url : "http://#{url}"
  end

end
