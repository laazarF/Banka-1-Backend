-- Delete previous data
TRUNCATE TABLE installment CASCADE;
TRUNCATE TABLE loan CASCADE;
TRUNCATE TABLE receiver CASCADE;
TRUNCATE TABLE transaction CASCADE;
TRUNCATE TABLE account CASCADE;
TRUNCATE TABLE company CASCADE;
TRUNCATE TABLE currency CASCADE;

-- Populate currencies
INSERT INTO currency (code, name, country, symbol) VALUES ('RSD', 'Serbian Dinar', 'Serbia', 'дин.');
INSERT INTO currency (code, name, country, symbol) VALUES ('EUR', 'Euro', 'European Union', '€');
INSERT INTO currency (code, name, country, symbol) VALUES ('USD', 'US Dollar', 'United States', '$');
INSERT INTO currency (code, name, country, symbol) VALUES ('GBP', 'British Pound', 'United Kingdom', '£');
INSERT INTO currency (code, name, country, symbol) VALUES ('CHF', 'Swiss Franc', 'Switzerland', 'Fr');
INSERT INTO currency (code, name, country, symbol) VALUES ('JPY', 'Japanese Yen', 'Japan', '¥');
INSERT INTO currency (code, name, country, symbol) VALUES ('CAD', 'Canadian Dollar', 'Canada', 'C$');
INSERT INTO currency (code, name, country, symbol) VALUES ('AUD', 'Australian Dollar', 'Australia', 'A$');

-- Create bank company
INSERT INTO company (id, name, address, vat_number, company_number)
VALUES (1, 'Banka 1', 'Mite Ruzica 106', '11111', '11111');
--
-- Banks own accounts
INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (-1, '111000012345678912', 1000000.0, 1, 0.0, 1000000.0, 0.0, 0.0, 'RSD',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 1, 'ACTIVE', 'CURRENT', 'STANDARD');

INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (-2, '111000012345679013', 1000000.0, 1, 0.0, 1000000.0, 0.0, 0.0, 'EUR',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 1, 'ACTIVE', 'CURRENT', 'STANDARD');

INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (-3, '111000012345679114', 1000000.0, 1, 0.0, 1000000.0, 0.0, 0.0, 'USD',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 1, 'ACTIVE', 'CURRENT', 'STANDARD');

INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (-4, '111000012345679215', 1000000.0, 1, 0.0, 1000000.0, 0.0, 0.0, 'GBP',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 1, 'ACTIVE', 'CURRENT', 'STANDARD');

INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (-5, '111000012345679316', 1000000.0, 1, 0.0, 1000000.0, 0.0, 0.0, 'CHF',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 1, 'ACTIVE', 'CURRENT', 'STANDARD');

INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (-6, '11100001234567947', 1000000.0, 1, 0.0, 1000000.0, 0.0, 0.0, 'JPY',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 1, 'ACTIVE', 'CURRENT', 'STANDARD');

INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (-7, '111000012345679518', 1000000.0, 1, 0.0, 1000000.0, 0.0, 0.0, 'CAD',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 1, 'ACTIVE', 'CURRENT', 'STANDARD');

INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (-8, '111000012345679619', 1000000.0, 1, 0.0, 1000000.0, 0.0, 0.0, 'AUD',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 1, 'ACTIVE', 'CURRENT', 'STANDARD');

-- User accounts - Jovan (ID: 3)
INSERT INTO account (id, account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES (100, '111000100000000110', 100000.0, NULL, 10000.0, 100000.0, 0.0, 0.0, 'RSD',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 3, 'ACTIVE', 'CURRENT', 'STANDARD');

INSERT INTO account (account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES ('111000100011000110', 1000000.0, NULL, 0.0, 0.0, 0.0, 0.0, 'RSD',
        1630454400000, 2025030500000, 2, 0.0, 0.0, 3, 'ACTIVE', 'CURRENT', 'SAVINGS');

INSERT INTO account (account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES ('111000100000000120', 1000.0, NULL, 200.0, 10000.0, 0.0, 0.0, 'EUR',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 3, 'ACTIVE', 'FOREIGN_CURRENCY', 'STANDARD');

INSERT INTO account (account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES ('111000100220000120', 1000.0, NULL, 100.0, 1000.0, 0.0, 0.0, 'EUR',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 3, 'ACTIVE', 'FOREIGN_CURRENCY', 'PENSION');

INSERT INTO account (account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES ('111000100000000320', 1000.0, NULL, 200.0, 10000.0, 0.0, 0.0, 'USD',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 3, 'ACTIVE', 'FOREIGN_CURRENCY', 'STANDARD');

-- User accounts - Nemanja (ID: 4)
INSERT INTO account (account_number, balance, company_id, daily_limit, monthly_limit,
                     daily_spent, monthly_spent, currency_type, expiration_date, created_date,
                     employeeid, monthly_maintenance_fee, reserved_balance, ownerid,
                     status, type, subtype)
VALUES ('111000100000000210', 100000.0, NULL, 10000.0, 100000.0, 0.0, 0.0, 'RSD',
        1630454400000, 2025030500000, 1, 0.0, 0.0, 4, 'ACTIVE', 'CURRENT', 'STANDARD');

-- More accounts for other users...

-- Receivers
INSERT INTO receiver (owner_account_id, account_number, first_name, last_name)
VALUES (1, '111000100000000210', 'Nemanja', 'Marjanov');

INSERT INTO receiver (owner_account_id, account_number, first_name, last_name)
VALUES (1, '111000100330222210', 'Nikola', 'Nikolic');

INSERT INTO receiver (owner_account_id, account_number, first_name, last_name)
VALUES (1, '111000100335672210', 'Jelena', 'Jovanovic');

INSERT INTO receiver (owner_account_id, account_number, first_name, last_name)
VALUES (3, '111000100000000220', 'Nemanja', 'Marjanov');

INSERT INTO receiver (owner_account_id, account_number, first_name, last_name)
VALUES (3, '111000100366112220', 'Jelena', 'Jovanovic');

-- Loans
INSERT INTO loan (number_of_installments, loan_type, currency_type, interest_type,
                  payment_status, nominal_rate, effective_rate, loan_amount, duration,
                  created_date, allowed_date, monthly_payment, next_payment_date,
                  remaining_amount, loan_reason, account_id)
VALUES (3, 'CASH', 'RSD', 'FIXED', 'PENDING', 5.5, 6.0, 500000.0, 24,
        EXTRACT(EPOCH FROM CURRENT_TIMESTAMP) * 1000,
        EXTRACT(EPOCH FROM CURRENT_TIMESTAMP + INTERVAL '7 days') * 1000,
        22000.0, EXTRACT(EPOCH FROM CURRENT_TIMESTAMP + INTERVAL '30 days') * 1000,
        500000.0, 'Home renovation', 100);

INSERT INTO loan (number_of_installments, loan_type, currency_type, interest_type,
                  payment_status, nominal_rate, effective_rate, loan_amount, duration,
                  created_date, allowed_date, monthly_payment, next_payment_date,
                  remaining_amount, loan_reason, account_id)
VALUES (3, 'CASH', 'RSD', 'FIXED', 'PENDING', 5.5, 6.0, 550000.0, 24,
        EXTRACT(EPOCH FROM CURRENT_TIMESTAMP) * 1000,
        EXTRACT(EPOCH FROM CURRENT_TIMESTAMP + INTERVAL '7 days') * 1000,
        22000.0, EXTRACT(EPOCH FROM CURRENT_TIMESTAMP + INTERVAL '30 days') * 1000,
        500000.0, 'Home renovation, attempt 2', 100);