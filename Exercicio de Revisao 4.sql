CREATE DATABASE Exercicioderevisao4
Use ExerciciodeRevisao4
CREATE TABLE Cliente (
CPF			char(12)		not null,
nome		varchar(50)		not null,
telefone	varchar(9)      not null
Primary Key (CPF)
)
Go


CREATE TABLE Fornecedor (
ID				int			not null,
nome			varchar(30) not null,
logradouro		varchar(50)	not null,
num				int			not null,
complemento		varchar(10)	not null,
cidade			varchar(20)	not null
Primary Key (ID)
)


CREATE TABLE Produto (
codigo				int				not null,
descricao			varchar(60)		not null,
id_fornecedor		int				not null,
preco				decimal(7,2)	not null
Primary Key (codigo)
Foreign Key (id_fornecedor) References Fornecedor (ID)
)


CREATE TABLE Venda (
codigo				int				not null,
codigo_produto		int				not null,
cpf_cliente			char(12)		not null,
quant				int				not null,
valorT				decimal(7,2)	not null,
data				date			not null
Primary Key (codigo)
Foreign Key (codigo_produto) References Produto (codigo),
Foreign Key (cpf_cliente) References Cliente (CPF)
)


INSERT INTO Cliente VALUES
('345789092-90',	'Julio Cesar',	'8273-6541'),
('251865337-10',	'Maria Antonia',	'8765-2314'),
('876273154-16',	'Luiz Carlos',	'6128-9012'),
('791826398-00',	'Paulo Cesar',	'9076-5273')
Go

INSERT INTO Fornecedor VALUES
(1,	'LG',	'Rod. Bandeirantes',	70000,	'Km 70',	'Itapeva'),
(2,	'Asus',	'Av. Nações Unidas',	10206,	'Sala 225',	'São Paulo'),
(3,	'AMD',	'Av. Nações Unidas',	10206,	'Sala 1095',	'São Paulo'),
(4,	'Leadership',	'Av. Nações Unidas',	10206,	'Sala 87',	'São Paulo'),
(5,	'Inno',	'Av. Nações Unidas',	10206,	'Sala 34',	'São Paulo')
Go

INSERT INTO Produto VALUES
(1,	'Monitor 19 pol.',	1,	449.99),
(2,	'Netbook 1GB Ram 4 Gb HD',	2,	699.99),
(3,	'Gravador de DVD - Sata',	1,	99.99),
(4,	'Leitor de CD',	1,	49.99),
(5,	'Processador - Phenom X3 - 2.1GHz',	3,	349.99),
(6,	'Mouse',	4,	19.99),
(7,	'Teclado',	4,	25.99),
(8,	'Placa de Video - Nvidia 9800 GTX - 256MB/256 bits',	5,	599.99)
Go

INSERT INTO Venda VALUES
(1,	1,	'251865337-10',	1,	'449.99',	'03/09/2009'),
(4,	4,	'251865337-10',	1,	'49.99',	'03/09/2009'),
(5,	5,	'251865337-10',	1,	'349.99',	'03/09/2009'),
(6,	6,	'791826398-00',	4,	'79.96',    '06/09/2009'),
(8,	8,	'876273154-16',	1,	'599.99',	'06/09/2009'),
(3,	3,	'876273154-16',	1,	'99.99',	'06/09/2009'),
(7,	7,	'876273154-16',	1,	'25.99',	'06/09/2009'),
(2,	2,	'345789092-90',	2,	'1399.98',	'08/09/2009')

--Consultar no formato dd/mm/aaaa:
--Data da Venda 4
SELECT CONVERT(CHAR(10),data,103) FROM Venda
WHERE codigo = 4
--Inserir na tabela Fornecedor, a coluna Telefone e os seguintes dados: 1-7216-5371 2-8715-3738 4-3654-6289

ALTER TABLE Fornecedor
ADD telefone		CHAR(9)

UPDATE Fornecedor
SET telefone = '7216-5371'
WHERE ID = 1

UPDATE Fornecedor
SET telefone = '8715-3738'
WHERE ID = 2

UPDATE Fornecedor
SET telefone = '3654-6289'
WHERE ID = 4

--Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone dos fornecedores
SELECT nome, logradouro + ' ' +CONVERT(VARCHAR(5),num) + ' '+ complemento + ' ' + cidade,  telefone FROM Fornecedor
ORDER BY nome

--Produto, quantidade e valor total do comprado por Julio Cesar	 
SELECT quant, valorT from Produto INNER JOIN Venda
ON produto.codigo = venda.codigo_produto
INNER JOIN Cliente
ON cliente.CPF = venda.cpf_cliente
WHERE cliente.nome = 'Julio Cesar'

--Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar						
SELECT CONVERT(CHAR(10),data,103), valorT, nome from Venda INNER JOIN Cliente
ON cpf_cliente = CPF
WHERE cliente.nome = 'Paulo Cesar'

--Consultar, em ordem decrescente, o nome e o preço de todos os produtos 
SELECT descricao, preco from Produto
ORDER BY preco desc


