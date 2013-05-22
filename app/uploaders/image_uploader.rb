# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  #include Sprockets::Helpers::RailsHelper
  #include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  before :cache, :setup_available_sizes

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{base_store_dir}/#{mounted_as}"
  end

  def base_store_dir
    "uploads/#{model.class.to_s.underscore}/#{model_id_partition}"
  end

  def model_id_partition
    ("%09d" % model.id).scan(/\d{3}/).join("/")
  end

  process convert: 'jpg'

  #if self.respond_to?(:has_crop_config?)
    # crop image AR to 1:1
    # process :crop
  #end

  version :crop, :if => :has_crop_config? do
    process :crop
  end

  version :large, :if => :has_large_config?, :from_version => :crop do
    process :dynamic_resize_to_fit => :large
  end

  version :normal, :if => :has_normal_config?, :from_version => :large do
    process :dynamic_resize_to_fit => :normal
  end

  version :small, :if => :has_small_config?, :from_version => :normal do
    process :dynamic_resize_to_fit => :small
  end

  # a lame wrapper to resize_to_fit method
  def dynamic_resize_to_fit(size)
    resize_to_fit *(model.class::IMAGE_CONFIG[size])
  end


  def crop
      r = (model.class::IMAGE_CONFIG[:crop])

    if(@file)
      img = ::Magick::Image::read(@file.file).first
      w = r[0]
      h = r[1]
      crop_w = 0
      crop_h = 0

      if w*img.rows > h*img.columns
        crop_w = img.columns
        crop_h = crop_w * h / w
      else
        crop_h = img.rows
        crop_w = crop_h * w / h
      end
     
      resize_to_fill(crop_w, crop_h)
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # here's the metaprogramming magic!
  # we check if the called method matches "has_VERSION_size?"
  # VERSION is a version name for image size
  def method_missing(method, *args)
    # we've already defined "has_VERSION_size?", so if a method with
    # similar name is missed, it should return false
    return false if method.to_s.match(/has_(.*)_config\?/)
    super
  end

  protected
  # the method called at the start
  # it checks for <model>::IMAGE_SIZES hash and define a custom method "has_VERSION_size?"
  # (more on this later in the article)
  def setup_available_sizes(file)
#    ::Rails.logger.debug "setup_available_sizes: #{file.path}"
#    if model.original_image_width.nil? || model.original_image_height.nil?
#      
#      img = ::Magick::Image::read(@file.file).first
#      model.original_image_width = img.columns
#      model.original_image_height = img.rows
#      ::Rails.logger.debug "setup w/h for validtaion #{img.columns}x#{img.rows}"
#    end

    model.class::IMAGE_CONFIG.keys.each do |key|
      self.class_eval do
        define_method("has_#{key}_config?".to_sym) { |file| true }
      end
    end
  end

end
