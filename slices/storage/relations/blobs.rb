# frozen_string_literal: true

module Storage
  module Relations
    class Blobs < Storage::DB::Relation
      schema :storage_blobs, infer: true
    end
  end
end
