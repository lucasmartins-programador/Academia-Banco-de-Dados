# 🏋️‍♂️ Academia – Banco de Dados Completo

Este projeto contém um banco de dados completo para gerenciamento de uma academia, incluindo planos, alunos, instrutores, avaliações físicas, exercícios e treinos.

O repositório é composto por três arquivos principais:

- **00_ddl.sql** → Criação do banco e das tabelas (DDL)  
- **01_inserts.sql** → Inserção de dados iniciais (DML)  
- **02_selects.sql** → Consultas úteis para análise dos dados  

---

## 📁 Estrutura dos Arquivos

### **1. 00_ddl.sql — Definição do Banco e Tabelas (DDL)**

Este arquivo cria:

- **plano** – Planos de assinatura da academia  
- **instrutor** – Instrutores registrados  
- **aluno** – Cadastro de alunos  
- **pagamento** – Histórico e status de pagamentos  
- **avaliacao_fisica** – Avaliações físicas com medidas corporais  
- **exercicio** – Lista completa de exercícios  
- **treino** – Treinos de cada aluno  
- **treino_exercicio** – Associação entre treinos e exercícios  

Todas as tabelas incluem chaves primárias, chaves estrangeiras e relacionamentos consistentes.

---

### **2. 01_inserts.sql — Criação opcional das tabelas + inserção de dados**

Além de repetir a criação das tabelas com `CREATE TABLE IF NOT EXISTS`, o arquivo contém dados prontos para uso:

- **3 planos**
- **2 instrutores**
- **5 alunos**
- Pagamentos (com alguns pendentes)  
- Avaliações físicas completas  
- **33 exercícios** divididos por grupos musculares e dias da semana  
- **25 treinos** (5 dias × 5 alunos)  
- Associação completa entre treinos e exercícios  

Esse arquivo permite inicializar todo o banco com dados completos para testes.

---

### **3. 02_selects.sql — Consultas SQL úteis**

Inclui diversas consultas para análise e relatórios, como:

- Alunos com seus planos  
- Pagamentos pendentes  
- Avaliações com IMC acima do normal  
- Lista completa de exercícios  
- Treinos com exercícios  
- Lista de instrutores  
- Idade dos alunos  
- Alunos com avaliação física realizada  
- Pagamentos por aluno  
- Treinos por aluno  

---

## 🏗️ Como usar o projeto

1. **Criar o banco e tabelas**
   ```sql
   SOURCE 00_ddl.sql;

2. **Inserir dados**
   ```sql
   SOURCE 01_inserts.sql;

3. **Executar consultas**
   ```sql
   SOURCE 02_selects.sql;
## 🔗 Relacionamentos principais

### 📘 Aluno
- Pertence a um plano  
- Possui pagamentos  
- Realiza avaliações físicas  
- Pode ter vários treinos  

### 📗 Treino
- Criado por um instrutor para um aluno  
- Contém vários exercícios via `treino_exercicio`  

### 📘 Exercício
- Não depende de outras tabelas  
- Relacionado apenas pela associação com treinos  

---

### 🗂️ Diagrama resumido (texto)
```text
plano (1) ---- (N) aluno ---- (N) pagamento
                     |
                     +---- (N) avaliacao_fisica ---- instrutor
                     |
                     +---- (N) treino ---- instrutor
                                 |
                                 +---- (N) treino_exercicio ---- exercicio
```
### ✔️ Objetivo do projeto

Este banco foi projetado para:

- Controle de alunos e planos  
- Gestão de treinos detalhados  
- Acompanhamento de métricas corporais  
- Histórico de pagamentos  
- Organização de exercícios por grupo muscular  

- Relatórios prontos para uso
