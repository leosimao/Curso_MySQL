DROP DATABASE IF EXISTS  projeto_aula;
CREATE DATABASE projeto_aula;
USE projeto_aula;

CREATE TABLE estado(
	id_estado INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(255) NOT NULL UNIQUE
    ,sigla CHAR(2) NOT NULL UNIQUE
    ,ativo CHAR (1) NOT NULL DEFAULT 'S'
);

CREATE TABLE cidade(
	id_cidade INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(255) NOT NULL
    ,ativo CHAR(1) NOT NULL DEFAULT 'S'
    ,id_estado INT NOT NULL
	,CONSTRAINT fk_cidade_estado FOREIGN KEY (id_estado) REFERENCES estado(id_estado)
);

CREATE TABLE fazenda (
	id_fazenda INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(200) NOT NULL
    ,endereco VARCHAR(255)
    ,cep INT 
	,ativo CHAR(1) NOT NULL DEFAULT 'S'
    ,area_fazenda DECIMAL(10,2) NOT NULL
    ,id_cidade INT NOT NULL
    ,CONSTRAINT fk_fazenda_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);

CREATE TABLE produto(
	id_produto INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(200) NOT NULL UNIQUE
    ,cod_produto INT NOT NULL UNIQUE
    ,uni_medida CHAR(2) NOT NULL
    ,concentracao DECIMAL(10, 2) 
);

CREATE TABLE operacao(
	id_operacao INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(200) NOT NULL UNIQUE
    ,cod_operacao INT NOT NULL UNIQUE
    ,tipo_operacao VARCHAR(10) NOT NULL DEFAULT "MANUAL"
);

CREATE TABLE equipe(
	id_equipe INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,nome VARCHAR(200) NOT NULL UNIQUE
    ,qt_integrantes INT NOT NULL

);

CREATE TABLE estoque(
	id_estoque INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,cod_estoque INT NOT NULL UNIQUE
    ,desc_estoque VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE equipamento(
	id_equipamento INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,cod_equipamento INT NOT NULL UNIQUE
    ,tp_equipamento CHAR(1) NOT NULL DEFAULT 'T'
    ,dt_aquisicao DATETIME NOT NULL
    ,id_fazenda INT NOT NULL
    ,CONSTRAINT fk_equipamento_fazenda FOREIGN KEY (id_fazenda) REFERENCES fazenda(id_fazenda)
);

CREATE TABLE aplicacao (
/*
COLCOCAR AS NOVAS FK E ADICIONAR AS NOVAS TABELAS DENTRO DO MODELO
*/
	id_aplicacao INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,cod_aplicacao INT NOT NULL UNIQUE
    ,dt_aplicacao DATETIME NOT NULL
    ,qt_aplicacao DECIMAL(10, 2) NOT NULL 
	,area_aplicada DECIMAL(10, 2) NOT NULL
	,id_fazenda INT NOT NULL
    ,id_produto INT NOT NULL
    ,id_operacao INT NOT NULL
    ,id_equipe INT NOT NULL
    ,id_estoque INT NOT NULL
    ,CONSTRAINT fk_aplicacao_fazenda FOREIGN KEY (id_fazenda) REFERENCES fazenda(id_fazenda)
    ,CONSTRAINT fk_aplicacao_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
    ,CONSTRAINT fk_aplicacao_operacao FOREIGN KEY (id_operacao) REFERENCES operacao(id_operacao)
    ,CONSTRAINT fk_aplicacao_equipe FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe)
    ,CONSTRAINT fk_aplicacao_estoque FOREIGN KEY (id_deposito) REFERENCES estoque(id_estoque)
    ,CONSTRAINT fk_aplicacao_equipamento FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento)
);

CREATE TABLE ccusto(
	id_ccusto INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
    ,cod_ccusto INT NOT NULL UNIQUE
	,desc_ccusto VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE custos(
	id_custo INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT
	,dt_custo DATETIME NOT NULL
    ,qt_consumida DECIMAL(10, 2), NOT NULL
    ,ativo CHAR(1) NOT NULL DEFAULT 'ABERTO'
    ,id_aplicacao INT NOT NULL
    ,id_ccusto INT NOT NULL
    ,CONSTRAINT fk_custos_aplicacao FOREIGN KEY (id_aplicacao) REFERENCES aplicacao(id_aplicacao)
    ,CONSTRAINT fk_custos_ccusto FOREIGN KEY (id_ccusto) REFERENCES ccusto(id_ccusto)


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

INSERT INTO aplicacao(cod_aplicacao, dt_aplicacao, qt_aplicacao, area_aplicada, id_fazenda, id_produto, id_operacao, id_equipe)
	VALUES(2500, '2022-07-04', 12, 35.7, 2, 1, 3, 2);
INSERT INTO aplicacao(cod_aplicacao, dt_aplicacao, qt_aplicacao, area_aplicada, id_fazenda, id_produto, id_operacao, id_equipe)
	VALUES(2501,'2022-05-20', 37, 25.4, 1, 2, 1, 3);
INSERT INTO aplicacao(cod_aplicacao, dt_aplicacao, qt_aplicacao, area_aplicada, id_fazenda, id_produto, id_operacao, id_equipe)
	VALUES(2502, '2022-03-04', 48, 45.9, 3, 3, 2, 1);
    
INSERT INTO equipamento(cod_equipamento, tp_equipamento, dt_aquisicao, id_fazenda) 
	VALUES (222, 'T', 2021-01-27, 2)