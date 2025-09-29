# frozen_string_literal: true

module Storage
  module Concerns
    module HasAttachments
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def has_one_attached(name)
          define_method(name) do
            attachment = Storage::Slice["repos.attachment_repo"].find_attachment(
              attachable_type: self.class.name,
              attachable_id: self[:id],
              name: name.to_s
            )
            
            return nil unless attachment
            
            Storage::Slice["repos.blob_repo"].storage_blobs.by_pk(attachment[:blob_id]).one
          end

          define_method("#{name}_url") do
            blob = public_send(name)
            return nil unless blob
            
            Storage::Slice["repos.blob_repo"].url_for(blob)
          end

          define_method("attach_#{name}") do |file_upload|
            # Remove existing attachment if any
            existing = Storage::Slice["repos.attachment_repo"].find_attachment(
              attachable_type: self.class.name,
              attachable_id: self[:id],
              name: name.to_s
            )
            
            if existing
              Storage::Slice["repos.blob_repo"].delete(existing[:blob_id])
              Storage::Slice["repos.attachment_repo"].delete_attachment(existing[:id])
            end

            # Create new blob and attachment
            blob = Storage::Slice["repos.blob_repo"].create(file_upload)
            Storage::Slice["repos.attachment_repo"].create(
              blob_id: blob[:id],
              attachable_type: self.class.name,
              attachable_id: self[:id],
              name: name.to_s
            )
          end
        end

        def has_many_attached(name)
          define_method(name) do
            attachments = Storage::Slice["repos.attachment_repo"].find_attachments(
              attachable_type: self.class.name,
              attachable_id: self[:id],
              name: name.to_s
            )
            
            blob_ids = attachments.map { |a| a[:blob_id] }
            return [] if blob_ids.empty?
            
            Storage::Slice["repos.blob_repo"].storage_blobs.where(id: blob_ids).to_a
          end

          define_method("attach_#{name}") do |file_uploads|
            file_uploads = [file_uploads] unless file_uploads.is_a?(Array)
            
            file_uploads.each do |file_upload|
              blob = Storage::Slice["repos.blob_repo"].create(file_upload)
              Storage::Slice["repos.attachment_repo"].create(
                blob_id: blob[:id],
                attachable_type: self.class.name,
                attachable_id: self[:id],
                name: name.to_s
              )
            end
          end
        end
      end
    end
  end
end
