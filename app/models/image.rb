class Image < ApplicationRecord
  mount_uploader :url, ImageUploader
end
