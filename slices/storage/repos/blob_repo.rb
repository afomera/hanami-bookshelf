# frozen_string_literal: true

module Storage
  module Repos
    class BlobRepo < Storage::DB::Repo
      def all
        storage_blobs.to_a
      end

      def create(attributes)
        attributes = attributes.merge(
          content_type: attributes[:type] || "application/octet-stream",
          filename: attributes[:filename] || "file",
          key: SecureRandom.uuid,
          created_at: Time.now,
          metadata: "{}",
          byte_size: attributes[:tempfile]&.size || 0,
          checksum: ""
        )

        attributes.delete(:type)
        attributes.delete(:tempfile)
        attributes.delete(:head)

        storage_blobs.changeset(:create, attributes).commit
      end
    end
  end
end
