DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'db_soccerstats') THEN
      EXECUTE 'CREATE DATABASE db_soccerstats';
   END IF;
END
$$;