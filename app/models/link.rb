class Link < ApplicationRecord

  validates :url, :short_url, presence: true
  validates_length_of :short_url, maximum: 8
  validates_uniqueness_of :short_url
  validates_exclusion_of :http_status, in: [404], message: ': URL does not exist'

  def save_http_status
    begin
      url_object = URI.parse(self.url)
      request = Net::HTTP.new(url_object.host, url_object.port)
      request.use_ssl = (url_object.scheme == 'https')
      path = url_object.path if url_object.path.present?
      response = request.request_head(path || '/')
      self.http_status = response.code
    rescue SocketError
      self.http_status = 404
    end
  end

end
