CREATE DATABASE academia;
USE academia;

-- 1. Tabela de Planos
CREATE TABLE plano (
    id_plano INT AUTO_INCREMENT PRIMARY KEY,
    nome_plano VARCHAR(50) NOT NULL,
    valor_mensalidade DECIMAL(10,2) NOT NULL
);

-- 2. Tabela de Instrutores
CREATE TABLE instrutor (
    id_instrutor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(120)
);

-- 3. Tabela de Alunos
CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    data_nascimento DATE,
    telefone VARCHAR(15),
    email VARCHAR(120),
    id_plano INT,
    FOREIGN KEY (id_plano) REFERENCES plano(id_plano)
);

-- 4. Tabela de Pagamentos 
CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    data_pagamento DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status VARCHAR(20),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

-- 5. Avaliação Física
CREATE TABLE avaliacao_fisica (
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

-- 6. Tabela de Exercícios
CREATE TABLE exercicio (
    id_exercicio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    grupo_muscular VARCHAR(50),
    descricao TEXT
);

-- 7. Tabela de Treinos
CREATE TABLE treino (
    id_treino INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_instrutor INT NOT NULL,
    objetivo VARCHAR(100),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_instrutor) REFERENCES instrutor(id_instrutor)
);

-- 8. Associação treino ↔ exercícios
CREATE TABLE treino_exercicio (
    id_treino INT NOT NULL,
    id_exercicio INT NOT NULL,
    series INT,
    repeticoes INT,

    PRIMARY KEY (id_treino, id_exercicio),

    FOREIGN KEY (id_treino) REFERENCES treino(id_treino) ON DELETE CASCADE,
    FOREIGN KEY (id_exercicio) REFERENCES exercicio(id_exercicio)
)