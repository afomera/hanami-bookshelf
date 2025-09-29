# frozen_string_literal: true

module Storage
  module Repos
    class AttachmentRepo < Storage::DB::Repo
      def all
        storage_attachments.to_a
      end

      def create(blob_id:, attachable_type:, attachable_id:, name:)
        storage_attachments
          .changeset(
            :create,
            blob_id:,
            attachable_type:,
            attachable_id:,
            name:,
            created_at: Time.now
          )
          .commit
      end
    end
  end
end
