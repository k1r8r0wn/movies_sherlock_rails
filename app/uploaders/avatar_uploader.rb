class AvatarUploader < CarrierWave::Uploader::Base
  storage :file

  def default_url(*args)
    "/images/" + [version_name, "default_avatar.png"].compact.join('_')
  end

  def store_dir
    "uploads/avatars/#{model.id}"
  end

  def cache_dir
    "uploads/tmp/"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
