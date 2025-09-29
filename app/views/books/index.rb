# frozen_string_literal: true

module Bookshelf
  module Views
    module Books
      class Index < Bookshelf::View
        include Deps["repos.book_repo"]
        include Storage::Deps[storage_blobs: "repos.blob_repo", storage_attachments: "repos.attachment_repo"]

        expose :books do |page:, per_page:|
          book_repo.all_by_title(page:, per_page:)
        end

        expose :storage_blobs do
          storage_blobs.all
        end

        expose :storage_attachments do
          storage_attachments.all
        end
      end
    end
  end
end
