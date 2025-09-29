# frozen_string_literal: true

module Storage
  module Repos
    class BlobRepo < Storage::DB::Repo
      def all
        storage_blobs.to_a
      end

      def create(filename:, content_type:)
        storage_blobs
          .changeset(
            :create,
            filename:,
            content_type:,
            key: SecureRandom.uuid,
            created_at: Time.now,
            metadata: {}
          )
          .commit
      end
    end
  end
end
