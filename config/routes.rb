# frozen_string_literal: true

module Bookshelf
  class Routes < Hanami::Routes
    # Add your routes here. See https://guides.hanamirb.org/routing/overview/ for details.
    root to: "home.index"
    get "/books", to: "books.index"
    get "/books/:id", to: "books.show"
  end
end
