----------------------------------------------
-- 1. ALUNOS COM SEUS PLANOS
----------------------------------------------
SELECT 
    a.id_aluno,
    a.nome, 
    p.nome_plano, 
    p.valor_mensalidade
FROM aluno a
JOIN plano p ON a.id_plano = p.id_plano;


----------------------------------------------
-- 2. PAGAMENTOS PENDENTES
----------------------------------------------
SELECT 
    a.nome AS aluno, 
    pag.data_pagamento,
    pag.valor, 
    pag.status
FROM pagamento pag
JOIN aluno a ON pag.id_aluno = a.id_aluno
WHERE pag.status = 'Pendente';


----------------------------------------------
-- 3. AVALIAÇÕES FÍSICAS COM IMC > 25
----------------------------------------------
SELECT 
    a.nome, 
    af.peso, 
    af.altura, 
    af.imc
FROM avaliacao_fisica af
JOIN aluno a ON af.id_aluno = a.id_aluno
WHERE af.imc > 25;


----------------------------------------------
-- 4. TODOS OS EXERCÍCIOS (ORDENADOS)
----------------------------------------------
SELECT 
    id_exercicio,
    nome,
    grupo_muscular,
    descricao
FROM exercicio
ORDER BY grupo_muscular, nome;


----------------------------------------------
-- 5. TREINOS COMPLETOS (COM EXERCÍCIOS)
----------------------------------------------
SELECT 
    t.id_treino,
    a.nome AS aluno,
    i.nome AS instrutor,
    e.nome AS exercicio,
    te.series,
    te.repeticoes
FROM treino t
JOIN aluno a ON t.id_aluno = a.id_aluno
JOIN instrutor i ON t.id_instrutor = i.id_instrutor
JOIN treino_exercicio te ON t.id_treino = te.id_treino
JOIN exercicio e ON te.id_exercicio = e.id_exercicio
ORDER BY t.id_treino, e.nome;


----------------------------------------------
-- 6. LISTA COMPLETA DE INSTRUTORES
----------------------------------------------
SELECT 
    id_instrutor,
    nome,
    telefone,
    email
FROM instrutor;


----------------------------------------------
-- 7. LISTA COMPLETA DE ALUNOS (COM IDADE)
----------------------------------------------
SELECT 
    id_aluno,
    nome,
    TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade,
    telefone,
    email
FROM aluno;


----------------------------------------------
-- 8. ALUNOS QUE JÁ FIZERAM AVALIAÇÃO FÍSICA
----------------------------------------------
SELECT 
    a.nome AS aluno,
    af.data_avaliacao,
    i.nome AS instrutor,
    af.imc
FROM avaliacao_fisica af
JOIN aluno a ON af.id_aluno = a.id_aluno
JOIN instrutor i ON af.id_instrutor = i.id_instrutor
ORDER BY af.data_avaliacao DESC;


----------------------------------------------
-- 9. PAGAMENTOS POR ALUNO
----------------------------------------------
SELECT 
    a.nome AS aluno,
    pag.data_pagamento,
    pag.valor,
    pag.status
FROM pagamento pag
JOIN aluno a ON pag.id_aluno = a.id_aluno
ORDER BY pag.data_pagamento DESC;


----------------------------------------------
-- 10. TREINOS POR ALUNO
----------------------------------------------
SELECT 
    a.nome AS aluno,
    t.id_treino,
    t.objetivo
FROM treino t
JOIN aluno a ON t.id_aluno = a.id_aluno
ORDER BY a.nome;


----------------------------------------------
-- 11. IMC MÉDIO DOS ALUNOS
----------------------------------------------
SELECT ROUND(AVG(imc), 2) AS imc_medio
FROM avaliacao_fisica;


---------------------------------------------------
-- 12. EXERCÍCIOS POR GRUPO MUSCULAR (COMPLETO)
---------------------------------------------------

-- PEITO
SELECT * FROM exercicio WHERE grupo_muscular = 'Peito';

-- COSTAS
SELECT * FROM exercicio WHERE grupo_muscular = 'Costas';

-- PERNAS
SELECT * FROM exercicio WHERE grupo_muscular = 'Pernas';

-- TRÍCEPS
SELECT * FROM exercicio WHERE grupo_muscular = 'Tríceps';

-- BÍCEPS
SELECT * FROM exercicio WHERE grupo_muscular = 'Bíceps';

-- OMBROS
SELECT * FROM exercicio WHERE grupo_muscular = 'Ombros';


