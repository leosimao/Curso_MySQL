DROP DATABASE IF EXISTS  projeto_aula;
CREATE DATABASE projeto_aula;
USE projeto_aula;

CREATE TABLE estado(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(255) NOT NULL UNIQUE
    ,sigla CHAR(2) NOT NULL UNIQUE
    ,ativo CHAR (1) NOT NULL DEFAULT 'S'
);

CREATE TABLE cidade(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(255) NOT NULL
    ,ativo CHAR(1) NOT NULL DEFAULT 'S'
    ,id_estado INT NOT NULL
	,CONSTRAINT fk_cidade_estado FOREIGN KEY (id_estado) REFERENCES estado(id)
);

CREATE TABLE fazenda (
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(200) NOT NULL
    ,endereco VARCHAR(255)
    ,cep INT 
	,ativo CHAR(1) NOT NULL DEFAULT 'S'
    ,area_fazenda DECIMAL(10,2) NOT NULL
    ,id_cidade INT NOT NULL
    ,CONSTRAINT fk_fazenda_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id)
);

CREATE TABLE produto(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(200) NOT NULL UNIQUE
    ,cod_produto INT NOT NULL UNIQUE
    ,uni_medida CHAR(2) NOT NULL
    ,concentracao DECIMAL(10, 2) 
);

CREATE TABLE operacao(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(200) NOT NULL UNIQUE
    ,cod_operacao INT NOT NULL UNIQUE
    ,tipo_operacao VARCHAR(10) NOT NULL DEFAULT "MANUAL"
);

CREATE TABLE equipe(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(200) NOT NULL UNIQUE
    ,qt_integrantes INT NOT NULL

);

CREATE TABLE estoque(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,cod_estoque INT NOT NULL UNIQUE
    ,desc_estoque VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE equipamento(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,cod_equipamento INT NOT NULL UNIQUE
    ,tp_equipamento CHAR(1) NOT NULL DEFAULT 'T'
    ,dt_aquisicao DATETIME NOT NULL
    ,id_fazenda INT NOT NULL
    ,CONSTRAINT fk_equipamento_fazenda FOREIGN KEY (id_fazenda) REFERENCES fazenda(id)
);

CREATE TABLE aplicacao (
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,cod_aplicacao INT NOT NULL UNIQUE
    ,dt_aplicacao DATETIME NOT NULL
    ,qt_aplicacao DECIMAL(10, 2) NOT NULL 
	,area_aplicada DECIMAL(10, 2) NOT NULL
	,id_fazenda INT NOT NULL
    ,id_produto INT NOT NULL
    ,id_operacao INT NOT NULL
    ,id_equipe INT NOT NULL
    ,id_estoque INT NOT NULL
    ,id_equipamento INT NOT NULL
    ,CONSTRAINT fk_aplicacao_fazenda FOREIGN KEY (id_fazenda) REFERENCES fazenda(id)
    ,CONSTRAINT fk_aplicacao_produto FOREIGN KEY (id_produto) REFERENCES produto(id)
    ,CONSTRAINT fk_aplicacao_operacao FOREIGN KEY (id_operacao) REFERENCES operacao(id)
    ,CONSTRAINT fk_aplicacao_equipe FOREIGN KEY (id_equipe) REFERENCES equipe(id)
    ,CONSTRAINT fk_aplicacao_estoque FOREIGN KEY (id_estoque) REFERENCES estoque(id)
    ,CONSTRAINT fk_aplicacao_equipamento FOREIGN KEY (id_equipamento) REFERENCES equipamento(id)
);

CREATE TABLE ccusto(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,cod_ccusto INT NOT NULL UNIQUE
	,desc_ccusto VARCHAR(100) NOT NULL UNIQUE
    ,ativo CHAR(1) NOT NULL DEFAULT 'A'
);

CREATE TABLE custo(
	id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
	,dt_custo DATETIME NOT NULL
    ,qt_consumo DECIMAL(10, 2) NOT NULL
    ,vl_consumo DECIMAL(10, 2) NOT NULL
    ,ativo CHAR(1) NOT NULL DEFAULT 'A'
    ,id_aplicacao INT NOT NULL
    ,id_ccusto INT NOT NULL
    ,id_produto INT NOT NULL
    ,CONSTRAINT fk_custo_aplicacao FOREIGN KEY (id_aplicacao) REFERENCES aplicacao(id)
    ,CONSTRAINT fk_custo_ccusto FOREIGN KEY (id_ccusto) REFERENCES ccusto(id)
    ,CONSTRAINT fk_custo_produto FOREIGN KEY (id_produto) REFERENCES produto(id)
);

ALTER TABLE custo CHANGE dt_custo dt_historico DATETIME NOT NULL;
ALTER TABLE aplicacao ADD COLUMN dt_ultimo_update DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE custo ADD COLUMN dt_ultimo_update DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

INSERT INTO estado(nome, sigla) VALUES ('PARANA', 'PR');
INSERT INTO estado(nome, sigla) VALUES ('SAO PAULO', 'SP');
INSERT INTO estado(nome, sigla) VALUES ('RIO GRANDE DO SUL', 'RS');

INSERT INTO cidade(nome, id_estado) VALUES ('MARINGA', 1);
INSERT INTO cidade(nome, id_estado) VALUES ('SAO CARLOS', 2);
INSERT INTO cidade(nome, id_estado) VALUES ('SANTANA DO LIVRAMENTO', 3);

INSERT INTO fazenda(nome, endereco, cep, area_fazenda, id_cidade) 
	VALUES ('SANTA LUIZA', 'RODOVIA MANOEL ROCHA DE OLIVEIRA', '45526302', 45.8, 1);
INSERT INTO fazenda(nome, endereco, cep, area_fazenda, id_cidade) 
	VALUES('URUPES', 'RODOVIA ASSIS', 56694238, 87.2, 3);
INSERT INTO fazenda(nome, endereco, cep, area_fazenda, id_cidade) 
	VALUES('MINUANO', 'RODOVIA DO CAFE', 8522460, 37.5, 2);

INSERT INTO produto(nome, cod_produto, uni_medida, concentracao)
	VALUES('EUPROFF', 32265, 'LT', 20.2);
INSERT INTO produto(nome, cod_produto, uni_medida, concentracao)
	VALUES ('COMET', 52242, 'LT', 52.8);
INSERT INTO produto(nome, cod_produto, uni_medida, concentracao)
	VALUES('CALCARIO', 41232, 'KG', '0.75');
    
INSERT INTO operacao(nome, cod_operacao, tipo_operacao)
	VALUES('PULVERIZACAO PROGRAMADA', 132, 'MECANIZADA');
INSERT INTO operacao(nome, cod_operacao, tipo_operacao)
	VALUES('HERBICIDA', 130, 'MANUAL');
INSERT INTO operacao(nome, cod_operacao, tipo_operacao)
	VALUES('ADUBACAO', 145, 'AEREA');

INSERT INTO equipe(nome, qt_integrantes)  VALUES('TURMA DO TIKO', 20);
INSERT INTO equipe(nome, qt_integrantes)  VALUES('TURMA DO PEDRO', 10);
INSERT INTO equipe(nome, qt_integrantes)  VALUES('TURMA DA CARLA', 30);

INSERT INTO equipamento(cod_equipamento, tp_equipamento, dt_aquisicao, id_fazenda) VALUES (222, 'T', '2021-01-27', 2);
INSERT INTO equipamento(cod_equipamento, tp_equipamento, dt_aquisicao, id_fazenda) VALUES (249, 'T', '2021-04-01', 1);
INSERT INTO equipamento(cod_equipamento, tp_equipamento, dt_aquisicao, id_fazenda) VALUES (232, 'T', '2022-05-30', 3);

INSERT INTO estoque(cod_estoque, desc_estoque) VALUES (100, 'ESTOQUE SANTA LUIZA');
INSERT INTO estoque(cod_estoque, desc_estoque) VALUES (101, 'ESTOQUE URUPES');
INSERT INTO estoque(cod_estoque, desc_estoque) VALUES (102, 'ESTOQUE MINUANO');

INSERT INTO aplicacao(cod_aplicacao, dt_aplicacao, qt_aplicacao, area_aplicada, id_fazenda, id_produto, id_operacao, id_equipe, id_estoque, id_equipamento)
	VALUES(2500, '2022-07-04', 12, 35.7, 2, 1, 3, 2, 1, 2);
INSERT INTO aplicacao(cod_aplicacao, dt_aplicacao, qt_aplicacao, area_aplicada, id_fazenda, id_produto, id_operacao, id_equipe, id_estoque, id_equipamento)
	VALUES(2501,'2022-05-20', 37, 25.4, 1, 2, 1, 3, 1, 1);
INSERT INTO aplicacao(cod_aplicacao, dt_aplicacao, qt_aplicacao, area_aplicada, id_fazenda, id_produto, id_operacao, id_equipe, id_estoque, id_equipamento)
	VALUES(2502, '2022-03-04', 48, 45.9, 3, 3, 2, 1, 3, 2);
    
INSERT INTO ccusto(cod_ccusto, desc_ccusto) VALUES (420001, 'TRATOS CULTURAIS SANTA LUIZA');
INSERT INTO ccusto(cod_ccusto, desc_ccusto) VALUES (420002, 'TRATOS CULTURAIS URUPES');
INSERT INTO ccusto(cod_ccusto, desc_ccusto) VALUES (420003, 'TRATOS CULTURAIS MINUANO');

INSERT INTO custo(dt_historico, qt_consumo, vl_consumo, id_aplicacao, id_ccusto, id_produto) VALUES ('2022-05-30', 320.5, 50.00, 2, 1, 2);
INSERT INTO custo(dt_historico, qt_consumo, vl_consumo, ativo, id_aplicacao, id_ccusto, id_produto) VALUES ('2022-04-05', 1000, 10.00, 'F', 3, 3, 1);
INSERT INTO custo(dt_historico, qt_consumo, vl_consumo, id_aplicacao, id_ccusto, id_produto) VALUES ('2022-07-16', 320.5, 50.00, 1, 2, 3);

UPDATE equipe SET qt_integrantes = 15 WHERE id = 1;
UPDATE operacao SET tipo_operacao = 'MECANIZADA' WHERE cod_operacao = 145;
UPDATE ccusto SET ativo = 'F' WHERE cod_ccusto = 420003;
/*
Irei colocar o DELETE aqui dentro para que n??o intefira em nenhum resultado distinto da modelagem
	DELETE FROM fazenda WHERE id_cidade = 1;
    DELETE FROM aplicacao;
    DELETE FROM equipamento WHERE cod_equipamento = 232
*/
SELECT 
	e.nome 
    ,e.ativo
FROM 
	estado e
WHERE e.ativo = 'S';    

SELECT * FROM cidade;
SELECT * FROM fazenda;
SELECT * FROM produto;
SELECT * FROM operacao;
SELECT * FROM equipe;
SELECT * FROM estoque;
SELECT * FROM equipamento;

SELECT  
		fz.nome
        ,eqp.cod_equipamento
        ,opr.nome
        ,prd.nome
        ,c.qt_consumo
        ,c.vl_consumo
FROM 
	aplicacao ap
	
	INNER JOIN fazenda fz on fz.id = ap.id_fazenda
    INNER JOIN equipamento eqp on eqp.id = ap.id_equipamento
    INNER JOIN produto prd on prd.id = ap.id_produto
    INNER JOIN custo c on c.id_aplicacao = ap.id AND c.id_produto = prd.id
    INNER JOIN operacao opr on opr.id = ap.id_operacao
    
;
SELECT  
	cc.cod_ccusto
	,cc.desc_ccusto
FROM 
	ccusto cc
WHERE
	cc.cod_ccusto = 420002;

SELECT 
	c.dt_historico
    ,c.qt_consumo
    ,c.vl_consumo
FROM
	custo c
    
WHERE c.ativo = 'A';