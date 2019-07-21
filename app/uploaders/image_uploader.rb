# frozen_string_literal: true

class ImageUploader < ApplicationUploader
  version :thumb do
    process resize_to_fit: [100, 100]
  end
end
