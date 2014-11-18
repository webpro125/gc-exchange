# encoding: utf-8

class ProfileImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick, CarrierWave::Compatibility::Paperclip

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def paperclip_path
    ':class/:id/:style_profile_image.:extension'
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" +
    # [version_name, "default.png"].compact.join('_'))

    [version_name, 'default_profile.png'].compact.join('_')
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process resize_to_fit: [400, 400]
  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [80, 80]
  end
  version :medium do
    process resize_to_fit: [200, 200]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
