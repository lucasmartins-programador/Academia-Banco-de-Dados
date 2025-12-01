----------------------------------------------------
-- U P D A T E S
----------------------------------------------------

-- Atualizar telefone do aluno de ID 1
UPDATE aluno
SET telefone = '11922223333'
WHERE id_aluno = 1;


-- Atualizar status do pagamento de ID 2 para "Pago"
UPDATE pagamento
SET status = 'Pago'
WHERE id_pagamento = 2;


-- Aumentar o valor de todos os planos em 10%
UPDATE plano
SET valor_mensalidade = valor_mensalidade * 1.10;



----------------------------------------------------
-- D E L E T E S
----------------------------------------------------

-- Deletar a avaliação física de ID 2
DELETE FROM avaliacao_fisica
WHERE id_avaliacao = 2;


-- Deletar todos os pagamentos com status "Pendente"
DELETE FROM pagamento
WHERE status = 'Pendente';


-- Remover o exercício 2 do treino 2
DELETE FROM treino_exercicio
WHERE id_treino = 2 
  AND id_exercicio = 2;
