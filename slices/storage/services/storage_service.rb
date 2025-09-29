# frozen_string_literal: true

module Storage
  module Services
    class StorageService
      include Deps[settings: "settings"]

      def initialize(settings:, **deps)
        super(**deps)
        @settings = settings
        @driver = build_driver
      end

      def store(io, filename:, content_type: nil)
        key = generate_key
        content_type ||= detect_content_type(filename)
        
        # Calculate checksum before storing
        checksum = @driver.checksum(io)
        byte_size = io.size if io.respond_to?(:size)
        
        # Store the file
        @driver.store(key, io)
        
        {
          key: key,
          filename: filename,
          content_type: content_type,
          checksum: checksum,
          byte_size: byte_size,
          metadata: {}
        }
      end

      def retrieve(key)
        @driver.retrieve(key)
      end

      def delete(key)
        @driver.delete(key)
      end

      def exist?(key)
        @driver.exist?(key)
      end

      def url_for(key, **options)
        @driver.url_for(key, **options)
      end

      private

      attr_reader :driver

      def build_driver
        case @settings.storage_driver
        when "disk"
          require_relative "../drivers/disk_driver"
          Storage::Drivers::DiskDriver.new(
            root_path: @settings.storage_disk_root_path
          )
        when "s3"
          # Future S3 implementation
          raise NotImplementedError, "S3 driver not yet implemented"
        else
          raise ArgumentError, "Unknown storage driver: #{@settings.storage_driver}"
        end
      end

      def generate_key
        SecureRandom.uuid
      end

      def detect_content_type(filename)
        case File.extname(filename).downcase
        when ".jpg", ".jpeg"
          "image/jpeg"
        when ".png"
          "image/png"
        when ".gif"
          "image/gif"
        when ".pdf"
          "application/pdf"
        when ".txt"
          "text/plain"
        else
          "application/octet-stream"
        end
      end
    end
  end
end
