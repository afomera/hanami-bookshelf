# frozen_string_literal: true

require "hanami"

module Bookshelf
  class App < Hanami::App
    config.actions.format :html, :json
    config.middleware.use :body_parser, :json

    config.actions.sessions = :cookie, {
      key: "bookshelf.session",
      secret: settings.session_secret,
      expire_after: 60*60*24*365 # 1 year
    }
  end
end
