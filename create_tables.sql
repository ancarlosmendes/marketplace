/*
Script DDL para criação de tabelas para banco PostgreSQL do modelo ecommerce do Mercado Livre
Data de criação: 01/05/2022
Autor: Antônio Mendes
Versão do SGBD PostgreSQL: 14
Nome do database: db_ecommerce
*/
 
/* Definição de sequence para geração automática de valor da chave primária */
CREATE SEQUENCE public.sq_categoria;

/* Tabela de categorias do site */
CREATE TABLE public.tb_categoria (
                id_categoria INTEGER NOT NULL DEFAULT nextval('public.sq_categoria'),
                nome_categoria VARCHAR(40) NOT NULL,
                path_categoria VARCHAR(60) NOT NULL,
                id_categoria_pai INTEGER,
                CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);
COMMENT ON TABLE public.tb_categoria IS 'Tabela de categorias do site';
COMMENT ON COLUMN public.tb_categoria.id_categoria IS 'Identificador da Categoria';
COMMENT ON COLUMN public.tb_categoria.nome_categoria IS 'Descrição da categoria';
COMMENT ON COLUMN public.tb_categoria.id_categoria_pai IS 'Identificador da Categoria Pai';


ALTER SEQUENCE public.sq_categoria OWNED BY public.tb_categoria.id_categoria;

CREATE SEQUENCE public.sq_item;

/* Tabela os produtos publicados no marketplac */
CREATE TABLE public.tb_item (
                id_item INTEGER NOT NULL DEFAULT nextval('public.sq_item'),
                nome_item VARCHAR(60) NOT NULL,
                preco_item DOUBLE PRECISION NOT NULL,
                end_date DATE,
                status_item BIT NOT NULL,
                id_categoria INTEGER NOT NULL,
                CONSTRAINT pk_item PRIMARY KEY (id_item)
);
COMMENT ON TABLE public.tb_item IS 'Tabela os produtos publicados no marketplace';
COMMENT ON COLUMN public.tb_item.id_item IS 'Identificador do Item';
COMMENT ON COLUMN public.tb_item.nome_item IS 'Descrição do produto';
COMMENT ON COLUMN public.tb_item.preco_item IS 'Preço do Produto';
COMMENT ON COLUMN public.tb_item.end_date IS 'Data Final de Publicação';
COMMENT ON COLUMN public.tb_item.status_item IS 'Identifica o estado de um produto';
COMMENT ON COLUMN public.tb_item.id_categoria IS 'Identificador da Categoria';


ALTER SEQUENCE public.sq_item OWNED BY public.tb_item.id_item;

CREATE SEQUENCE public.sq_item_hist;

/* Tabela para carga de itens com o preço e estado no final de cada dia */
CREATE TABLE public.tb_item_hist (
                id_item_hist INTEGER NOT NULL DEFAULT nextval('public.sq_item_hist'),
                id_item INTEGER NOT NULL,
                data_registro DATE NOT NULL,
                preco_item_hist VARCHAR NOT NULL,
                status_item_hist BIT NOT NULL,
                CONSTRAINT pk_item_hist PRIMARY KEY (id_item_hist)
);
COMMENT ON TABLE public.tb_item_hist IS 'Tabela para carga de itens com o preço e estado no final de cada dia.';
COMMENT ON COLUMN public.tb_item_hist.id_item IS 'Identificador do Item';
COMMENT ON COLUMN public.tb_item_hist.data_registro IS 'Data de inserção do registro';
COMMENT ON COLUMN public.tb_item_hist.preco_item_hist IS 'Histórico de preço do item ';
COMMENT ON COLUMN public.tb_item_hist.status_item_hist IS 'Histórico de estado do item';


ALTER SEQUENCE public.sq_item_hist OWNED BY public.tb_item_hist.id_item_hist;

CREATE SEQUENCE public.sq_customer;

/* Tabela de usuários (buyers e sellers) do site */
CREATE TABLE public.tb_customer (
                id_customer INTEGER NOT NULL DEFAULT nextval('public.sq_customer'),
                nome_customer VARCHAR(20) NOT NULL,
                sobrenome_customer VARCHAR(20) NOT NULL,
                sexo_customer VARCHAR(1) DEFAULT 'M' NOT NULL,
                endereco_customer VARCHAR(60),
                data_nasc_customer DATE NOT NULL,
                CONSTRAINT pk_customer PRIMARY KEY (id_customer)
);
COMMENT ON TABLE public.tb_customer IS 'Tabela de usuários (buyers e sellers) do site';
COMMENT ON COLUMN public.tb_customer.nome_customer IS 'Nome Customer';
COMMENT ON COLUMN public.tb_customer.sobrenome_customer IS 'Sobrenome do Customer';
COMMENT ON COLUMN public.tb_customer.sexo_customer IS 'Sexo do Customer';
COMMENT ON COLUMN public.tb_customer.endereco_customer IS 'Endereço do Customer';
COMMENT ON COLUMN public.tb_customer.data_nasc_customer IS 'Data Nascimento Customer';


ALTER SEQUENCE public.sq_customer OWNED BY public.tb_customer.id_customer;

CREATE SEQUENCE public.sq_order;

/* Tabela de transações geradas dentro do site (cada compra é uma order) */
CREATE TABLE public.tb_order (
                id_order INTEGER NOT NULL DEFAULT nextval('public.sq_order'),
                id_customer INTEGER NOT NULL,
                data_order DATE NOT NULL,
                valor_total_order NUMERIC NOT NULL,
                CONSTRAINT pk_order PRIMARY KEY (id_order)
);
COMMENT ON TABLE public.tb_order IS 'Tabela de transações geradas dentro do site
(cada compra é uma order)';
COMMENT ON COLUMN public.tb_order.id_order IS 'Identificador da Order de Compra';
COMMENT ON COLUMN public.tb_order.data_order IS 'Data da order';
COMMENT ON COLUMN public.tb_order.valor_total_order IS 'Valor total order';


ALTER SEQUENCE public.sq_order OWNED BY public.tb_order.id_order;

/* Tabela de itens vendidos em uma order */
CREATE TABLE public.tb_item_order (
                id_order INTEGER NOT NULL,
                id_item INTEGER NOT NULL,
                quant_item_order INTEGER NOT NULL,
                CONSTRAINT pk_item_order PRIMARY KEY (id_order, id_item)
);
COMMENT ON TABLE public.tb_item_order IS 'Tabela de itens vendidos em uma order';
COMMENT ON COLUMN public.tb_item_order.id_order IS 'Identificador da Order';
COMMENT ON COLUMN public.tb_item_order.id_item IS 'Identificador do Item';
COMMENT ON COLUMN public.tb_item_order.quant_item_order IS 'Quantidade do Item Order';

/* Definição de restrições de integridade */ 
ALTER TABLE public.tb_item ADD CONSTRAINT fk_item_categoria_id_categoria
FOREIGN KEY (id_categoria)
REFERENCES public.tb_categoria (id_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.tb_categoria ADD CONSTRAINT fk_categoria_id_categoria
FOREIGN KEY (id_categoria_pai)
REFERENCES public.tb_categoria (id_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.tb_item_order ADD CONSTRAINT fk_item_order_item_id_item
FOREIGN KEY (id_item)
REFERENCES public.tb_item (id_item)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.tb_item_hist ADD CONSTRAINT fk_item_hist_item_id_item
FOREIGN KEY (id_item)
REFERENCES public.tb_item (id_item)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.tb_order ADD CONSTRAINT fk_order_customer_id_customer
FOREIGN KEY (id_customer)
REFERENCES public.tb_customer (id_customer)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.tb_item_order ADD CONSTRAINT fk_item_order_order_id_order
FOREIGN KEY (id_order)
REFERENCES public.tb_order (id_order)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;