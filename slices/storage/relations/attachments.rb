# frozen_string_literal: true

module Storage
  module Relations
    class Attachments < Storage::DB::Relation
      schema :storage_attachments, infer: true
    end
  end
end
