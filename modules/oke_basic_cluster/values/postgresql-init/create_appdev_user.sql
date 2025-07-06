-- Create role (if not already created externally)
CREATE ROLE dev WITH LOGIN PASSWORD 'dev';

-- Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON DATABASE myapp TO dev;

-- Connect to the database
\c myapp

-- Grant all privileges on all tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dev;

-- Grant all privileges on all sequences
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO dev;

-- Grant all privileges on all functions
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO dev;

-- Grant all privileges on the schema
GRANT ALL PRIVILEGES ON SCHEMA public TO dev;

-- Grant usage on the schema
GRANT USAGE ON SCHEMA public TO dev; 

-- Default privileges for future objects

-- For creating future tables and maintaining access
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO dev;

ALTER ROLE dev CREATEROLE CREATEDB;
