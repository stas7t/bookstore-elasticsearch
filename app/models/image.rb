class Image < ApplicationRecord
  belongs_to :book

  mount_uploader :url, ImageUploader
end
