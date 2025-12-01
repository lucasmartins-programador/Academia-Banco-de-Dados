CREATE DATABASE IF NOT EXISTS academia;
USE academia;

-- Se quiser recriar do zero, descomente as linhas abaixo:
-- DROP TABLE IF EXISTS treino_exercicio;
-- DROP TABLE IF EXISTS treino;
-- DROP TABLE IF EXISTS exercicio;
-- DROP TABLE IF EXISTS avaliacao_fisica;
-- DROP TABLE IF EXISTS pagamento;
-- DROP TABLE IF EXISTS aluno;
-- DROP TABLE IF EXISTS instrutor;
-- DROP TABLE IF EXISTS plano;

-----------------------------------------------------
-- 1. Tabela de Planos
-----------------------------------------------------
CREATE TABLE IF NOT EXISTS plano (
    id_plano INT AUTO_INCREMENT PRIMARY KEY,
    nome_plano VARCHAR(50) NOT NULL,
    valor_mensalidade DECIMAL(10,2) NOT NULL
);

-----------------------------------------------------
-- 2. Tabela de Instrutores (sem especialidade)
-----------------------------------------------------
CREATE TABLE IF NOT EXISTS instrutor (
    id_instrutor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(120)
);

-----------------------------------------------------
-- 3. Tabela de Alunos
-----------------------------------------------------
CREATE TABLE IF NOT EXISTS aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    data_nascimento DATE,
    telefone VARCHAR(15),
    email VARCHAR(120),
    id_plano INT,
    FOREIGN KEY (id_plano) REFERENCES plano(id_plano)
);

-----------------------------------------------------
-- 4. Tabela de Pagamentos (sem metodo_pagamento)
-----------------------------------------------------
CREATE TABLE IF NOT EXISTS pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    data_pagamento DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status VARCHAR(20),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

-----------------------------------------------------
-- 5. Avaliação Física
-----------------------------------------------------
CREATE TABLE IF NOT EXISTS avaliacao_fisica (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_instrutor INT NOT NULL,
    data_avaliacao DATE NOT NULL,
    peso DECIMAL(5,2),
    altura DECIMAL(4,2),
    imc DECIMAL(5,2),
    medida_busto INT,
    medida_cintura INT,
    medida_quadril INT,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_instrutor) REFERENCES instrutor(id_instrutor)
);

-----------------------------------------------------
-- 6. Tabela de Exercícios
-----------------------------------------------------
CREATE TABLE IF NOT EXISTS exercicio (
    id_exercicio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    grupo_muscular VARCHAR(50),
    descricao TEXT
);

-----------------------------------------------------
-- 7. Tabela de Treinos
-----------------------------------------------------
CREATE TABLE IF NOT EXISTS treino (
    id_treino INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_instrutor INT NOT NULL,
    objetivo VARCHAR(100),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_instrutor) REFERENCES instrutor(id_instrutor)
);

-----------------------------------------------------
-- 8. Associação treino ↔ exercícios
-----------------------------------------------------
CREATE TABLE IF NOT EXISTS treino_exercicio (
    id_treino INT NOT NULL,
    id_exercicio INT NOT NULL,
    series INT,
    repeticoes INT,
    PRIMARY KEY (id_treino, id_exercicio),
    FOREIGN KEY (id_treino) REFERENCES treino(id_treino) ON DELETE CASCADE,
    FOREIGN KEY (id_exercicio) REFERENCES exercicio(id_exercicio)
);

-----------------------------------------------------
-- INSERÇÕES DE DADOS
-----------------------------------------------------

-- Planos
INSERT INTO plano (nome_plano, valor_mensalidade) VALUES
('Básico', 99.90),
('Premium', 149.90),
('VIP', 199.90);

-- Instrutores
INSERT INTO instrutor (nome, telefone, email) VALUES
('Carlos Mendes', '11999990001', 'carlos@vivafit.com'),
('Juliana Prado', '11999990002', 'juliana@vivafit.com');

-- 5 Alunos
INSERT INTO aluno (nome, data_nascimento, telefone, email, id_plano) VALUES
('Ana Costa', '1995-03-12', '11988887777', 'ana@gmail.com', 2),
('Marcos Silva', '1988-10-25', '11977776666', 'marcos@gmail.com', 1),
('Beatriz Rocha', '1999-07-22', '11966665555', 'beatriz@gmail.com', 3),
('João Ferreira', '1990-05-02', '11955554444', 'joao@gmail.com', 1),
('Lucas Almeida', '1998-09-17', '11944443333', 'lucas@gmail.com', 2);

-- Pagamentos
INSERT INTO pagamento (id_aluno, data_pagamento, valor, status) VALUES
(1, '2024-06-01', 149.90, 'Pago'),
(2, '2024-06-05', 99.90, 'Pendente'),
(3, '2024-06-03', 199.90, 'Pago'),
(4, '2024-06-07', 149.90, 'Pago'),
(5, '2024-06-08', 99.90, 'Pendente');

-- Avaliações físicas
INSERT INTO avaliacao_fisica (id_aluno, id_instrutor, data_avaliacao, peso, altura, imc, medida_busto, medida_cintura, medida_quadril) VALUES
(1, 1, '2024-06-10', 62.5, 1.65, 22.9, 88, 70, 96),
(2, 2, '2024-06-11', 85.0, 1.80, 26.2, 100, 90, 102),
(3, 1, '2024-06-12', 70.2, 1.75, 22.9, 95, 85, 100),
(4, 2, '2024-06-13', 58.0, 1.60, 22.6, 86, 68, 94),
(5, 1, '2024-06-14', 72.0, 1.70, 24.9, 92, 80, 98);

-- EXERCÍCIOS - Todos os exercícios dos 5 dias (ordem importa para IDs)
-- Dia 1 (Peito + Pernas)
INSERT INTO exercicio (nome, grupo_muscular, descricao) VALUES
('Crucifixo reto (máquina ou cabo)', 'Peito', '3x12-15'),
('Supino inclinado com halteres', 'Peito', '3x10-15'),
('Supino máquina (preferência inclinado)', 'Peito', '3x10-12'),
('Supino reto (barra guiada ou halteres)', 'Peito', '3x10-15'),
('Cross Over', 'Peito', '4x15'),
('Paralela', 'Peito', '4xFALHA'),
('Panturrilhas (máquina à escolha)', 'Pernas', '6x20');

-- Dia 2 (Costas)
INSERT INTO exercicio (nome, grupo_muscular, descricao) VALUES
('Remada curvada com barra', 'Costas', '3x8-12'),
('Remada com halteres', 'Costas', '3x8-12'),
('Puxador frente (pegada aberta)', 'Costas', '4x8-12'),
('Remada máquina', 'Costas', '3x10-12'),
('Remada baixa com cabo', 'Costas', '3x10-12'),
('Pullover', 'Costas', '3x12');

-- Dia 3 (Pernas)
INSERT INTO exercicio (nome, grupo_muscular, descricao) VALUES
('Cadeira extensora', 'Pernas', '3x12-15'),
('Agachamento livre', 'Pernas', '4x6-12'),
('Leg Press', 'Pernas', '4x10-12'),
('Cadeira flexora deitada', 'Pernas', '3x10-12'),
('Cadeira flexora sentada', 'Pernas', '3x10-12'),
('Leg Stiff', 'Pernas', '4x8-12'),
('Panturrilhas sentado', 'Pernas', '6x15-20');


-- Dia 4 (Ombros + Pernas)
INSERT INTO exercicio (nome, grupo_muscular, descricao) VALUES
('Elevação lateral com cabo', 'Ombros', '3x12'),
('Elevação lateral com halteres', 'Ombros', '3x12'),
('Desenvolvimento na máquina', 'Ombros', '4x8-12'),
('Elevação lateral na máquina', 'Ombros', '3x12'),
('Elevação frontal com halteres', 'Ombros', '3x10-12'),
('Crucifixo invertido (cabo ou máquina)', 'Ombros', '3x12'),
('Panturrilhas em pé', 'Pernas', '5x20');

-- Dia 5 (Braços)
INSERT INTO exercicio (nome, grupo_muscular, descricao) VALUES
('Rosca direta no cabo', 'Bíceps', '3x10-12'),
('Rosca direta com halteres', 'Bíceps', '3x10-12'),
('Rosca Scott', 'Bíceps', '3x8-12'),
('Extensão tríceps no cabo', 'Tríceps', '3x10-12'),
('Extensão tríceps na máquina', 'Tríceps', '3x10-12'),
('Supino fechado / paralela para tríceps', 'Tríceps', '3x8-12');

-- TREINOS: 5 dias por aluno → 25 treinos (inserção em sequência para garantir ids 1..25)
INSERT INTO treino (id_aluno, id_instrutor, objetivo) VALUES
(1, 1, 'Dia 1 - Peito'),
(1, 1, 'Dia 2 - Costas'),
(1, 1, 'Dia 3 - Pernas'),
(1, 1, 'Dia 4 - Ombros'),
(1, 1, 'Dia 5 - Braços'),
(2, 1, 'Dia 1 - Peito'),
(2, 1, 'Dia 2 - Costas'),
(2, 1, 'Dia 3 - Pernas'),
(2, 1, 'Dia 4 - Ombros'),
(2, 1, 'Dia 5 - Braços'),
(3, 1, 'Dia 1 - Peito'),
(3, 1, 'Dia 2 - Costas'),
(3, 1, 'Dia 3 - Pernas'),
(3, 1, 'Dia 4 - Ombros'),
(3, 1, 'Dia 5 - Braços'),
(4, 1, 'Dia 1 - Peito'),
(4, 1, 'Dia 2 - Costas'),
(4, 1, 'Dia 3 - Pernas'),
(4, 1, 'Dia 4 - Ombros'),
(4, 1, 'Dia 5 - Braços'),
(5, 1, 'Dia 1 - Peito'),
(5, 1, 'Dia 2 - Costas'),
(5, 1, 'Dia 3 - Pernas'),
(5, 1, 'Dia 4 - Ombros'),
(5, 1, 'Dia 5 - Braços');

-- Agora as associações treino_exercicio.
-- Referência de IDs (em DB limpo): Dia1 ids 1..7, Dia2 ids 8..13, Dia3 ids 14..20, Dia4 ids 21..27, Dia5 ids 28..33

-- TREINO_EXERCICIO: Dia 1 (Peito + Pernas) -> exercícios ids 1..7
-- Aplicado aos treinos: 1,6,11,16,21
INSERT INTO treino_exercicio (id_treino, id_exercicio, series, repeticoes) VALUES
(1, 1, 3, 15),
(1, 2, 3, 12),
(1, 3, 3, 12),
(1, 4, 3, 12),
(1, 5, 4, 15),
(1, 6, 4, 0),
(1, 7, 6, 20),

(6, 1, 3, 15),
(6, 2, 3, 12),
(6, 3, 3, 12),
(6, 4, 3, 12),
(6, 5, 4, 15),
(6, 6, 4, 0),
(6, 7, 6, 20),

(11, 1, 3, 15),
(11, 2, 3, 12),
(11, 3, 3, 12),
(11, 4, 3, 12),
(11, 5, 4, 15),
(11, 6, 4, 0),
(11, 7, 6, 20),

(16, 1, 3, 15),
(16, 2, 3, 12),
(16, 3, 3, 12),
(16, 4, 3, 12),
(16, 5, 4, 15),
(16, 6, 4, 0),
(16, 7, 6, 20),

(21, 1, 3, 15),
(21, 2, 3, 12),
(21, 3, 3, 12),
(21, 4, 3, 12),
(21, 5, 4, 15),
(21, 6, 4, 0),
(21, 7, 6, 20);

-- TREINO_EXERCICIO: Dia 2 (Costas) -> exercícios ids 8..13
-- Aplicado aos treinos: 2,7,12,17,22
INSERT INTO treino_exercicio (id_treino, id_exercicio, series, repeticoes) VALUES
(2, 8, 4, 10),
(2, 9, 3, 10),
(2, 10, 4, 12),
(2, 11, 3, 10),
(2, 12, 3, 12),
(2, 13, 3, 12),

(7, 8, 4, 10),
(7, 9, 3, 10),
(7, 10, 4, 12),
(7, 11, 3, 10),
(7, 12, 3, 12),
(7, 13, 3, 12),

(12, 8, 4, 10),
(12, 9, 3, 10),
(12, 10, 4, 12),
(12, 11, 3, 10),
(12, 12, 3, 12),
(12, 13, 3, 12),

(17, 8, 4, 10),
(17, 9, 3, 10),
(17, 10, 4, 12),
(17, 11, 3, 10),
(17, 12, 3, 12),
(17, 13, 3, 12),

(22, 8, 4, 10),
(22, 9, 3, 10),
(22, 10, 4, 12),
(22, 11, 3, 10),
(22, 12, 3, 12),
(22, 13, 3, 12);

-- TREINO_EXERCICIO: Dia 3 (Pernas) -> exercícios ids 14..20
-- Aplicado aos treinos: 3,8,13,18,23
INSERT INTO treino_exercicio (id_treino, id_exercicio, series, repeticoes) VALUES
(3, 14, 3, 15),
(3, 15, 4, 8),
(3, 16, 4, 10),
(3, 17, 3, 12),
(3, 18, 3, 12),
(3, 19, 4, 8),
(3, 20, 6, 15),

(8, 14, 3, 15),
(8, 15, 4, 8),
(8, 16, 4, 10),
(8, 17, 3, 12),
(8, 18, 3, 12),
(8, 19, 4, 8),
(8, 20, 6, 15),

(13, 14, 3, 15),
(13, 15, 4, 8),
(13, 16, 4, 10),
(13, 17, 3, 12),
(13, 18, 3, 12),
(13, 19, 4, 8),
(13, 20, 6, 15),

(18, 14, 3, 15),
(18, 15, 4, 8),
(18, 16, 4, 10),
(18, 17, 3, 12),
(18, 18, 3, 12),
(18, 19, 4, 8),
(18, 20, 6, 15),

(23, 14, 3, 15),
(23, 15, 4, 8),
(23, 16, 4, 10),
(23, 17, 3, 12),
(23, 18, 3, 12),
(23, 19, 4, 8),
(23, 20, 6, 15);

-- TREINO_EXERCICIO: Dia 4 (Ombros + Pernas) -> exercícios ids 21..27
-- Aplicado aos treinos: 4,9,14,19,24
INSERT INTO treino_exercicio (id_treino, id_exercicio, series, repeticoes) VALUES
(4, 21, 3, 12),
(4, 22, 3, 12),
(4, 23, 4, 8),
(4, 24, 3, 12),
(4, 25, 3, 12),
(4, 26, 3, 12),
(4, 27, 5, 20),

(9, 21, 3, 12),
(9, 22, 3, 12),
(9, 23, 4, 8),
(9, 24, 3, 12),
(9, 25, 3, 12),
(9, 26, 3, 12),
(9, 27, 5, 20),

(14, 21, 3, 12),
(14, 22, 3, 12),
(14, 23, 4, 8),
(14, 24, 3, 12),
(14, 25, 3, 12),
(14, 26, 3, 12),
(14, 27, 5, 20),

(19, 21, 3, 12),
(19, 22, 3, 12),
(19, 23, 4, 8),
(19, 24, 3, 12),
(19, 25, 3, 12),
(19, 26, 3, 12),
(19, 27, 5, 20),

(24, 21, 3, 12),
(24, 22, 3, 12),
(24, 23, 4, 8),
(24, 24, 3, 12),
(24, 25, 3, 12),
(24, 26, 3, 12),
(24, 27, 5, 20);

-- TREINO_EXERCICIO: Dia 5 (Braços) -> exercícios ids 28..33
-- Aplicado aos treinos: 5,10,15,20,25
INSERT INTO treino_exercicio (id_treino, id_exercicio, series, repeticoes) VALUES
(5, 28, 3, 12),
(5, 29, 3, 12),
(5, 30, 3, 10),
(5, 31, 3, 12),
(5, 32, 3, 12),
(5, 33, 3, 10),

(10, 28, 3, 12),
(10, 29, 3, 12),
(10, 30, 3, 10),
(10, 31, 3, 12),
(10, 32, 3, 12),
(10, 33, 3, 10),

(15, 28, 3, 12),
(15, 29, 3, 12),
(15, 30, 3, 10),
(15, 31, 3, 12),
(15, 32, 3, 12),
(15, 33, 3, 10),

(20, 28, 3, 12),
(20, 29, 3, 12),
(20, 30, 3, 10),
(20, 31, 3, 12),
(20, 32, 3, 12),
(20, 33, 3, 10),

(25, 28, 3, 12),
(25, 29, 3, 12),
(25, 30, 3, 10),
(25, 31, 3, 12),
(25, 32, 3, 12),
(25, 33, 3, 10);
