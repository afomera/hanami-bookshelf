# frozen_string_literal: true

module Bookshelf
  module Views
    module Books
      class Index < Bookshelf::View
        expose :books do
          [
            { title: "Practical Object-Oriented Design in Ruby" },
            { title: "Eloquent Ruby" },
            { title: "The Well-Grounded Rubyist" }
          ]
        end
      end
    end
  end
end
