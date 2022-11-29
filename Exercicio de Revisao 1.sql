CREATE DATABASE ExerciciodeRevisao1

GO

USE ExerciciodeRevisao1

GO

CREATE TABLE Aluno (
ra			INT			NOT NULL,
nome		VARCHAR(30) NOT NULL,
sobrenome	VARCHAR(30) NOT NULL,
rua			VARCHAR(30) NOT NULL,
num			INT			NOT NULL,
bairro		VARCHAR(30) NOT NULL,
cep			CHAR(7)		NOT NULL,
telefone	CHAR(8)         NULL
PRIMARY KEY (ra)
)

GO

CREATE TABLE Curso (
codigo		INT NOT NULL,
nome		VARCHAR(20) NOT NULL,
carga		INT			NOT NULL,
turno		VARCHAR(10) NOT NULL
PRIMARY KEY (codigo)
)

GO

CREATE TABLE Disciplina (
codigo		INT			NOT NULL,
nome		VARCHAR(20) NOT NULL,
carga		INT			NOT NULL,
turno		VARCHAR(10) NOT NULL,
semestre    INT			NOT NULL
PRIMARY KEY (codigo)
)

GO

INSERT INTO Aluno Values 
(12345, 'José', 'Silva', 'Almirante Noronha', 236, 'Jardim São Paulo', 1589000, 69875287),
(12346,	'Ana', 'Maria Bastos',	'Anhaia', 1568,	'Barra Funda', 3569000,	25698526),
(12347,	'Mario', 'Santos',	'XV de Novembro', 1841, 'Centro', 1020030, Null),
(12348, 'Marcia', 'Neves', 'Voluntários da Patria', 225, 'Santana',	2785090, 78964152)

INSERT INTO Curso Values 
(1, 'Informatica', 2800, 'Tarde'),
(2, 'Informatica', 2800, 'Noite'),
(3, 'Logistica', 2650, 'Tarde'),
(4, 'Logistica', 2650, 'Noite'),
(5, 'Plasticos', 2500, 'Tarde'),
(6, 'Plasticos', 2500, 'Noite')

INSERT INTO Disciplina Values 
(1, 'Informatica', 4, 'Tarde', 1),
(2, 'Informatica', 4, 'Noite', 1),
(3, 'Quimica', 4, 'Tarde', 1),
(4, 'Quimica', 4, 'Noite', 1),
(5, 'Banco de Dados 1', 2, 'Tarde', 3),
(6, 'Banco de Dados 1', 2, 'Noite', 3),
(7, 'Estrutura de Dados', 4, 'Tarde', 4),
(8, 'Estrutura de Dados', 4, 'Noite', 4)

SELECT * FROM Aluno

--Nome e sobrenome, como nome completo dos Alunos Matriculados
SELECT nome + ' ' + sobrenome from aluno AS Nome_Completo
WHERE ra IS NOT NULL
--Rua, nº , Bairro e CEP como Endereço do aluno que não tem telefone
SELECT rua + ' '+ CONVERT(VARCHAR(5), num), + ' '+ bairro + ' ' + cep from aluno
WHERE telefone is NULL
--Telefone do aluno com RA 12348
SELECT telefone from aluno
WHERE RA = 12348
--Nome e Turno dos cursos com 2800 horas
SELECT nome, turno FROM curso
where carga = 2800
--O semestre do curso de Banco de Dados I noite
SELECT semestre FROM Disciplina
WHERE nome like '%Banco de Dados%' and turno = 'Noite'

USE master
DROP DATABASE ExercicioRevisao1

