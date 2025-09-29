# frozen_string_literal: true

ROM::SQL.migration do
  # Add your migration here.
  #
  # See https://guides.hanamirb.org/v2.2/database/migrations/ for details.
  change do
    create_table :storage_blobs do
      primary_key :id

      column :key, String, null: false, unique: true
      column :filename, String, null: false
      column :content_type, String, null: false
      text :metadata, null: false
      column :byte_size, Integer, null: false
      column :checksum, String, null: false
      column :created_at, DateTime, null: false
    end

    create_table :storage_attachments do
      primary_key :id

      column :name, String, null: false
      column :blob_id, Integer, null: false, foreign_key: true
      column :attachable_type, String, null: false
      column :attachable_id, Integer, null: false
      column :created_at, DateTime, null: false
    end
  end
end
