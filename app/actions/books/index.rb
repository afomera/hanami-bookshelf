# frozen_string_literal: true

module Bookshelf
  module Actions
    module Books
      class Index < Bookshelf::Action
        format :json, :html, :xml

        def handle(request, response)
          puts "******" * 20
          puts "Response FORMAT: #{response.format}"
          puts "request.accept # => #{request.accept}"
          puts "******" * 20
          if response.format == :xml
            response.body = "<books></books>"
            return
          end

          if response.format == :json
            response.body = { OK: true }.to_json
            return
          end

          response.render(
            view,
            page: request.params[:page] || 1,
            per_page: request.params[:per_page] || 5
          )
        end
      end
    end
  end
end
