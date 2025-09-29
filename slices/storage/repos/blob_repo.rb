# frozen_string_literal: true

module Storage
  module Repos
    class BlobRepo < Storage::DB::Repo
      include Deps[storage_service: "services.storage_service"]

      def all
        storage_blobs.to_a
      end

      def create(file_upload)
        # Extract file information from the upload
        tempfile = file_upload[:tempfile]
        filename = file_upload[:filename] || "file"
        content_type = file_upload[:type] || file_upload[:content_type]

        # Store the file using the storage service
        stored_file = storage_service.store(
          tempfile,
          filename: filename,
          content_type: content_type
        )

        # Create the blob record
        blob_attributes = {
          key: stored_file[:key],
          filename: stored_file[:filename],
          content_type: stored_file[:content_type],
          checksum: stored_file[:checksum],
          byte_size: stored_file[:byte_size],
          metadata: stored_file[:metadata].to_json,
          created_at: Time.now
        }

        storage_blobs.changeset(:create, blob_attributes).commit
      end

      def find_by_key(key)
        storage_blobs.where(key: key).one
      end

      def delete(id)
        blob = storage_blobs.by_pk(id).one
        return unless blob

        # Delete the physical file
        storage_service.delete(blob[:key])
        
        # Delete the database record
        storage_blobs.by_pk(id).delete
      end

      def url_for(blob, **options)
        storage_service.url_for(blob[:key], **options)
      end
    end
  end
end
