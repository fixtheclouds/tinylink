class Link < ApplicationRecord

  validates :url, :short_url, presence: true
  validates_uniqueness_of :short_url

end
