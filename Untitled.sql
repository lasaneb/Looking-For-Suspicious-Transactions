Select * from "Card_Holder"
-- where id = 18


SELECT ch.id, ch.name, cc.card, t.date, t.amount, m.name AS merchant,
        mc.name AS category
FROM "Transactions" AS t
JOIN "Credit_Card" AS cc ON cc.card = t.card
JOIN "Card_Holder" AS ch ON ch.id = cc.cardholder_id
JOIN "Merchant" AS m ON m.id = t.id_merchant
JOIN "Merchant_Category" AS mc ON mc.id = m.id_merchant_category
WHERE ch.id ='18' or ch.id = '2'
Order by ch.id;