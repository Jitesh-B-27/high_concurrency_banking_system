-- Create the uuid-ossp extension if it doesn't exist.
-- This is needed for generating UUIDs.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop tables in a specific order to avoid foreign key constraints errors.
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS users;

-- Create the users table.
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the accounts table.
CREATE TABLE accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    balance NUMERIC(20, 2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT fk_user
      FOREIGN KEY(user_id) 
      REFERENCES users(id) ON DELETE CASCADE
);

-- Create the transactions table (our immutable ledger).
CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    idempotency_key UUID UNIQUE NOT NULL,
    from_account_id UUID NOT NULL,
    to_account_id UUID NOT NULL,
    amount NUMERIC(20, 2) NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    processed_at TIMESTAMPTZ,
    CONSTRAINT fk_from_account
      FOREIGN KEY(from_account_id) 
      REFERENCES accounts(id) ON DELETE CASCADE,
    CONSTRAINT fk_to_account
      FOREIGN KEY(to_account_id) 
      REFERENCES accounts(id) ON DELETE CASCADE
);
