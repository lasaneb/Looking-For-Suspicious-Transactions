-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/oBvY6z
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Card_Holder" (
    "id" int   NOT NULL,
    "name" varchar   NOT NULL,
    CONSTRAINT "pk_Card_Holder" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Credit_Card" (
    "card" varchar(20)   NOT NULL,
    "cardholder_id" int   NOT NULL,
    CONSTRAINT "pk_Credit_Card" PRIMARY KEY (
        "card"
     )
);

CREATE TABLE "Merchant" (
    "id" int   NOT NULL,
    "name" varchar   NOT NULL,
    "id_merchant_category" int   NOT NULL,
    CONSTRAINT "pk_Merchant" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Merchant_Category" (
    "id" int   NOT NULL,
    "name" varchar   NOT NULL,
    CONSTRAINT "pk_Merchant_Category" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Transactions" (
    "id" int   NOT NULL,
    "date" timestamp   NOT NULL,
    "amount" float   NOT NULL,
    "card" varchar(20)   NOT NULL,
    "id_merchant" int   NOT NULL,
    CONSTRAINT "pk_Transactions" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "Credit_Card" ADD CONSTRAINT "fk_Credit_Card_cardholder_id" FOREIGN KEY("cardholder_id")
REFERENCES "Card_Holder" ("id");

ALTER TABLE "Merchant" ADD CONSTRAINT "fk_Merchant_id_merchant_category" FOREIGN KEY("id_merchant_category")
REFERENCES "Merchant_Category" ("id");

ALTER TABLE "Transactions" ADD CONSTRAINT "fk_Transactions_card" FOREIGN KEY("card")
REFERENCES "Credit_Card" ("card");

ALTER TABLE "Transactions" ADD CONSTRAINT "fk_Transactions_id_merchant" FOREIGN KEY("id_merchant")
REFERENCES "Merchant" ("id");
 