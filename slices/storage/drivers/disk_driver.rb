# frozen_string_literal: true

require "fileutils"
require "digest"

module Storage
  module Drivers
    class DiskDriver
      attr_reader :root_path

      def initialize(root_path:)
        @root_path = Pathname.new(root_path)
        ensure_root_directory_exists
      end

      def store(key, io)
        file_path = path_for(key)
        ensure_directory_exists(file_path.dirname)

        File.open(file_path, "wb") do |file|
          IO.copy_stream(io, file)
        end

        file_path
      end

      def retrieve(key)
        file_path = path_for(key)
        return nil unless File.exist?(file_path)

        File.open(file_path, "rb").read
      end

      def delete(key)
        file_path = path_for(key)
        File.delete(file_path) if File.exist?(file_path)
      end

      def exist?(key)
        File.exist?(path_for(key))
      end

      def url_for(key, expires_in: nil, **options)
        # For disk storage, we'll return a path that can be served by the web server
        # In production with S3, this would generate a signed URL
        "/storage/#{key}"
      end

      def checksum(io)
        io.rewind if io.respond_to?(:rewind)
        digest = Digest::MD5.new

        while chunk = io.read(8192)
          digest.update(chunk)
        end

        io.rewind if io.respond_to?(:rewind)
        digest.hexdigest
      end

      private

      def path_for(key)
        # Split key into subdirectories to avoid too many files in one directory
        # e.g., "abc123def456" becomes "ab/c1/23/abc123def456"
        parts = key.scan(/.{1,2}/).first(3)
        @root_path.join(*parts, key)
      end

      def ensure_root_directory_exists
        FileUtils.mkdir_p(@root_path) unless @root_path.exist?
      end

      def ensure_directory_exists(directory)
        FileUtils.mkdir_p(directory) unless directory.exist?
      end
    end
  end
end
