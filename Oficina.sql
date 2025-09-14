-- -----------------------------------------------------
-- Esquema: OficinaMecanica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OficinaMecanica` DEFAULT CHARACTER SET utf8 ;
USE `OficinaMecanica` ;

-- -----------------------------------------------------
-- Tabela `OficinaMecanica`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaMecanica`.`Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NULL,
  `email` VARCHAR(100) UNIQUE NULL,
  `endereco` VARCHAR(255) NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `OficinaMecanica`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaMecanica`.`Mecanico` (
  `id_mecanico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `especialidade` VARCHAR(50) NULL,
  `salario` DECIMAL(10, 2) NULL,
  PRIMARY KEY (`id_mecanico`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `OficinaMecanica`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaMecanica`.`Veiculo` (
  `id_veiculo` INT NOT NULL AUTO_INCREMENT,
  `placa` VARCHAR(10) NOT NULL UNIQUE,
  `marca` VARCHAR(50) NULL,
  `modelo` VARCHAR(50) NULL,
  `ano` INT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_veiculo`),
  INDEX `fk_Veiculo_Cliente_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `OficinaMecanica`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `OficinaMecanica`.`OrdemDeServico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaMecanica`.`OrdemDeServico` (
  `id_ordem_servico` INT NOT NULL AUTO_INCREMENT,
  `data_abertura` DATE NOT NULL,
  `data_fechamento` DATE NULL,
  `status` ENUM('Em andamento', 'Concluída', 'Cancelada') NOT NULL,
  `valor_total` DECIMAL(10, 2) NULL,
  `id_veiculo` INT NOT NULL,
  `id_mecanico` INT NOT NULL,
  PRIMARY KEY (`id_ordem_servico`),
  INDEX `fk_OrdemDeServico_Veiculo1_idx` (`id_veiculo` ASC) VISIBLE,
  INDEX `fk_OrdemDeServico_Mecanico1_idx` (`id_mecanico` ASC) VISIBLE,
  CONSTRAINT `fk_OrdemDeServico_Veiculo1`
    FOREIGN KEY (`id_veiculo`)
    REFERENCES `OficinaMecanica`.`Veiculo` (`id_veiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdemDeServico_Mecanico1`
    FOREIGN KEY (`id_mecanico`)
    REFERENCES `OficinaMecanica`.`Mecanico` (`id_mecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `OficinaMecanica`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaMecanica`.`Servico` (
  `id_servico` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `valor_mao_de_obra` DECIMAL(10, 2) NULL,
  PRIMARY KEY (`id_servico`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `OficinaMecanica`.`Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaMecanica`.`Peca` (
  `id_peca` INT NOT NULL AUTO_INCREMENT,
  `nome_peca` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `preco_unitario` DECIMAL(10, 2) NOT NULL,
  `quantidade_estoque` INT NOT NULL,
  PRIMARY KEY (`id_peca`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela de relacionamento: `OrdemDeServico_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaMecanica`.`OrdemDeServico_Servico` (
  `id_ordem_servico` INT NOT NULL,
  `id_servico` INT NOT NULL,
  PRIMARY KEY (`id_ordem_servico`, `id_servico`),
  INDEX `fk_OrdemDeServico_has_Servico_Servico1_idx` (`id_servico` ASC) VISIBLE,
  INDEX `fk_OrdemDeServico_has_Servico_OrdemDeServico1_idx` (`id_ordem_servico` ASC) VISIBLE,
  CONSTRAINT `fk_OrdemDeServico_has_Servico_OrdemDeServico1`
    FOREIGN KEY (`id_ordem_servico`)
    REFERENCES `OficinaMecanica`.`OrdemDeServico` (`id_ordem_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdemDeServico_has_Servico_Servico1`
    FOREIGN KEY (`id_servico`)
    REFERENCES `OficinaMecanica`.`Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela de relacionamento: `Servico_Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaMecanica`.`Servico_Peca` (
  `id_servico` INT NOT NULL,
  `id_peca` INT NOT NULL,
  `quantidade_utilizada` INT NOT NULL,
  `valor_total_peca` DECIMAL(10, 2) NULL,
  PRIMARY KEY (`id_servico`, `id_peca`),
  INDEX `fk_Servico_has_Peca_Peca1_idx` (`id_peca` ASC) VISIBLE,
  INDEX `fk_Servico_has_Peca_Servico1_idx` (`id_servico` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_has_Peca_Servico1`
    FOREIGN KEY (`id_servico`)
    REFERENCES `OficinaMecanica`.`Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Peca_Peca1`
    FOREIGN KEY (`id_peca`)
    REFERENCES `OficinaMecanica`.`Peca` (`id_peca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Inserção de Dados para Teste
-- -----------------------------------------------------
INSERT INTO Cliente (nome, telefone, email, endereco) VALUES
('João Silva', '11987654321', 'joao.silva@email.com', 'Rua A, 123'),
('Maria Oliveira', '11912345678', 'maria.oliveira@email.com', 'Av. B, 456'),
('Pedro Santos', '11998877665', 'pedro.santos@email.com', 'Rua C, 789');

INSERT INTO Mecanico (nome, especialidade, salario) VALUES
('Carlos Rocha', 'Mecânica Geral', 3500.00),
('Fernanda Lima', 'Elétrica Automotiva', 4200.00),
('Roberto Gomes', 'Suspensão e Freios', 3800.00);

INSERT INTO Veiculo (placa, marca, modelo, ano, id_cliente) VALUES
('ABC1234', 'Fiat', 'Palio', 2015, 1),
('XYZ5678', 'Ford', 'Focus', 2018, 2),
('PQR9012', 'Volkswagen', 'Golf', 2020, 1),
('LMN3456', 'Chevrolet', 'Onix', 2021, 3);

INSERT INTO Peca (nome_peca, descricao, preco_unitario, quantidade_estoque) VALUES
('Filtro de Óleo', 'Filtro para motor', 25.50, 50),
('Vela de Ignição', 'Vela de ignição para motor a gasolina', 15.00, 100),
('Pastilha de Freio', 'Pastilha de freio para roda dianteira', 80.00, 30),
('Lâmpada Farol', 'Lâmpada halógena H4', 35.00, 25);

INSERT INTO Servico (descricao, valor_mao_de_obra) VALUES
('Troca de óleo e filtro', 50.00),
('Revisão geral', 150.00),
('Troca de pastilhas de freio', 80.00),
('Diagnóstico elétrico', 60.00);

INSERT INTO OrdemDeServico (data_abertura, status, id_veiculo, id_mecanico) VALUES
('2025-09-10', 'Em andamento', 1, 1),
('2025-09-12', 'Concluída', 2, 2),
('2025-09-13', 'Em andamento', 3, 3);

INSERT INTO OrdemDeServico_Servico (id_ordem_servico, id_servico) VALUES
(1, 1),
(1, 2),
(2, 3);

INSERT INTO Servico_Peca (id_servico, id_peca, quantidade_utilizada) VALUES
(1, 1, 1),
(1, 2, 4),
(3, 3, 1);

UPDATE OrdemDeServico
SET valor_total = (
    SELECT SUM(S.valor_mao_de_obra)
    FROM OrdemDeServico_Servico OS
    JOIN Servico S ON OS.id_servico = S.id_servico
    WHERE OS.id_ordem_servico = OrdemDeServico.id_ordem_servico
)
WHERE id_ordem_servico IN (1, 2);

UPDATE Servico_Peca sp
JOIN Peca p ON sp.id_peca = p.id_peca
SET sp.valor_total_peca = sp.quantidade_utilizada * p.preco_unitario;

UPDATE OrdemDeServico
SET valor_total = (
    SELECT SUM(SP.valor_total_peca)
    FROM Servico_Peca SP
    JOIN OrdemDeServico_Servico OS ON SP.id_servico = OS.id_servico
    WHERE OS.id_ordem_servico = OrdemDeServico.id_ordem_servico
) + valor_total;


-- -----------------------------------------------------
-- Exemplos de Queries
-- -----------------------------------------------------

-- Pergunta: Qual é a lista de clientes, seus veículos e as placas correspondentes?
SELECT c.nome AS cliente, v.placa, v.marca, v.modelo
FROM Cliente c
JOIN Veiculo v ON c.id_cliente = v.id_cliente;

-- Pergunta: Quantas ordens de serviço cada mecânico concluiu?
SELECT m.nome, COUNT(os.id_ordem_servico) AS ordens_concluidas
FROM Mecanico m
LEFT JOIN OrdemDeServico os ON m.id_mecanico = os.id_mecanico
WHERE os.status = 'Concluída'
GROUP BY m.nome;

-- Pergunta: Qual o valor total de cada ordem de serviço, detalhando o custo de mão de obra e peças?
SELECT
    os.id_ordem_servico,
    os.valor_total AS valor_total_ordem,
    SUM(s.valor_mao_de_obra) AS valor_mao_de_obra,
    SUM(sp.valor_total_peca) AS valor_pecas
FROM OrdemDeServico os
JOIN OrdemDeServico_Servico oss ON os.id_ordem_servico = oss.id_ordem_servico
JOIN Servico s ON oss.id_servico = s.id_servico
LEFT JOIN Servico_Peca sp ON s.id_servico = sp.id_servico
GROUP BY os.id_ordem_servico;

-- Pergunta: Quais peças estão com o estoque abaixo de 20 unidades?
SELECT nome_peca, quantidade_estoque FROM Peca WHERE quantidade_estoque < 20;