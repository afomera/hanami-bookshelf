# frozen_string_literal: true

module Storage
  module Actions
    class Serve < Storage::Action
      include Deps[blob_repo: "repos.blob_repo", storage_service: "services.storage_service"]

      def handle(request, response)
        key = request.params[:key]

        blob = blob_repo.find_by_key(key)
        return response.status = 404 unless blob

        file = storage_service.retrieve(key)
        return response.status = 404 unless file

        response.headers["Content-Type"] = blob[:content_type]
        response.headers["Content-Length"] = blob[:byte_size].to_s
        response.headers["Content-Disposition"] = "inline; filename=\"#{blob[:filename]}\""
        # response.headers["Cache-Control"] = "public, max-age=31536000"
        # response.headers["ETag"] = blob[:checksum]

        response.body = file
      end
    end
  end
end
