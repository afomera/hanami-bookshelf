# frozen_string_literal: true

module Storage
  module Repos
    class BlobRepo < Storage::DB::Repo
      def all
        storage_blobs.to_a
      end

      def create(filename:, content_type:, data:)
        storage_blobs
          .changeset(
            :create,
            key: SecureRandom.uuid,
            filename:,
            content_type:,
            created_at: Time.now
          )
          .commit
      end
    end
  end
end
