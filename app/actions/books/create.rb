# frozen_string_literal: true

module Bookshelf
  module Actions
    module Books
      class Create < Bookshelf::Action
        include Deps["repos.book_repo"]
        include Storage::Deps[storage_blobs: "repos.blob_repo", storage_attachments: "repos.attachment_repo"]

        params do
          required(:book).hash do
            required(:title).filled(:string)
            required(:author).filled(:string)
            optional(:cover_image).maybe(:hash) # Expecting a file upload
          end
        end

        def handle(request, response)
          if request.params.valid?
            book = book_repo.create(request.params[:book])

            if request.params[:book][:cover_image]
              # Save the uploaded file as a blob
              blob = storage_blobs.create(request.params[:book][:cover_image])

              storage_attachments.create(
                name: "cover_image",
                blob_id: blob[:id],
                attachable_type: "Book",
                attachable_id: book[:id]
              )
            end

            response.flash[:notice] = "Book created"
            response.redirect_to routes.path(:show_book, id: book[:id])
          else
            response.flash.now[:alert] = "Could not create book"
            # Implicitly re-renders the "new" view
          end
        end
      end
    end
  end
end
