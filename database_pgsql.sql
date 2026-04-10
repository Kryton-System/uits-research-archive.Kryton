-- PostgreSQL Compatible SQL Dump for Supabase
-- Based on database.sql (MySQL)

-- Disable foreign key checks is handled differently in PG, usually by dropping/recreating or using triggers.
-- For a fresh install, we just run in order.

-- Set search path
SET search_path TO public;

-- Drop existing tables if they exist (Caution: Destructive)
DROP TABLE IF EXISTS "submissions" CASCADE;
DROP TABLE IF EXISTS "domains" CASCADE;
DROP TABLE IF EXISTS "departments" CASCADE;
DROP TABLE IF EXISTS "sessions" CASCADE;
DROP TABLE IF EXISTS "password_reset_tokens" CASCADE;
DROP TABLE IF EXISTS "users" CASCADE;
DROP TABLE IF EXISTS "cache" CASCADE;
DROP TABLE IF EXISTS "jobs" CASCADE;

-- CREATE Users table
CREATE TABLE "users" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL UNIQUE,
  "email_verified_at" TIMESTAMP NULL DEFAULT NULL,
  "password" VARCHAR(255) NOT NULL,
  "role" VARCHAR(255) NOT NULL DEFAULT 'student',
  "remember_token" VARCHAR(100) DEFAULT NULL,
  "created_at" TIMESTAMP NULL DEFAULT NULL,
  "updated_at" TIMESTAMP NULL DEFAULT NULL
);

-- CREATE Password Reset Tokens table
CREATE TABLE "password_reset_tokens" (
  "email" VARCHAR(255) NOT NULL PRIMARY KEY,
  "token" VARCHAR(255) NOT NULL,
  "created_at" TIMESTAMP NULL DEFAULT NULL
);

-- CREATE Sessions table
CREATE TABLE "sessions" (
  "id" VARCHAR(255) NOT NULL PRIMARY KEY,
  "user_id" BIGINT NULL,
  "ip_address" VARCHAR(45) DEFAULT NULL,
  "user_agent" TEXT DEFAULT NULL,
  "payload" TEXT NOT NULL,
  "last_activity" INTEGER NOT NULL
);
CREATE INDEX "sessions_user_id_idx" ON "sessions" ("user_id");

-- CREATE Departments table
CREATE TABLE "departments" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL UNIQUE,
  "created_at" TIMESTAMP NULL DEFAULT NULL,
  "updated_at" TIMESTAMP NULL DEFAULT NULL
);

-- CREATE Domains table
CREATE TABLE "domains" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL UNIQUE,
  "created_at" TIMESTAMP NULL DEFAULT NULL,
  "updated_at" TIMESTAMP NULL DEFAULT NULL
);

-- CREATE Submissions table
CREATE TABLE "submissions" (
  "id" BIGSERIAL PRIMARY KEY,
  "user_id" BIGINT NOT NULL,
  "title" VARCHAR(500) NOT NULL,
  "archive_type" VARCHAR(255) NOT NULL,
  "author_role" VARCHAR(255) NOT NULL,
  "department" VARCHAR(255) NOT NULL,
  "batch" VARCHAR(100) DEFAULT NULL,
  "academic_session" VARCHAR(100) DEFAULT NULL,
  "research_domains" TEXT DEFAULT NULL,
  "authors" TEXT NOT NULL,
  "external_links" TEXT DEFAULT NULL,
  "pdf_url" TEXT DEFAULT NULL,
  "drive_links" TEXT DEFAULT NULL,
  "abstract" TEXT DEFAULT NULL,
  "author_comments" TEXT DEFAULT NULL,
  "status" VARCHAR(255) NOT NULL DEFAULT 'Pending',
  "admin_remarks" TEXT DEFAULT NULL,
  "reviewed_at" TIMESTAMP NULL DEFAULT NULL,
  "reviewed_by" VARCHAR(255) DEFAULT NULL,
  "created_at" TIMESTAMP NULL DEFAULT NULL,
  "updated_at" TIMESTAMP NULL DEFAULT NULL,
  CONSTRAINT "fk_submission_user" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

-- CREATE Cache table
CREATE TABLE "cache" (
  "key" VARCHAR(255) PRIMARY KEY,
  "value" TEXT NOT NULL,
  "expiration" INTEGER NOT NULL
);

-- CREATE Jobs table
CREATE TABLE "jobs" (
  "id" BIGSERIAL PRIMARY KEY,
  "queue" VARCHAR(255) NOT NULL,
  "payload" TEXT NOT NULL,
  "attempts" SMALLINT NOT NULL,
  "reserved_at" INTEGER DEFAULT NULL,
  "available_at" INTEGER NOT NULL,
  "created_at" INTEGER NOT NULL
);

-- INSERT Data
INSERT INTO "departments" ("name", "created_at", "updated_at") VALUES
('Computer Science & Engineering', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Electrical & Electronic Engineering', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Business Administration', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('English', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Law', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Civil Engineering', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Architecture', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Electronics and Communication Engineering', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Pharmacy', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Public Health', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Environmental Science', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Mathematics', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Physics', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Chemistry', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Biotechnology', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO "domains" ("name", "created_at", "updated_at") VALUES
('Artificial Intelligence', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Machine Learning', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Data Science', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Cybersecurity', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Internet of Things', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Cloud Computing', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Blockchain', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Software Engineering', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Web Development', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Mobile Development', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Network Engineering', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Database Systems', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Human-Computer Interaction', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Computer Vision', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Natural Language Processing', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Robotics', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Renewable Energy', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Sustainable Development', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Public Health', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Environmental Science', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Biotechnology', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Pharmaceutical Sciences', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Civil Engineering', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Architecture', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Business Administration', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Law', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('English Literature', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO "users" ("name", "email", "password", "role", "created_at", "updated_at") VALUES
('Admin User', 'admin@uits.edu.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Student User', 'student@uits.edu.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'student', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Faculty User', 'faculty@uits.edu.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'faculty', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
