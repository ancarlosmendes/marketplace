/*
Script DML de carga de dados após execução do Script de definição de dados nomeado como "create_tables.sql"
Autor: Antonio Mendes
Data de criação: 02/05/2022
*/

/* Script DML de carga de dados de usuários */
INSERT INTO public.tb_customer(
	nome_customer, sobrenome_customer, sexo_customer, endereco_customer, data_nasc_customer)
	VALUES ('ANTONIO', 'MENDES', 'M', '336 Main St', '1978-05-03');
INSERT INTO public.tb_customer(
	nome_customer, sobrenome_customer, sexo_customer, endereco_customer, data_nasc_customer)
	VALUES ('ERIKA', 'BASTOS', 'F', '120 Younger St', '1979-05-04');
INSERT INTO public.tb_customer(
	nome_customer, sobrenome_customer, sexo_customer, endereco_customer, data_nasc_customer)
	VALUES ('LUCAS', 'OLIVEIRA', 'M', '225 Queen St', '2000-08-09');
INSERT INTO public.tb_customer(
	nome_customer, sobrenome_customer, sexo_customer, endereco_customer, data_nasc_customer)
	VALUES ('ANTONIO', 'BASTOS', 'M', '50 Road St', '1979-05-04');
INSERT INTO public.tb_customer(
	nome_customer, sobrenome_customer, sexo_customer, endereco_customer, data_nasc_customer)
	VALUES ('LEIA', 'BASTOS', 'F', '50 Road St', '2021-05-05');
INSERT INTO public.tb_customer(
	nome_customer, sobrenome_customer, sexo_customer, endereco_customer, data_nasc_customer)
	VALUES ('JOSE', 'MARIO', 'M', '50 Dundas St', '2021-05-04');	
	
/* Script de carga de dados de categorias do site */
INSERT INTO public.tb_categoria(
	nome_categoria, path_categoria, id_categoria_pai)
	VALUES ('Tecnologia', '', NULL);
	
INSERT INTO public.tb_categoria(
	nome_categoria, path_categoria, id_categoria_pai)
	VALUES ('Celulares e Telefones', '', 1);

INSERT INTO public.tb_categoria(
	nome_categoria, path_categoria, id_categoria_pai)
	VALUES ('Celulares e Smartphones', '', 1);

/* Script de carga de dados de produtos do site */
INSERT INTO public.tb_item(
	nome_item, preco_item, status_item, end_date, id_categoria)
	VALUES ('Samsung Galaxy A12 Dual SIM 64 GB vermelho 4 GB RAM', 1500, '1', NULL, 2);
	
INSERT INTO public.tb_item(
	nome_item, preco_item, status_item, end_date, id_categoria)
	VALUES ('Samsung Galaxy Note20 5G 256 GB cinza-místico 8 GB RAM', 1550, '1', NULL, 2);
	
INSERT INTO public.tb_item(
	nome_item, preco_item, status_item, end_date, id_categoria)
	VALUES ('Samsung Galaxy S21+ 5G 128 GB prata 8 GB RAM', 1800, '1', NULL, 3);
	
INSERT INTO public.tb_item(
	nome_item, preco_item, status_item, end_date, id_categoria)
	VALUES ('Samsung Galaxy S18+ 5G 128 GB prata 8 GB RAM', 1000, '1', NULL, 2);
	
	
/* Script de carga de dados de ordens de compra do site */	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (1, '2020-01-20 14:00:00', 3000);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (2, '2020-01-20 16:00:00', 1800);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (3, '2020-01-20 15:00:00', 1550);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (4, '2020-01-19 15:00:00', 1500);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (5, '2020-01-20 10:00:00', 1800);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (5, '2020-02-10 10:00:00', 1800);

INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (6, '2020-01-10 10:00:00', 5000);

INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (1, '2020-02-20 14:00:00', 3000);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (2, '2020-02-20 16:00:00', 1800);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (3, '2020-02-20 15:00:00', 1550);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (4, '2020-02-19 15:00:00', 1500);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (5, '2020-02-20 10:00:00', 1800);
	
INSERT INTO public.tb_order(
	id_customer, data_order, valor_total_order)
	VALUES (6, '2020-02-10 10:00:00', 5000);
	
/* Script de carga de dados de itens vendidos em uma ordem do site */		
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (1, 1, 2);
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (2, 3, 1);
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (3, 2, 1);
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (4, 1, 1);
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (5, 3, 1);	
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (6, 3, 1);		
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (7, 4, 5);		
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (8, 1, 2);
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (9, 3, 1);
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (10, 2, 1);
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (11, 1, 1);
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (12, 3, 1);	
	
INSERT INTO public.tb_item_order(
	id_order, id_item, quant_item_order)
	VALUES (13, 3, 1);