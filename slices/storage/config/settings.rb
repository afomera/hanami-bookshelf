module Storage
  class Settings < Hanami::Settings
    setting :storage_driver, default: "disk", constructor: Types::String

    # Disk settings (used if `storage_driver` is set to `disk`)
    setting :storage_disk_root_path, default: "storage", constructor: Types::String.optional

    # S3 settings (used if `storage_driver` is set to `s3`)
    setting :storage_s3_bucket_name, constructor: Types::String.optional
    setting :storage_s3_access_key_id, constructor: Types::String.optional
    setting :storage_s3_secret_access_key, constructor: Types::String.optional
    setting :storage_s3_region, constructor: Types::String.optional
    setting :storage_s3_endpoint, constructor: Types::String.optional
  end
end
