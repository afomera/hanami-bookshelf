module Storage
  class Slice < Hanami::Slice
    # config.db.configure_from_parent = false
    export ["repos.blob_repo", "repos.attachment_repo"]
  end
end
