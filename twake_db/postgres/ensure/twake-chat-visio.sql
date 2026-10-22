-- Idempotent: run on every `up` by db-ensure. twake-chat-visio-side-service
-- creates its table at start, as the owner of the database.
SELECT 'CREATE USER twake_chat_visio PASSWORD ''twake_chat_visio'''
  WHERE NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'twake_chat_visio')\gexec
SELECT 'CREATE DATABASE twake_chat_visio OWNER twake_chat_visio'
  WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'twake_chat_visio')\gexec
