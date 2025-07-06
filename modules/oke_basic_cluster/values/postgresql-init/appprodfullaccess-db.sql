CREATE DATABASE myappfullaccess;

-- Create role (if not already created externally)
CREATE ROLE appprod WITH LOGIN PASSWORD 'appprod';

-- Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON DATABASE myappfullaccess TO appprod;

-- Connect to the database
\c myappfullaccess

-- Grant all privileges on all tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO appprod;

-- Grant all privileges on all sequences
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO appprod;

-- Grant all privileges on all functions
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO appprod;

-- Grant all privileges on the schema
GRANT ALL PRIVILEGES ON SCHEMA public TO appprod;

-- Grant usage on the schema
GRANT USAGE ON SCHEMA public TO appprod; 

-- Default privileges for future objects

-- For creating future tables and maintaining access
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO appprod;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO appprod;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO appprod;