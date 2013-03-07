-- User  [User]
create table "public"."user" (
   "oid"  int4  not null,
   "username"  varchar(255),
   "password"  varchar(255),
   "email"  varchar(255),
  primary key ("oid")
);


-- Group  [Group]
create table "public"."group" (
   "oid"  int4  not null,
   "groupname"  varchar(255),
  primary key ("oid")
);


-- Module  [Module]
create table "public"."module" (
   "oid"  int4  not null,
   "moduleid"  varchar(255),
   "modulename"  varchar(255),
  primary key ("oid")
);


-- Product  [ent1]
create table "public"."product" (
   "oid"  int4  not null,
   "code"  int4,
   "description"  text,
   "name"  varchar(255),
   "price"  float8,
   "thumbnail"  varchar(255),
   "highlighted"  bool,
  primary key ("oid")
);


-- TechRecord  [ent2]
create table "public"."techrecord" (
   "oid"  int4  not null,
   "colors"  varchar(255),
   "dimensions"  varchar(255),
  primary key ("oid")
);


-- BigImage  [ent3]
create table "public"."bigimage" (
   "oid"  int4  not null,
   "description"  text,
   "picture"  varchar(255),
  primary key ("oid")
);


-- Combination  [ent4]
create table "public"."combination" (
   "oid"  int4  not null,
   "code"  int4,
   "description"  text,
   "name"  varchar(255),
   "price"  float8,
   "photo"  varchar(255),
   "start_date"  date,
   "end_date"  date,
   "highlighted"  bool,
  primary key ("oid")
);


-- Store  [ent5]
create table "public"."store" (
   "oid"  int4  not null,
   "address"  varchar(255),
   "email"  varchar(255),
   "map"  varchar(255),
   "photo"  varchar(255),
  primary key ("oid")
);


-- Category  [ent6]
create table "public"."category" (
   "oid"  int4  not null,
   "category"  varchar(255),
  primary key ("oid")
);


-- User_Group  [User2Group_Group2User]
create table "public"."user_group" (
   "useroid"  int4,
   "groupoid"  int4,
  primary key ("useroid", "groupoid")
);
alter table "public"."user_group"   add constraint fk_user_group_user foreign key ("useroid") references "public"."user" ("oid");
alter table "public"."user_group"   add constraint fk_user_group_group foreign key ("groupoid") references "public"."group" ("oid");


-- User_DefaultGroup  [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user"  ADD COLUMN  "groupoid"  int4;
alter table "public"."user"   add constraint fk_group foreign key ("groupoid") references "public"."group" ("oid");


-- Group_DefaultModule  [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group"  ADD COLUMN  "moduleoid"  int4;
alter table "public"."group"   add constraint fk_module foreign key ("moduleoid") references "public"."module" ("oid");


-- Group_Module  [Group2Module_Module2Group]
create table "public"."group_module" (
   "groupoid"  int4,
   "moduleoid"  int4,
  primary key ("groupoid", "moduleoid")
);
alter table "public"."group_module"   add constraint fk_group_module_group foreign key ("groupoid") references "public"."group" ("oid");
alter table "public"."group_module"   add constraint fk_group_module_module foreign key ("moduleoid") references "public"."module" ("oid");


-- Product_Combination  [rel1_rel2]
create table "public"."product_combination" (
   "productoid"  int4,
   "combinationoid"  int4,
  primary key ("productoid", "combinationoid")
);
alter table "public"."product_combination"   add constraint fk_product_combination_product foreign key ("productoid") references "public"."product" ("oid");
alter table "public"."product_combination"   add constraint fk_product_combination_combina foreign key ("combinationoid") references "public"."combination" ("oid");


-- TechRecord_Product  [rel4_rel3]
create table "public"."techrecord_product" (
   "productoid"  int4,
   "techrecordoid"  int4,
  primary key ("productoid", "techrecordoid")
);
alter table "public"."techrecord_product"   add constraint fk_techrecord_product_product foreign key ("productoid") references "public"."product" ("oid");
alter table "public"."techrecord_product"   add constraint fk_techrecord_product_techreco foreign key ("techrecordoid") references "public"."techrecord" ("oid");


-- BigImage_Product  [rel6_rel5]
alter table "public"."bigimage"  ADD COLUMN  "productoid"  int4;
alter table "public"."bigimage"   add constraint fk_product foreign key ("productoid") references "public"."product" ("oid");


-- Category_Product  [rel8_rel7]
alter table "public"."product"  ADD COLUMN  "categoryoid"  int4;
alter table "public"."product"   add constraint fk_category foreign key ("categoryoid") references "public"."category" ("oid");


-- -------- POPULATE DATABASE ---------------------------------------------------------------------------------------------

-- ---------- POPUPLATE TABLE `MODULE` ----------
INSERT INTO "public"."module" ("oid", "moduleid", "modulename") VALUES (1, 'sv2', 'Acme Administrator');

-- ---------- POPUPLATE TABLE "GROUP" ----------
INSERT INTO "public"."group" ("oid", "groupname", "moduleoid") VALUES (1, 'manager', 1);

-- ---------- POPUPLATE TABLE "USER" ----------
INSERT INTO "public"."user" ("oid", "username", "password", "email", "groupoid") VALUES (1, 'manager', 'manager', 'manager@acme.com', 1);

-- ---------- POPUPLATE TABLE "USER_GROUP" ----------
INSERT INTO "public"."user_group" ("useroid", "groupoid") VALUES (1, 1);

-- ---------- POPUPLATE TABLE "GROUP_MODULE" ----------
INSERT INTO "public"."group_module" ("groupoid", "moduleoid") VALUES (1, 1);

-- ---------- POPUPLATE TABLE "STORE" ----------
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (1, 'Oslo', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (2, 'Barcelona', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (3, 'New York', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (5, 'Montreal', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (6, 'Hamburg', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (7, 'Berlin', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (8, 'Hong Kong', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (9, 'Madrid', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (10, 'Copenhagen', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (11, 'Chicago', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (12, 'London', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (13, 'Sidney', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO "public"."store" ("oid", "address", "email", "map", "photo") VALUES (15, 'Tokyo', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');

-- ---------- POPUPLATE TABLE "category" ----------
INSERT INTO "public"."category" ("oid", "category") VALUES (1, 'Tables');
INSERT INTO "public"."category" ("oid", "category") VALUES (2, 'Chairs');
INSERT INTO "public"."category" ("oid", "category") VALUES (3, 'Lamps');

-- ---------- POPUPLATE TABLE "COMBINATION" ----------
INSERT INTO "public"."combination" ("oid", "code", "description", "name", "price", "photo", "start_date", "end_date", "highlighted") VALUES (1, 1237, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Home Bargain', 3000, 'upload/combo_2.jpg', '2007-01-01 00:00:00', '2008-01-01 00:00:00', TRUE);
INSERT INTO "public"."combination" ("oid", "code", "description", "name", "price", "photo", "start_date", "end_date", "highlighted") VALUES (2, 9898, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'Style & Value', 4550, 'upload/combo_1.jpg', '2007-02-05 00:00:00', '2007-11-03 00:00:00', FALSE);
INSERT INTO "public"."combination" ("oid", "code", "description", "name", "price", "photo", "start_date", "end_date", "highlighted") VALUES (3, 1237, 'Meet with friends in the comfort of a stylish and functional setting.', 'Pick of the site', 500, 'upload/combo_3.jpg', '2007-01-01 00:00:00', '2008-01-01 00:00:00', FALSE);
INSERT INTO "public"."combination" ("oid", "code", "description", "name", "price", "photo", "start_date", "end_date", "highlighted") VALUES (4, 4123, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Value set', 3500, 'upload/combo_3.jpg', '2007-07-31 00:00:00', '2007-07-09 00:00:00', FALSE);
INSERT INTO "public"."combination" ("oid", "code", "description", "name", "price", "photo", "start_date", "end_date", "highlighted") VALUES (5, 1243, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'Big Bundle', 2000, 'upload/combo_1.jpg', '2007-01-01 00:00:00', '2008-01-01 00:00:00', FALSE);
INSERT INTO "public"."combination" ("oid", "code", "description", "name", "price", "photo", "start_date", "end_date", "highlighted") VALUES (6, 6755, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Special of the day', 500, 'upload/combo_2.jpg', '2007-01-01 00:00:00', '2008-01-01 00:00:00', FALSE);
INSERT INTO "public"."combination" ("oid", "code", "description", "name", "price", "photo", "start_date", "end_date", "highlighted") VALUES (7, 9871, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Christmas Special', 3000, 'upload/combo_5.jpg', '2007-03-06 00:00:00', '2007-10-01 00:00:00', FALSE);

-- ---------- POPUPLATE TABLE "TECHRECORD" ----------
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (1, 'upload/colors.jpg', '144x34x300');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (2, 'upload/colors.jpg', '144x111x100');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (3, 'upload/colors.jpg', '144x34x300');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (4, 'upload/colors.jpg', '144x34x100');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (5, 'upload/colors.jpg', '144x111x100');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (6, 'upload/colors.jpg', '11x23x23');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (7, 'upload/colors.jpg', '144x23x170');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (8, 'upload/colors.jpg', '144x34x100');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (9, 'upload/colors.jpg', '144x34x150');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (10, 'upload/colors.jpg', '144x34x300');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (11, 'upload/colors.jpg', '144x34x150');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (12, 'upload/colors.jpg', '144x34x150');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (13, 'upload/colors.jpg', '144x111x100');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (14, 'upload/colors.jpg', '144x11x130');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (15, 'upload/colors.jpg', '144x11x130');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (16, 'upload/colors.jpg', '144x111x100');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (17, 'upload/colors.jpg', '144x34x300');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (18, 'upload/colors.jpg', '544x33x100');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (19, 'upload/colors.jpg', '144x111x100');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (20, 'upload/colors.jpg', '144x11x130');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (21, 'upload/colors.jpg', '23x45x67');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (22, 'upload/colors.jpg', '4x5x6');
INSERT INTO "public"."techrecord" ("oid", "colors", "dimensions") VALUES (23, 'upload/colors.jpg', '12x34x11');

-- ---------- POPUPLATE TABLE "PRODUCT" ----------
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (1, 5125, 'Stainless steel meets crystal and silk to make the comfort and look.', 'Wilderness', 1500, 'upload/small_chair_5.jpg', FALSE, 2);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (2, 5126, 'The spirit of tradition, renovated by the most modern technologies and design.', 'Pink fantasy', 3500, 'upload/small_table_1.jpg', FALSE, 1);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (3, 5127, 'Brighten up your living room with warmly illuminating ideas.', 'Allair', 4550, 'upload/small_chair_2.jpg', FALSE, 2);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (4, 6755, 'The spirit of tradition, renovated by the most modern technologies and design.', 'Amplitude', 3000, 'upload/small_chair_2.jpg', FALSE, 2);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (5, 8630, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Baronetto', 3000, 'upload/small_lamp_4.jpg', FALSE, 3);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (6, 1243, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'Atlas', 1000, 'upload/small_table_4.jpg', FALSE, 1);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (7, 1237, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Aladdin', 1500, 'upload/small_table_1.jpg', TRUE, 1);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (8, 7145, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'Silvestream', 1500, 'upload/small_lamp_1.jpg', FALSE, 3);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (9, 4678, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Sara', 500, 'upload/small_lamp_2.jpg', FALSE, 3);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (10, 1243, 'Meet with friends in the comfort of a stylish and functional setting.', 'Mambo', 1000, 'upload/small_table_1.jpg', FALSE, 1);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (11, 1238, 'Stainless steel meets crystal and silk to make the comfort and look.', 'Euclid', 4550, 'upload/small_table_1.jpg', FALSE, 1);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (13, 4680, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'Andros', 1200, 'upload/small_lamp_1.jpg', FALSE, 3);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (14, 7148, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'Byron', 1000, 'upload/small_chair_3.jpg', NULL, 2);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (16, 1245, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'Landscape', 500, 'upload/small_table_3.jpg', FALSE, 1);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (17, 4123, 'The spirit of tradition, renovated by the most modern technologies and design.', 'Rodolfo', 4550, 'upload/small_table_1.jpg', FALSE, 1);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (21, 9876, 'A fabulous piece of furniture for relaxing with friends.', 'Lucid', 234, 'upload/small_table_5.jpg', FALSE, 1);
INSERT INTO "public"."product" ("oid", "code", "description", "name", "price", "thumbnail", "highlighted", "categoryoid") VALUES (22, 3456, 'A marvellous lamp shedding a new light to your family life.', 'Blue Fountain', 124, 'upload/small_lamp_5.jpg', FALSE, 3);

-- ---------- POPUPLATE TABLE "product_combination" ----------
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (2, 2);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (2, 3);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (2, 5);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (2, 7);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (3, 7);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (4, 3);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (4, 4);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (5, 2);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (5, 6);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (5, 7);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (7, 2);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (7, 3);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (8, 1);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (8, 7);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (9, 4);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (10, 2);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (11, 2);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (11, 3);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (11, 6);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (13, 4);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (13, 5);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (14, 5);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (21, 2);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (21, 5);
INSERT INTO "public"."product_combination" ("productoid", "combinationoid") VALUES (22, 4);


-- ---------- POPUPLATE TABLE "techrecord_product" ----------
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (1, 12);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (2, 9);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (3, 13);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (4, 15);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (5, 3);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (6, 8);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (7, 2);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (8, 17);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (9, 14);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (10, 1);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (11, 19);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (13, 10);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (14, 20);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (16, 5);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (17, 6);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (21, 21);
INSERT INTO "public"."techrecord_product" ("productoid", "techrecordoid") VALUES (22, 23);


-- ---------- POPUPLATE TABLE "bigimage" ----------
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (1, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/lamp_2.jpg', 14);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (2, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_2.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (3, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_1.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (4, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_4.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (5, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/chair_3.jpg', 3);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (6, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_4.jpg', 4);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (7, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/lamp_3.jpg', 10);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (8, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/lamp_1.jpg', 17);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (9, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_3.jpg', 2);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (10, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_1.jpg', 3);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (11, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_5.jpg', 8);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (12, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_1.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (13, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_5.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (14, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/lamp_5.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (15, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_1.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (16, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/lamp_5.jpg', 1);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (17, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_4.jpg', 9);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (18, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/chair_3.jpg', 6);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (19, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_4.jpg', 16);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (20, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_4.jpg', 2);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (21, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_5.jpg', 8);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (22, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_2.jpg', 7);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (23, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_2.jpg', 14);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (24, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/chair_5.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (25, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_2.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (26, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_4.jpg', 16);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (27, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_4.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (28, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/table_5.jpg', 10);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (29, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/chair_1.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (30, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/chair_5.jpg', 4);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (31, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_5.jpg', 1);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (32, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/table_4.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (33, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_4.jpg', 16);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (34, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/lamp_4.jpg', 17);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (35, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/lamp_5.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (36, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/lamp_3.jpg', 8);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (37, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_1.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (38, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_2.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (39, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_2.jpg', 3);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (40, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_4.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (41, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/lamp_4.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (42, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/table_5.jpg', 13);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (43, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_4.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (44, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_3.jpg', 16);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (45, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/table_3.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (46, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/chair_4.jpg', 4);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (47, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_5.jpg', 5);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (48, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_4.jpg', 13);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (49, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_3.jpg', 8);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (50, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/chair_3.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (51, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_4.jpg', 4);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (52, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_4.jpg', 4);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (53, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_2.jpg', 3);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (54, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/chair_4.jpg', 16);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (55, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_3.jpg', 17);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (56, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/lamp_3.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (57, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_2.jpg', 10);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (58, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_1.jpg', 1);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (59, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_5.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (60, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_5.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (61, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_2.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (62, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/table_3.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (63, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/chair_3.jpg', 9);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (64, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_1.jpg', 17);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (65, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_4.jpg', 10);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (66, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_3.jpg', 1);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (67, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_3.jpg', 3);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (68, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_3.jpg', 2);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (69, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/chair_3.jpg', 6);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (70, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/table_4.jpg', 3);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (71, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/chair_3.jpg', 8);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (72, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_4.jpg', 1);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (73, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/table_5.jpg', 2);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (74, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/lamp_4.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (75, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_1.jpg', 4);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (76, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_5.jpg', 7);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (77, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/chair_5.jpg', 3);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (78, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/lamp_1.jpg', 3);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (79, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_3.jpg', 7);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (80, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/lamp_1.jpg', 10);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (81, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/chair_4.jpg', 6);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (82, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_2.jpg', 13);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (83, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_4.jpg', 17);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (84, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_3.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (85, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_2.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (86, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/table_2.jpg', 9);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (87, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/lamp_4.jpg', 5);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (88, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/chair_3.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (89, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_3.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (90, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_1.jpg', 1);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (91, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/table_2.jpg', 16);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (92, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/lamp_4.jpg', 17);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (93, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/lamp_3.jpg', 4);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (94, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_5.jpg', 11);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (95, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/chair_4.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (96, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/lamp_2.jpg', 2);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (97, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/table_2.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (98, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_2.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (99, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/lamp_4.jpg', 6);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (100, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_4.jpg', 5);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (101, 'A speheric object for a spheric world.', 'upload/bigimage2.jpg', NULL);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (102, 'See the beauty of this article in the glitter of the night.', 'upload/lamp_5_1.jpg', 22);
INSERT INTO "public"."bigimage" ("oid", "description", "picture", "productoid") VALUES (103, 'A mix of technology and innovative design that will add value to your h', 'upload/lamp_4.jpg', 22);


