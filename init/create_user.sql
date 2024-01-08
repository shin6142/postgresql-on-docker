-- https://aws.amazon.com/jp/blogs/news/managing-postgresql-users-and-roles/

REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON DATABASE db FROM PUBLIC;

-- read only role
CREATE ROLE readonly;
GRANT CONNECT ON DATABASE db TO readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;

-- read/write role
CREATE ROLE readwrite;
GRANT CONNECT ON DATABASE db TO readwrite;
GRANT USAGE ON SCHEMA public TO readwrite;
GRANT USAGE, CREATE ON SCHEMA public TO readwrite;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO readwrite;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE ON SEQUENCES TO readwrite;

-- application user
CREATE USER application_user WITH PASSWORD 'application_user';
GRANT readwrite TO application_user;

-- developer user
CREATE USER developer_read WITH PASSWORD 'developer_read';
GRANT readonly TO developer_read;

CREATE USER developer_write WITH PASSWORD 'developer_write';
GRANT readwrite TO developer_write;
