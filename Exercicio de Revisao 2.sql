CREATE DATABASE ExerciciodeRevisao2 
GO
Use  ExerciciodeRevisao2 

CREATE TABLE Carro (
placa				varchar(7)		not null,
marca				varchar(10)     not null,
modelo				varchar(10)		not null,
cor					varchar(10)		not null,
ano					char(4)			not null
PRIMARY KEY (placa)
)
CREATE TABLE Peca (
codigo		int				not null,
nome		varchar(20)		not null,
valor		decimal(5,2)	not null
Primary Key (codigo)
)
CREATE TABLE Cliente (
nome				varchar(40)		not null,
logradouro			varchar(50)     not null,
num					int				not null,
bairro				varchar(40)		not null,
telefone			varchar(9)		not null,
placa_carro			varchar(7)		not null
Primary Key (nome)
Foreign Key (placa_carro)
	References Carro (placa)
)
CREATE TABLE Servico (
data			date			not null,
placa_carro		varchar(7)		not null,
codigo_peca		int				not null,
quant			int				not null,
valor			decimal(5,2)	not null
Primary Key (data, placa_carro, valor)
Foreign Key (placa_carro)
	References Carro (placa),
Foreign Key (codigo_peca)
	References Peca (codigo)
)
INSERT INTO Carro Values 
('AFT9087',	'VW',	'Gol',	'Preto',	2007),
('DXO9876',	'Ford',	'Ka',	'Azul',	2000),
('EGT4631',	'Renault',	'Clio',	'Verde',	2004),
('LKM7380',	'Fiat',	'Palio',	'Prata',	1997),
('BCD7521',	'Ford',	'Fiesta',	'Preto',	1999)
INSERT INTO Peca Values
(1, 'Vela',	70),
(2,	'Correia Dentada',	125),
(3, 'Trambulador',	90),
(4,	'Filtro de Ar',	30)
INSERT INTOCliente Values
('João Alves',	'R. Pereira Barreto',	1258,	'Jd. Oliveiras',	'2154-9658',	'DXO9876'),
('Ana Maria',	'R. 7 de Setembro',	259,	'Centro',	'9658-8541',	'LKM7380'),
('Clara Oliveira',	'Av. Nações Unidas',	10254,	'Pinheiros',	'2458-9658',	'EGT4631'),
('José Simões',	'R. XV de Novembro',	36,	'Água Branca',	'7895-2459',	'BCD7521'),
('Paula Rocha',	'R. Anhaia',	548,	'Barra Funda',	'6958-2548',	'AFT9087')
INSERT INTO Servico Values
('01/08/2020', 'DXO9876',	1,	4,	280),
('01/08/2020', 'DXO9876',	4,	1,	30),
('02/08/2020', 'EGT4631',	3,	1,	90),
('07/08/2020', 'DXO9876',	2,	1,	125)

--Telefone do dono do carro Ka, Azul
SELECT telefone FROM Cliente INNER JOIN Carro
ON Cliente.placa_carro = Carro.placa
WHERE modelo = 'Ka' and cor = 'Azul'

--Endereço concatenado do cliente que fez o serviço do dia 02/08/2009
SELECT logradouro + ' ' + CONVERT(VARCHAR(5),num) + ' ' + bairro FROM cliente INNER JOIN servico
ON servico.data = servico.data
WHERE data = '02/08/2009'

--Placas dos carros de anos anteriores a 2001
SELECT placa FROM Carro
WHERE ano < 2001

--Marca, modelo e cor, concatenado dos carros posteriores a 2005
SELECT marca + ' ' + modelo + ' ' + cor FROM Carro
WHERE ano > 2005

--Código e nome das peças que custam menos de R$80,00
SELECT codigo, nome from peca
WHERE valor < 80