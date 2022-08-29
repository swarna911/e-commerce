-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Idols & Figurines', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Wall Sculptures and Paintings', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Furnitures', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Flowers', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-06-23 23:03:26', 'Showpieces Metal Table Top Gold Ornament for Showcase', 'https://rukminim1.flixcart.com/image/416/416/l0o6nbk0/showpiece-figurine/a/s/a/8-13-5-radha-krishna-idol-statue-for-pooja-room-temple-home-d-original-imagcezg6duqbbyu.jpeg?q=70', 'Radha Krishna Idol Statue ', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-06-23 23:03:26', 'Statue Showpiece for Home Decor Diwali Decoration and Gifting', 'https://m.media-amazon.com/images/I/81AzD-hsl-L._SL1500_.jpg', 'Lord Ganesha Idol', 45.00, 0, 40, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-06-23 23:03:26', 'Statue Showpiece for Home Decor Diwali Decoration and Gifting', 'https://m.media-amazon.com/images/I/91FwdCVfcJL._SL1500_.jpg', 'Space Gingko Leaf', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF004', 0, '2022-06-23 23:03:26', 'Statue Showpiece for Home Decor Diwali Decoration and Gifting', 'https://m.media-amazon.com/images/I/712F6nYMHIL._SY450_.jpg', 'Lord Krishna Idol', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF005', 0, '2022-06-23 23:03:26', 'Statue Showpiece for Home Decor Diwali Decoration and Gifting', 'https://images-eu.ssl-images-amazon.com/images/I/410u9KimaLL._SX300_SY300_QL70_FMwebp_.jpg', 'Ganesh Idol for Car Dashboard', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF006', 0, '2022-06-23 23:03:26', 'Metal Lord Ganesha in Red Dhoti on Green Leaf Wall Hanging', 'https://cdn.igp.com/f_auto,q_auto,t_pnopt9prodlp/products/p-lord-ganesha-designer-large-metal-diya-120689-m.jpg', 'Metal Lord Ganesha', 45.00, 0, 50, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-06-23 23:03:26', 'Handmade Hand-Painted Wall Hanging', 'https://m.media-amazon.com/images/I/81v5h1qk9yL._SL1500_.jpg', 'Rajasthani Handcraft for Room Decoration', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-06-23 23:03:26', 'Multi Color Wall Arts for Home', 'https://m.media-amazon.com/images/I/61-u70PueWL._SL1100_.jpg', 'Metal Wall Decor Wall Hanging', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-06-23 23:03:26', 'Multi Color Wall Arts for Home', 'https://m.media-amazon.com/images/I/61ZVGaiZvuL._SX569_.jpg', ' Wall Decor Wall Hanging', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS004', 1, '2022-06-23 23:03:26', 'Multi Color Wall Arts for Home', 'https://images-eu.ssl-images-amazon.com/images/I/51mtrQTepOL._SY300_SX300_QL70_FMwebp_.jpg', ' Metal sculpture', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS005', 1, '2022-06-23 23:03:26', 'Multi Color Wall Arts for Home', 'https://m.media-amazon.com/images/I/612-pNeq9nS._SX466_.jpg', ' Wall sculpture with LED light', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS006', 1, '2022-06-23 23:03:26', 'Handmade Hand-Painted Wall Hanging', 'https://m.media-amazon.com/images/I/81krj32Fw4L._SY450_.jpg', 'Multicolour wall hanging for Room Decoration', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS007', 1, '2022-06-23 23:03:26', 'World Decor Led Couple Peacock Birds Metal Wall Art - Big, Multicolour', 'https://m.media-amazon.com/images/I/61LsEgD7uTL._SX679_.jpg', 'Led Couple Peacock Birds', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS008', 1, '2022-06-23 23:03:26', 'Fine Art Home Decor Metal Art & Craft Bird Ring Small with Led Light', 'https://m.media-amazon.com/images/I/61Jn7dwRwLL._SY450_.jpg', 'Home Decor Metal Art ', 73.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS009', 1, '2022-06-23 23:03:26', 'Hexagon Modern Art Dancing MDF Board UV Textured Painting', 'https://m.media-amazon.com/images/I/61FqLbUHA-S._SX450_.jpg', 'Modern Art Dancing MDF Board UV Textured Painting', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS0010', 1, '2022-06-23 23:03:26', 'Modern Art Multi Butterfly Unframed Painting For Wall Home Decorations ', 'https://images-eu.ssl-images-amazon.com/images/I/41OKxUesmYL._SX300_SY300_QL70_FMwebp_.jpg', 'Modern Art Multi Butterfly Unframed Painting For Wall Home Decorations ', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS0011', 1, '2022-06-23 23:03:26', 'Still Art Paintings Without Glass ', 'https://m.media-amazon.com/images/I/91N1e0H6BUS._SX679_.jpg', 'Still Art Paintings Without Glass ', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS0012', 1, '2022-06-23 23:03:26', 'Indianara Synthetic Painting With Frame ', 'https://n2.sdlcdn.com/imgs/j/h/v/Indianara-Synthetic-Painting-With-Frame-SDL413563049-1-7dcac.jpeg', 'Indianara Synthetic Painting With Frame ', 57.00, 0, 53, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-06-23 23:03:26', 'Ultra Modern Smart Luxury Bed With Couch', 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRrazszU03vxNAKm3Qk-QE5tTKKqQs-G_pnpHNPK_P3KETJ1MyXMQbJvgcftvFMkW01fB0N6MJZ9Lu6fALnRWZOfrIb1L8POagjyA9sMAo&usqp=CAE', 'Ultra Modern Smart Luxury Bed With Couch ', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-06-23 23:03:26', 'Designer Sofa Set:- Modern Puffy Sectional Design Luxury Furniture Sofa Set', 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSFMEwfSymTkeaygmzn_YnZ-VOXj5cgjD0tYtpTChM_8MRK5Cxl-O8NYedih2yoddDYlfFfGGVTiqIU7wRl68bDR-F8bRUtjBIsZ1GRJSPg&usqp=CAE','Designer Sofa Set', 45.00, 0, 40, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-06-23 23:03:26', 'Six Seater Dinning Table', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTauH0oRWmsx5uUzqLmKhf0jO_xk_HklW8fzP1_ANsLpB843s67_oCmIiFzJQAo8xQ8LCdaC009l7V2Sg-bz6DItuXK5zDxE63Ele5dkVY&usqp=CAE', 'Lead Solid Wodden Six seater Dinning Table', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA004', 2, '2022-06-23 23:03:26', 'Classic Complementing Golden Coffee Table', 'https://cdn.shopify.com/s/files/1/1306/4195/products/wallmantra-tables-classic-complementing-golden-coffee-table-set-of-2-33508633149606_1024x1024.jpg?v=1652707386', 'Classic Complementing Golden Coffee Table', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA005', 2, '2022-06-23 23:03:26', 'Selestin XL TV Unit', 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcS_MaUV-FLM7VDRFCoknIT9IM6lCWkWdxL-syQ7DfDJ5zXswE1TxZCqG3Br0YTWvGqhvX37HincGGBl_tP5StU8Dx54bd6c&usqp=CAE', 'Selestin XL TV Unit', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA006', 2, '2022-06-23 23:03:26', 'Anton Solid Wood Media Console', 'https://cdnext.fynd.com/image/data/Westelm/09-dec-2020/7518129_1.jpg?width=780&height=780&mode=fill&fill=solid&fill-color=FFFFFF', 'Anton Solid Wood Media Console', 45.00, 0, 50, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-06-23 23:03:26', 'unique flower- Fresh Flowers Bouquet Arrangement Indoor Plant-orchid bouquet', 'https://www.fnp.com/images/pr/l/v20180518121935/dark-pink-roses-arrangement_1.jpg', 'Fresh Flowers Bouquet  ', 90.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-06-23 23:03:26', 'Blooming Floret Artificial Cherry Orchid Flower Bunch', 'https://m.media-amazon.com/images/I/815sJ0c0n7L._SY879_.jpg', 'Artificial Cherry Orchid Flower', 76.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-06-23 23:03:26', 'unique flower- Fresh Flowers Bouquet Arrangement Indoor Plant-orchid bouquet', 'https://www.fnp.com/images/pr/l/v20210121175217/red-roses-bunch-in-you-have-my-heart-sticker-vase_1.jpg', 'Red Roses  ', 90.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF004', 3, '2022-06-23 23:03:26', 'Blooming Floret Artificial Cherry Orchid Flower Bunch', 'https://m.media-amazon.com/images/I/818A7lX8CUL._SY879_.jpg', 'Pollination Rich Artificial Light Pink Orchid Flowers', 76.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF005', 3, '2022-06-23 23:03:26', 'Fourwalls Beautiful Artificial Tulip Flower Bunch ', 'https://m.media-amazon.com/images/I/819zhtPix4L._SY606_.jpg', 'Fourwalls Beautiful Artificial Tulip Flower Bunch ', 76.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF006', 3, '2022-06-23 23:03:26', 'Pollination Rich Artificial Purple Orchid Flowers ', 'https://m.media-amazon.com/images/I/51fymP+XZsL._SY300_SX300_.jpg', 'Pollination Rich Artificial Purple Orchid Flowers ', 76.00, 0, 75, '2022-06-23 23:03:26');




------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');






CREATE SEQUENCE IF NOT EXISTS public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres;