CREATE DATABASE IF NOT EXISTS mydb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mydb;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Agendamento_has_Cliente;
DROP TABLE IF EXISTS Profissional_has_Servico;
DROP TABLE IF EXISTS Departamento_has_Profissional;
DROP TABLE IF EXISTS Jornada_Profissional;
DROP TABLE IF EXISTS Contato_Cliente;
DROP TABLE IF EXISTS Endereco_Cliente;
DROP TABLE IF EXISTS Contato_Profissional;
DROP TABLE IF EXISTS Endereco_Profissional;
DROP TABLE IF EXISTS Agendamento;
DROP TABLE IF EXISTS Servico;
DROP TABLE IF EXISTS Departamento;
DROP TABLE IF EXISTS Profissional;
DROP TABLE IF EXISTS Cliente;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Cliente (
  id_cliente INT NOT NULL,
  cliente_nome VARCHAR(100) NOT NULL,
  cliente_sobrenome VARCHAR(100) NOT NULL,
  cliente_cpf VARCHAR(13) NOT NULL,
  cliente_nascimento DATE NOT NULL,
  cliente_observacoes VARCHAR(500) NOT NULL,
  cliente_sexo VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_cliente),
  UNIQUE KEY cliente_cpf_unique (cliente_cpf)
) ENGINE = InnoDB;

CREATE TABLE Profissional (
  id_profissional INT NOT NULL,
  profissional_nome VARCHAR(100) NOT NULL,
  profissional_sobrenome VARCHAR(100) NOT NULL,
  profissional_cpf VARCHAR(13) NOT NULL,
  profissional_crm VARCHAR(20) NOT NULL,
  profissional_status TINYINT NOT NULL,
  PRIMARY KEY (id_profissional),
  UNIQUE KEY profissional_cpf_unique (profissional_cpf),
  UNIQUE KEY profissional_crm_unique (profissional_crm)
) ENGINE = InnoDB;

CREATE TABLE Departamento (
  id_departamento INT NOT NULL,
  departamento_nome VARCHAR(100) NOT NULL,
  departamento_descricao VARCHAR(500) NOT NULL,
  PRIMARY KEY (id_departamento),
  UNIQUE KEY departamento_nome_unique (departamento_nome)
) ENGINE = InnoDB;

CREATE TABLE Servico (
  id_servico INT NOT NULL,
  servico_nome VARCHAR(100) NOT NULL,
  servico_duracao INT NOT NULL,
  Departamento_id_departamento INT NOT NULL,
  PRIMARY KEY (id_servico),
  INDEX servico_departamento_idx (Departamento_id_departamento),
  CONSTRAINT servico_departamento_fk
    FOREIGN KEY (Departamento_id_departamento)
    REFERENCES Departamento (id_departamento)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Agendamento (
  id_agendamento INT NOT NULL,
  agendamento_data DATE NOT NULL,
  agendamento_horaInicio DATETIME NOT NULL,
  agendamento_horaFim DATETIME NOT NULL,
  agendamento_status VARCHAR(10) NOT NULL,
  agendamento_observacao VARCHAR(500) NULL,
  Profissional_id_Profissional INT NOT NULL,
  Servico_id_servico INT NOT NULL,
  PRIMARY KEY (id_agendamento),
  INDEX agendamento_profissional_idx (Profissional_id_Profissional),
  INDEX agendamento_servico_idx (Servico_id_servico),
  CONSTRAINT agendamento_profissional_fk
    FOREIGN KEY (Profissional_id_Profissional)
    REFERENCES Profissional (id_profissional)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT agendamento_servico_fk
    FOREIGN KEY (Servico_id_servico)
    REFERENCES Servico (id_servico)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Jornada_Profissional (
  id_jornadaProfissional INT NOT NULL AUTO_INCREMENT,
  jornada_semana TINYINT NOT NULL,
  jornada_inicio TIME NOT NULL,
  jornada_fim TIME NOT NULL,
  jornada_inicioAlmoco TIME NOT NULL,
  jornada_fimAlmoco TIME NOT NULL,
  Profissional_id_profissional INT NOT NULL,
  PRIMARY KEY (id_jornadaProfissional),
  INDEX jornada_profissional_idx (Profissional_id_profissional),
  CONSTRAINT jornada_profissional_fk
    FOREIGN KEY (Profissional_id_profissional)
    REFERENCES Profissional (id_profissional)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Endereco_Profissional (
  id_enderecoProf INT NOT NULL,
  enderecoProf_rua VARCHAR(100) NOT NULL,
  enderecoProf_bairro VARCHAR(100) NOT NULL,
  enderecoProf_numero VARCHAR(10) NOT NULL,
  enderecoProf_cep VARCHAR(9) NOT NULL,
  Profissional_id_Profissional INT NOT NULL,
  PRIMARY KEY (id_enderecoProf),
  INDEX endereco_profissional_idx (Profissional_id_Profissional),
  CONSTRAINT endereco_profissional_fk
    FOREIGN KEY (Profissional_id_Profissional)
    REFERENCES Profissional (id_profissional)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Contato_Profissional (
  id_contatoProfissional INT NOT NULL,
  contatoProf_email VARCHAR(100) NOT NULL,
  contatoProf_telefone VARCHAR(14) NOT NULL,
  Profissional_id_profissional INT NOT NULL,
  PRIMARY KEY (id_contatoProfissional),
  INDEX contato_profissional_idx (Profissional_id_profissional),
  CONSTRAINT contato_profissional_fk
    FOREIGN KEY (Profissional_id_profissional)
    REFERENCES Profissional (id_profissional)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Endereco_Cliente (
  id_enderecoCliente INT NOT NULL,
  enderecoClien_rua VARCHAR(100) NOT NULL,
  enderecoClien_bairro VARCHAR(100) NOT NULL,
  enderecoClien_numero VARCHAR(10) NOT NULL,
  enderecoClien_cep VARCHAR(9) NOT NULL,
  Cliente_id_cliente INT NOT NULL,
  PRIMARY KEY (id_enderecoCliente),
  INDEX endereco_cliente_idx (Cliente_id_cliente),
  CONSTRAINT endereco_cliente_fk
    FOREIGN KEY (Cliente_id_cliente)
    REFERENCES Cliente (id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Contato_Cliente (
  id_contatoCliente INT NOT NULL,
  contatoClien_email VARCHAR(100) NOT NULL,
  contatoClien_telefone VARCHAR(14) NOT NULL,
  Cliente_id_cliente INT NOT NULL,
  PRIMARY KEY (id_contatoCliente),
  INDEX contato_cliente_idx (Cliente_id_cliente),
  CONSTRAINT contato_cliente_fk
    FOREIGN KEY (Cliente_id_cliente)
    REFERENCES Cliente (id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Profissional_has_Servico (
  id_profissionalServico INT NOT NULL AUTO_INCREMENT,
  Servico_id_servico INT NOT NULL,
  Profissional_id_profissional INT NOT NULL,
  PRIMARY KEY (id_profissionalServico),
  UNIQUE KEY profissional_servico_unique (Servico_id_servico, Profissional_id_profissional),
  CONSTRAINT profissional_servico_servico_fk
    FOREIGN KEY (Servico_id_servico)
    REFERENCES Servico (id_servico)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT profissional_servico_profissional_fk
    FOREIGN KEY (Profissional_id_profissional)
    REFERENCES Profissional (id_profissional)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Departamento_has_Profissional (
  Departamento_id_departamento INT NOT NULL,
  Profissional_id_Profissional INT NOT NULL,
  PRIMARY KEY (Departamento_id_departamento, Profissional_id_Profissional),
  CONSTRAINT departamento_profissional_departamento_fk
    FOREIGN KEY (Departamento_id_departamento)
    REFERENCES Departamento (id_departamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT departamento_profissional_profissional_fk
    FOREIGN KEY (Profissional_id_Profissional)
    REFERENCES Profissional (id_profissional)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Agendamento_has_Cliente (
  id_agendamentoCliente INT NOT NULL AUTO_INCREMENT,
  Cliente_id_cliente INT NOT NULL,
  Agendamento_id_agendamento INT NOT NULL,
  PRIMARY KEY (id_agendamentoCliente),
  UNIQUE KEY agendamento_cliente_unique (Cliente_id_cliente, Agendamento_id_agendamento),
  CONSTRAINT agendamento_cliente_cliente_fk
    FOREIGN KEY (Cliente_id_cliente)
    REFERENCES Cliente (id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT agendamento_cliente_agendamento_fk
    FOREIGN KEY (Agendamento_id_agendamento)
    REFERENCES Agendamento (id_agendamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

INSERT INTO Cliente VALUES
  (1, 'Ana', 'Silva', '11122233344', '1995-03-12', 'Pele sensivel', 'Feminino'),
  (2, 'Bruno', 'Souza', '22233344455', '1988-09-21', 'Prefere horarios pela tarde', 'Masculino'),
  (3, 'Carla', 'Mendes', '33344455566', '1992-11-05', 'Cliente recorrente', 'Feminino');

INSERT INTO Profissional VALUES
  (1, 'Marina', 'Alves', '44455566677', 'CRM12345', 1),
  (2, 'Rafael', 'Costa', '55566677788', 'CRM67890', 1),
  (3, 'Livia', 'Barros', '66677788899', 'CRM24680', 1);

INSERT INTO Departamento VALUES
  (1, 'Facial', 'Procedimentos esteticos faciais'),
  (2, 'Corporal', 'Procedimentos esteticos corporais'),
  (3, 'Laser', 'Tratamentos com equipamentos a laser');

INSERT INTO Servico VALUES
  (1, 'Limpeza de pele', 60, 1),
  (2, 'Drenagem linfatica', 50, 2),
  (3, 'Depilacao a laser', 40, 3);

INSERT INTO Agendamento VALUES
  (1, '2026-06-24', '2026-06-24 09:00:00', '2026-06-24 10:00:00', 'marcado', 'Primeira avaliacao', 1, 1),
  (2, '2026-06-24', '2026-06-24 14:00:00', '2026-06-24 14:50:00', 'marcado', NULL, 2, 2),
  (3, '2026-06-25', '2026-06-25 10:30:00', '2026-06-25 11:10:00', 'marcado', 'Sessao mensal', 3, 3);

INSERT INTO Agendamento_has_Cliente (Cliente_id_cliente, Agendamento_id_agendamento) VALUES
  (1, 1),
  (2, 2),
  (3, 3);

CREATE OR REPLACE VIEW vw_agenda_completa AS
SELECT
  a.id_agendamento,
  a.agendamento_data,
  a.agendamento_horaInicio,
  a.agendamento_horaFim,
  a.agendamento_status,
  s.servico_nome,
  d.departamento_nome,
  CONCAT(p.profissional_nome, ' ', p.profissional_sobrenome) AS profissional_nome,
  CONCAT(c.cliente_nome, ' ', c.cliente_sobrenome) AS cliente_nome
FROM Agendamento a
INNER JOIN Profissional p ON p.id_profissional = a.Profissional_id_Profissional
INNER JOIN Servico s ON s.id_servico = a.Servico_id_servico
INNER JOIN Departamento d ON d.id_departamento = s.Departamento_id_departamento
LEFT JOIN Agendamento_has_Cliente ac ON ac.Agendamento_id_agendamento = a.id_agendamento
LEFT JOIN Cliente c ON c.id_cliente = ac.Cliente_id_cliente;
