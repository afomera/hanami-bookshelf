CREATE TABLE `schema_migrations`(`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `books`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `title` text NOT NULL,
  `author` text NOT NULL
);
CREATE TABLE `storage_blobs`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `key` varchar(255) NOT NULL UNIQUE,
  `filename` varchar(255) NOT NULL,
  `content_type` varchar(255) NOT NULL,
  `metadata` text NOT NULL,
  `byte_size` integer NOT NULL,
  `checksum` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL
);
CREATE TABLE `storage_attachments`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `name` varchar(255) NOT NULL,
  `blob_id` integer NOT NULL,
  `attachable_type` varchar(255) NOT NULL,
  `attachable_id` integer NOT NULL,
  `created_at` timestamp NOT NULL
);
INSERT INTO schema_migrations (filename) VALUES
('20250927210348_create_books.rb'),
('20250928120456_create_storage_tables.rb');
