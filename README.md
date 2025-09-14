# Projeto de Banco de Dados: Sistema de Gerenciamento de Oficina Mecânica

Este repositório contém os scripts SQL para a criação de um sistema de gerenciamento de oficina mecânica. O projeto foi desenvolvido como parte de um desafio de modelagem de banco de dados, aplicando os conceitos de mapeamento de esquemas ER para o modelo relacional.

## Estrutura do Projeto

O banco de dados é composto por um conjunto de tabelas interconectadas para gerenciar clientes, veículos, mecânicos, serviços, peças e ordens de serviço. A estrutura foi projetada para ser robusta e escalável, permitindo a recuperação de informações de forma eficiente.

### Esquema Lógico (Modelo Relacional)

* **Cliente:** Informações dos proprietários dos veículos.
* **Veiculo:** Dados dos veículos, com chave estrangeira para `Cliente`.
* **Mecanico:** Informações dos profissionais da oficina.
* **Servico:** Lista de serviços prestados (ex: troca de óleo).
* **Peca:** Catálogo de peças disponíveis, com controle de estoque.
* **OrdemDeServico:** Documento principal que vincula um veículo e um mecânico a um conjunto de serviços e peças.
* **Tabelas de Relacionamento (`OrdemDeServico_Servico` e `Servico_Peca`):** Permitem a modelagem de relacionamentos N:M, garantindo a flexibilidade do sistema.

## Conteúdo do Repositório

* `oficina_mecanica.sql`: Contém o script completo para criação do banco de dados, incluindo:
    * Criação de todas as tabelas com suas chaves primárias e estrangeiras.
    * Inserção de dados de teste (`INSERT INTO`).
    * Exemplos de queries (`SELECT`) para demonstrar a recuperação de informações.

## Como Utilizar

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/seu-usuario/seu-repositorio.git](https://github.com/seu-usuario/seu-repositorio.git)
    ```
2.  **Acesse o diretório do projeto:**
    ```bash
    cd seu-repositorio
    ```
3.  **Execute o script SQL:**
    Abra o `oficina_mecanica.sql` em um cliente MySQL (como DBeaver, MySQL Workbench, ou a linha de comando) e execute o script. Ele criará o esquema `OficinaMecanica` e populará as tabelas.

## Consultas de Exemplo

O script `oficina_mecanica.sql` já inclui algumas queries úteis. Sinta-se à vontade para modificá-las ou criar novas consultas para explorar o banco de dados.

**Exemplo de consulta:**
```sql
-- Seleciona todos os veículos de um cliente específico
SELECT v.placa, v.marca, v.modelo
FROM Veiculo v
JOIN Cliente c ON v.id_cliente = c.id_cliente
WHERE c.nome = 'João Silva';
