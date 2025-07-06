-- Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON DATABASE ${database} TO ${username};

-- Connect to the database
\c ${database}

-- Grant all privileges on all tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ${username};

-- Grant all privileges on all sequences
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO ${username};

-- Grant all privileges on all functions
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO ${username};

-- Grant all privileges on the schema
GRANT ALL PRIVILEGES ON SCHEMA public TO ${username};

-- Make sure the user can create new tables
-- ALTER USER ${username} CREATEDB;

-- Grant usage on the schema
GRANT USAGE ON SCHEMA public TO ${username}; 

-- Create role (if not already created externally)
CREATE ROLE ${username} WITH LOGIN PASSWORD '${password}';

-- Default privileges for future objects

-- For creating future tables and maintaining access
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO ${username};
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO ${username};
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO ${username};
