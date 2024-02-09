-- How can you isolate(group) the transactions for each cardholder?

SELECT ch.name, cc.card, t.date, t.amount, m.name AS merchant,
        mc.name AS category
FROM "Transactions" AS t
JOIN "Credit_Card" AS cc ON cc.card = t.card
JOIN "Card_Holder" AS ch ON ch.id = cc.cardholder_id
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
ORDER BY ch.name;

-- Count the transactions that are less than $2.00 per cardholder.
SELECT count (*) AS "Transactions under $2", ch.name
FROM "Transactions" AS t
JOIN "Credit_Card" AS cc ON cc.card = t.card
JOIN "Card_Holder" AS ch ON ch.id = cc.cardholder_id
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
where t.amount < '2.00'
Group BY ch.name
Order by "Transactions under $2" desc;

-- Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.
----- Yes, there are a few indviduals with abmornally high amounts of transactions under $2.00.

-- What are the top 100 highest transactions made between 7:00 am and 9:00 am?
SELECT ch.name, cc.card, CAST(t.date as time), t.amount, m.name AS merchant,
        mc.name AS category
FROM "Transactions" AS t
JOIN "Credit_Card" AS cc ON cc.card = t.card
JOIN "Card_Holder" AS ch ON ch.id = cc.cardholder_id
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
WHERE CAST(t.date as time) between '7:00:00' and '9:00:00'
ORDER BY t.amount desc Limit 100;


-- Do you see any anomalous transactions that could be fraudulent?
-- Yes, Robert Johnson has made multipule trasactions of $1,000 or more at bars which are generally not open during the hours of 7:00 AM and 9:00 AM.

-- Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
-- Yes.

-- If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.
-- Due to the fact that theses establishments are not open and there is not one presnt ot dsipute the transaction.

-- What are the top 5 merchants prone to being hacked using small transactions?
SELECT m.name AS merchant, COUNT(t.amount) as small_transactions, 
        mc.name AS category
FROM "Transactions" AS t
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
WHERE t.amount < 2
GROUP BY  m.name, mc.name
Order BY small_transactions desc
LIMIT 5;

-- VIEWS --

-- VIEW -- Cardholder Transactions
CREATE VIEW "CardHolder_Transactions"
as
SELECT ch.name, cc.card, t.date, t.amount, m.name AS merchant,
        mc.name AS category
FROM "Transactions" AS t
JOIN "Credit_Card" AS cc ON cc.card = t.card
JOIN "Card_Holder" AS ch ON ch.id = cc.cardholder_id
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
ORDER BY ch.name;

-- VIEW -- Count the transactions that are less than $2.00 per cardholder.
CREATE VIEW "Transactions under $2"
as
SELECT count (*) AS "Transactions under $2", ch.name
FROM "Transactions" AS t
JOIN "Credit_Card" AS cc ON cc.card = t.card
JOIN "Card_Holder" AS ch ON ch.id = cc.cardholder_id
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
where t.amount < '2.00'
Group BY ch.name
Order by "Transactions under $2" desc;

-- VIEW -- What are the top 100 highest transactions made between 7:00 am and 9:00 am?
CREATE VIEW "Top 100 highest transactions made between 7:00 AM and 9:00 AM"
as
SELECT ch.name, cc.card, CAST(t.date as time), t.amount, m.name AS merchant,
        mc.name AS category
FROM "Transactions" AS t
JOIN "Credit_Card" AS cc ON cc.card = t.card
JOIN "Card_Holder" AS ch ON ch.id = cc.cardholder_id
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
WHERE CAST(t.date as time) between '7:00:00' and '9:00:00'
ORDER BY t.amount desc Limit 100;


-- VIEW -- Top 5 merchants prone to being hacked using small transactions?
CREATE VIEW "Top 5 merchants prone to being hacked using small transactions"
as
SELECT m.name AS merchant, COUNT(t.amount) as small_transactions, 
        mc.name AS category
FROM "Transactions" AS t
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
WHERE t.amount < 2
GROUP BY  m.name, mc.name
Order BY small_transactions desc
LIMIT 5;