/* 
Scripts DML e DDL para resolução de questões 
Autor: Antônio Mendes
Data: 02/05/2022
Observação: é possível executar a carga de dados (Script DML de carga de dados) para testes e validação dos tópicos
seguintes
*/

/* Question 1) Listing the users for their birthdays today and sales on January, 2020 will be more than 1500
Resolução: a construção da query teve como investigação o uso efetivo da função AGE do PGSQL, para 
identificar os usuários que são aniversariantes no dia corrente. E a complementação de uma subconsulta 
com uso da cláusula EXISTS serviu para definir as regras dos filtros requeridos.
*/
SELECT csr.id_customer
, csr.nome_customer
, csr.sobrenome_customer
, csr.data_nasc_customer
, age(current_date, csr.data_nasc_customer) idade
, EXTRACT(YEAR FROM age(current_date, csr.data_nasc_customer)) anos
, EXTRACT(MONTH FROM age(current_date, csr.data_nasc_customer)) meses
, EXTRACT(DAY FROM age(current_date, csr.data_nasc_customer)) dias
FROM tb_customer csr
WHERE EXTRACT(MONTH FROM age(current_date, csr.data_nasc_customer)) = 0
AND EXTRACT(DAY FROM age(current_date, csr.data_nasc_customer)) = 0
AND EXISTS (
	        SELECT ord.id_customer
		    FROM tb_order ord
		    WHERE ord.id_customer = csr.id_customer
			AND EXTRACT(YEAR FROM ord.data_order) = '2020'
	        AND EXTRACT(MONTH FROM ord.data_order) = '01'
	        AND ord.valor_total_order > 1500
		   )
		   		   
/* 

	Question 2) For each month of 2020, they asked for viewing at least 5 based on sales from users  ($) 
na categoria 'Celulares' 


	Resolução: foi criada uma função para identificar o rank dos vendedores, a partir de um ano de vendas.
	Neste bloco é possível listar os cinco usuários que mais venderam na categoria em questão. 

*/

/* Tabela rank_vendedores precisa ser criada como suporte à estrutura de dados necessária para o retorno de linhas a partir da função */
CREATE TABLE rank_vendedores (mes_venda numeric, id_vendedor int, nome varchar(20), sobrenome varchar(20), id_categoria int, quant_vendas bigint, quant_produtos bigint, total_vendido numeric);

/* Script de criação da função fn_rank_vendedores */
CREATE FUNCTION fn_rank_vendedores(ano_venda int) RETURNS SETOF rank_vendedores AS
$BODY$
DECLARE 
	MaioresVendas rank_vendedores%rowtype;
BEGIN

	FOR mes_venda in 1..12 LOOP

		FOR MaioresVendas IN				
			SELECT EXTRACT(MONTH FROM ord.data_order) MesAnalise
			, csr.id_customer
			, csr.nome_customer
			, csr.sobrenome_customer
			, caa.id_categoria
			, count(ord.id_order) QuantVendas
			, sum(ito.quant_item_order) QuantProdutos
			, sum(ord.valor_total_order) TotalVendido
			FROM tb_order ord
			INNER JOIN tb_customer csr ON (csr.id_customer = ord.id_customer) 
			INNER JOIN tb_item_order ito ON (ord.id_order = ito.id_order)
			INNER JOIN tb_item itm ON (itm.id_item = ito.id_item)
			INNER JOIN tb_categoria caa ON (caa.id_categoria = itm.id_categoria)
			WHERE caa.nome_categoria LIKE 'Celulares%'
			AND EXTRACT(YEAR FROM ord.data_order) =  ano_venda
			AND EXTRACT(MONTH FROM ord.data_order) = mes_venda
			GROUP BY EXTRACT(MONTH FROM ord.data_order) 
			, EXTRACT(YEAR FROM ord.data_order) 
			, csr.id_customer
			, csr.nome_customer
			, csr.sobrenome_customer
			, caa.id_categoria
			ORDER BY MesAnalise
			, QuantVendas Desc
			, QuantProdutos Desc
			, TotalVendido Desc
			LIMIT 5
		LOOP		

			RETURN NEXT MaioresVendas; -- retorna linha corrent do SELECT				
		END LOOP;		
	
	END LOOP;		
	
	RETURN; 
	
END
$BODY$
LANGUAGE plpgsql;

/* Instrução DML para carregar dados de usuáiros que mais venderam em 2020 */
SELECT * FROM fn_rank_vendedores(2020);

/* Question 3) Promover a criação de uma nova tabela e realizar a carga de dados com o preço e estado dos itens no final do dia, considerando que esse processo deve permitir um reprocesso.
   
   Resolução: foi criado o procedimento "pr_popular_item_hist()" descrito a seguir, para realizar a inserção de dados na 
   tabela de histórico de itens (produtos) no final do dia.
   Nesta primeira versão, procuramos identificar cada item, realizando uma iteração para inserção de itens como histórico.
   Como também, possibilitará a atualização de dados históricos, caso seja realizado um reprocesso do procedimento no mesmo dia.  
*/

CREATE OR REPLACE PROCEDURE public.pr_popular_item_hist(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE

item_rec record;

BEGIN

    FOR item_rec IN (SELECT id_item, nome_item, CURRENT_DATE data_registro, preco_item, status_item FROM tb_item ORDER BY id_item)
    LOOP
        DELETE FROM tb_item_hist WHERE id_item = item_rec.id_item AND data_registro = CURRENT_DATE;
        INSERT INTO tb_item_hist (id_item, data_registro, preco_item_hist, status_item_hist) VALUES (item_rec.id_item, CURRENT_DATE, item_rec.preco_item, item_rec.status_item);        
        RAISE NOTICE 'Item atualizado - ID : % , Nome : %', item_rec.id_item,item_rec.nome_item;

    END LOOP;

END;
$BODY$;
ALTER PROCEDURE public.pr_popular_item_hist()
    OWNER TO postgres;

COMMENT ON PROCEDURE public.pr_popular_item_hist()
    IS 'Procedimento responsável por popular a tabela de histórico de itens com o preço e estado no final do dia.';

/* Instrução para executar procedimento */
CALL pr_popular_item_hist();

