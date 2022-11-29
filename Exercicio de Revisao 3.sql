CREATE DATABASE ExerciciodeRevisao3

USE ExerciciodeRevisao3

CREATE TABLE Paciente (
CPF			char(11)		not null,
nome		varchar(30)		not null,
rua			varchar(30)		not null,
num			int				not null,
bairro		varchar(20)		not null,
telefone	char(8)			null,
data_nasc	date			not null
Primary Key (CPF)
)
CREATE TABLE Medico (
codigo			int			not null,
nome			varchar(30) not null,
especialidade	varchar(20) not null
Primary Key (codigo)
)
Go

CREATE TABLE Prontuario (
data				date			not null,
CPF_paciente		char(11)		not null,
codigo_medico	    int				not null,
diagnostico			varchar(40)		not null,
medicamento			varchar(20)		not null
Primary Key (data)
Foreign Key (CPF_paciente)
References Paciente (CPF),
Foreign Key (codigo_medico)
References Medico (codigo)
)
INSERT INTO Paciente Values 
('35454562890',	'Jos� Rubens',	'Campos Salles',	2750,	'Centro',	'21450998',	'1954-10-18'),
('29865439810', 'Ana Claudia',	'Sete de Setembro',	178,	'Centro',	'97382764',	'1960-05-29'),
('82176534800',	'Marcos Aur�lio',	'Tim�teo Penteado',	236,	'Vila Galv�o',	'68172651',	'1980-09-24'),
('12386758770',	'Maria Rita',	'Castello Branco',	7765,	'Vila Ros�lia',	NULL,	'1975-03-30'),
('92173458910',	'Joana de Souza',	'XV de Novembro',	298,	'Centro',	'21276578',	'1944-04-24')
INSERT INTO Medico Values 
(1,	'Wilson Cesar',	'Pediatra'),
(2,	'Marcia Matos',	'Geriatra'),
(3,	'Carolina Oliveira',	'Ortopedista'),
(4,	'Vinicius Araujo',	'Cl�nico Geral')
INSERT INTO Prontuario Values 
('2020-09-10',	'35454562890',	2,	'Reumatismo',	'Celebra'),
('2020-09-11',	'92173458910',	2,	'Renite Al�rgica',	'Allegra'),
('2020-09-12',	'29865439810',	1,	'Inflama��o de garganta',	'Nimesulida'),
('2020-09-13',	'35454562890',	2,	'H1N1',	'Tamiflu'),
('2020-09-14',	'82176534800',	4,	'Gripe',	'Resprin'),
('2020-09-15',	'12386758770',	3,	'Bra�o Quebrado',	'Dorflex + Gesso')

--Nome e Endere�o (concatenado) dos pacientes com mais de 50 anos
SELECT nome + ' ' + rua + ' ' + Convert(CHAR(5), num) + ' ' + bairro
FROM Paciente
WHERE DATEDIFF (DAY, data_nasc, GETDATE()) /365 > 50 

--Qual a especialidade de Carolina Oliveira
SELECT especialidade 
FROM medico
WHERE nome = 'Carolina Oliveira'

--Qual medicamento receitado para reumatismo
SELECT medicamento
FROM Prontuario
WHERE diagnostico = 'Reumatismo'

--Diagn�stico e Medicamento do paciente Jos� Rubens em suas consultas
SELECT diagnostico, Medicamento FROM Prontuario INNER JOIN Paciente
ON Prontuario.CPF_paciente = CPF_paciente
WHERE nome = 'Jos� Rubens'

--Nome e especialidade do(s) M�dico(s) que atenderam Jos� Rubens. Caso a especialidade tenha mais de 3 letras, mostrar apenas as 3 primeiras letras concatenada com um ponto final (.)
SELECT DISTINCT Medico.nome, CASE WHEN LEN (especialidade) > 3
THEN SUBSTRING(especialidade, 1, 3) + '.'
ELSE especialidade
END ASespecialidade 
FROM Medico INNER JOIN Prontuario
ON Medico.codigo = Prontuario.codigo_medico
INNER JOIN Paciente 
ON Paciente.CPF = Prontuario.CPF_paciente
WHERE Paciente.nome = 'Jos� Rubens'

--CPF (Com a m�scara XXX.XXX.XXX-XX), Nome, Endere�o completo (Rua, n� - Bairro), Telefone (Caso nulo, mostrar um tra�o (-)) dos pacientes do m�dico Vinicius
SELECT SUBSTRING (CPF, 1,3) + '.' + SUBSTRING (CPF, 4,3) + '.' + SUBSTRING (CPF, 7,3) + '-'
+ SUBSTRING (CPF, 10,2) AS CPF, Paciente.nome, rua + ',' + CONVERT(VARCHAR(5), num) + ' Bairro:' + bairro, CASE WHEN telefone IS NULL 
THEN '-'
ELSE telefone
END AS telefone
FROM Paciente Inner Join Prontuario
ON Paciente.CPF = Prontuario.CPF_paciente
INNER JOIN Medico
ON Medico.codigo = Prontuario.codigo_medico
WHERE Medico.nome Like 'Vinicius%'

--Quantos dias fazem da consulta de Maria Rita at� hoje
SELECT DATEDIFF (DAY, data, GETDATE()) 
FROM Prontuario INNER JOIN Paciente
ON Prontuario.CPF_paciente = Paciente.CPF
WHERE nome = 'Maria Rita'

--Alterar o telefone da paciente Maria Rita, para 98345621
UPDATE Paciente
SET telefone = 98345621
WHERE nome = 'Maria Rita' 

--Alterar o Endere�o de Joana de Souza para Volunt�rios da P�tria, 1980, Jd. Aeroporto
UPDATE Paciente
SET rua = 'Voluntarios da Patria' , num = 1980, bairro = 'Jd. Aeroporto'
WHERE nome = 'Joana de Souza'
