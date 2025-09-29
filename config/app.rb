# frozen_string_literal: true

require "hanami"

module Bookshelf
  class App < Hanami::App
    # config.actions.format :json, :html
    config.middleware.use :body_parser, :form

    config.actions.sessions = :cookie, {
      key: "bookshelf.session",
      secret: settings.session_secret,
      expire_after: 60*60*24*365 # 1 year
    }

    # config.slices :storage
  end
end
