CREATE DATABASE ExerciciodeRevisao5
USE ExerciciodeRevisao5

CREATE TABLE Fornecedor (
codigo			int			not null,
nome			varchar(40)	not null,
atividade		varchar(40)	not null,
telefone		char(8)		not null
Primary Key (codigo)
)
Go

CREATE TABLE Cliente (
codigo			int				not null,
nome			varchar(50)		not null,
logradouro		varchar(80)		not null,
num				int				not null,
telefone		char(8)			not null,
data_nasc		date			not null
Primary Key (codigo)
)
Go

CREATE TABLE Produto (
codigo				int				not null,
nome				varchar(50)		not null,
valorU				decimal(7,2)	not null,
quant				int				not null,
descricao			varchar(50)		not null,
codigo_fornecedor	int				not null
Primary Key (codigo)
Foreign key (codigo_fornecedor)
	References Fornecedor (codigo)
)
Go

CREATE TABLE Pedido (
codigo					int				not null,
codigo_cliente			int				not null,
codigo_produto			int				not null,
quant					int				not null,
previsao_entrega		date			not null
Primary Key (codigo)
Foreign Key (codigo_cliente) References Cliente (codigo),
Foreign Key (codigo_produto) References Produto (codigo)
)
Go

INSERT INTO Fornecedor VALUES 
(1001,	'Estrela',	'Brinquedo',	'41525898'),
(1002,	'Lacta',	'Chocolate',	'42698596'),
(1003,	'Asus',	'Informática',	'52014596'),
(1004,	'Tramontina',	'Utensílios Domésticos',	'50563985'),
(1005,	'Grow',	'Brinquedos',	'47896325'),
(1006,	'Mattel',	'Bonecos',	'59865898')

INSERT INTO Cliente VALUES 
(33601,	'Maria Clara',	'R. 1° de Abril',	870,	'96325874',	'2000-08-15'),
(33602,	'Alberto Souza',	'R. XV de Novembro',	987,	'95873625'	,	'1985-02-02'),
(33603,	'Sonia Silva',	'R. Voluntários da Pátria',	1151,	'75418596'	,	'1957-08-23'),
(33604,	'José Sobrinho',	'Av. Paulista',	250,	'85236547',	'1986-12-09'),
(33605,	'Carlos Camargo',	'Av. Tiquatira',	9652,	'75896325',	'1971-03-25')
Go

INSERT INTO Produto VALUES 
(1,	'Banco Imobiliário',	65.00,	15,	'Versão Super Luxo',	1001),
(2,	'Puzzle 5000 peças',	50.00,	5,	'Mapas Mundo',	1005),
(3,	'Faqueiro',	350.00,	0,	'120 peças',	1004),
(4,	'Jogo para churrasco',	75.00,	3,	'7 peças',	1004),
(5,	'Tablet',	750.00,	29,	'Tablet',	1003),
(6,	'Detetive',	49.00,	0,	'Nova Versão do Jogo',	1001),
(7,	'Chocolate com Paçoquinha',	6.00,	0,	'Barra',	1002),
(8,	'Galak',	5.00,	65,	'Barra',	1002)
Go

INSERT INTO Pedido VALUES
(99001,	33601,	1,	1,	'2012-06-07'),
(99002,	33601,	2,	1,	'2012-06-07'),
(99003,	33601,	8,	3,	'2012-06-07'),
(99004,	33602,	2,	1,	'2012-06-09'),
(99005,	33602,	4,	3,	'2012-06-09'),
(99006,	33605,	5,	1,	'2012-06-15')

--Consultar a quantidade, valor total e valor total com desconto (25%) dos itens comprados par Maria Clara.
SELECT Produto.quant, SUM(Produto.quant * valorU), SUM((Produto.quant * ValorU)*0.75) As ValorTotal_com_desconto
FROM Produto INNER JOIN Pedido
ON Produto.codigo = Pedido.codigo_produto
INNER JOIN Cliente
ON Cliente.codigo = Pedido.codigo_cliente
WHERE Cliente.nome = 'Maria Clara'
GROUP BY Produto.quant, Produto.valorU
--Verificar quais brinquedos não tem itens em estoque.
SELECT nome FROM Produto
WHERE quant = 0
--Alterar para reduzir em 10% o valor das barras de chocolate.
UPDATE Produto
SET valorU = valorU*0.90 + valorU
WHERE descricao = 'Barra'
--Alterar a quantidade em estoque do faqueiro para 10 peças.
UPDATE Produto
SET quant = 10
WHERE descricao = 'Faqueiro'
--Consultar quantos clientes tem mais de 40 anos.
SELECT COUNT (DATEDIFF(DAY, data_nasc, GETDATE())/365)
FROM Cliente
WHERE DATEDIFF(DAY, data_nasc, GETDATE())/365 > 40
--Consultar Nome e telefone dos fornecedores de Brinquedos e Chocolate.
SELECT nome, telefone 
FROM Fornecedor
WHERE atividade = 'Brinquedo' or atividade= 'Chocolate'
--Consultar nome e desconto de 25% no preço dos produtos que custam menos de R$50,00
SELECT nome, CONVERT(DECIMAL(7,2),ValorU * 0.75)
FROM Produto
WHERE valorU < 50.00
--Consultar nome e aumento de 10% no preço dos produtos que custam mais de R$100,00
SELECT nome,  CONVERT(DECIMAL(7,2),ValorU * 1.10) 
FROM Produto
WHERE valorU > 100
--Consultar desconto de 15% no valor total de cada produto da venda 99001.
SELECT SUM(CONVERT(DECIMAL(7,2),(Pedido.quant * valorU) * 0.75)) 
FROM Produto inner Join Pedido
ON Produto.codigo = Pedido.codigo_produto
WHERE Pedido.codigo = 99001
--Consultar Código do pedido, nome do cliente e idade atual do cliente
SELECT codigo, nome, DATEDIFF(DAY, data_nasc, GETDATE())/365 
FROM Cliente