# frozen_string_literal: true

module Bookshelf
  class Routes < Hanami::Routes
    # Add your routes here. See https://guides.hanamirb.org/routing/overview/ for details.
    root to: "home.index"
    get "/books", to: "books.index"
    get "/books.json", to: "books.index", as: :books_json
    get "/books.xml", to: "books.index", as: :books_xml
    get "/books/:id", to: "books.show", as: :show_book
    get "/books/new", to: "books.new"
    post "/books", to: "books.create", as: :create_book

    slice :storage, at: "/storage" do
      get "/:key", to: "serve", as: :serve_file
    end
  end
end
