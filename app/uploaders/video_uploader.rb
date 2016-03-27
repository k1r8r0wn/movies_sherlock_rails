class VideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video
  include CarrierWave::FFmpeg

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :mp4 do
    process encode_video: [:mp4, audio_codec: 'aac', custom: '-strict experimental -q:v 5 -preset slow -g 30']

    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.mp4'
    end
  end

  version :webm do
    process encode_video: [:webm]

    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.webm'
    end
  end

  version :ogv do
    process encode_video: [:ogv]

    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.ogv'
    end
  end
end
