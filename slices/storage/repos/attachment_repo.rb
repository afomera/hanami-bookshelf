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

      def find_attachment(attachable_type:, attachable_id:, name:)
        storage_attachments
          .where(
            attachable_type: attachable_type,
            attachable_id: attachable_id,
            name: name
          )
          .one
      end

      def find_attachments(attachable_type:, attachable_id:, name:)
        storage_attachments
          .where(
            attachable_type: attachable_type,
            attachable_id: attachable_id,
            name: name
          )
          .to_a
      end

      def delete_attachment(id)
        storage_attachments.by_pk(id).delete
      end
    end
  end
end
