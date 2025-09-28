# frozen_string_literal: true

module Bookshelf
  module Repos
    class BookRepo < Bookshelf::DB::Repo
      def all_by_title(page:, per_page:)
        books
          .order(books[:title].asc)
          .page(page)
          .per_page(per_page)
          .to_a
      end

      def create(attributes)
        books.changeset(:create, attributes).commit
      end

      def find(id)
        books.by_pk(id).one!
      end
    end
  end
end
