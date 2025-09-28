# frozen_string_literal: true

module Bookshelf
  module Views
    module Books
      class Show < Bookshelf::View
        include Deps["repos.book_repo"]

        expose :book do |id:|
          book_repo.find(id)
        end
      end
    end
  end
end
