# frozen_string_literal: true

module Bookshelf
  module Repos
    class BookRepo < Bookshelf::DB::Repo
      def all_by_title
        books.order(books[:title].asc).to_a
      end
    end
  end
end
