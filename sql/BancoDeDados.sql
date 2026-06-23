-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Profissional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Profissional` (
  `id_profissional` INT NOT NULL,
  `profissional_nome` VARCHAR(100) NOT NULL,
  `profissional_sobrenome` VARCHAR(100) NOT NULL,
  `profissional_cpf` VARCHAR(13) NOT NULL,
  `profissional_crm` VARCHAR(20) NOT NULL,
  `profissional_status` TINYINT NOT NULL,
  PRIMARY KEY (`id_profissional`),
  UNIQUE INDEX `profissional_cpf_UNIQUE` (`profissional_cpf` ASC) VISIBLE,
  UNIQUE INDEX `profissional_crm_UNIQUE` (`profissional_crm` ASC) VISIBLE,
  UNIQUE INDEX `Jornada Profissional_id_jornadaProfissional_UNIQUE` () VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `id_cliente` INT NOT NULL,
  `cliente_nome` VARCHAR(100) NOT NULL,
  `cliente_sobrenome` VARCHAR(100) NOT NULL,
  `cliente_cpf` VARCHAR(13) NOT NULL,
  `cliente_nascimento` DATE NOT NULL,
  `cliente_observacoes` VARCHAR(500) NOT NULL,
  `cliente_sexo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `Clientecol_UNIQUE` (`cliente_cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jornada_Profissional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jornada_Profissional` (
  `id_jornadaProfissional` INT NOT NULL AUTO_INCREMENT,
  `jornada_semana` TINYINT NOT NULL,
  `jornada_inicio` TIME NOT NULL,
  `jornada_fim` TIME NOT NULL,
  `jornada_inicioAlmoco` TIME NOT NULL,
  `jornada_fimAlmoco` TIME NOT NULL,
  `Profissional_id_profissional` INT NOT NULL,
  PRIMARY KEY (`id_jornadaProfissional`),
  UNIQUE INDEX `id_jornadaProfissional_UNIQUE` (`id_jornadaProfissional` ASC) VISIBLE,
  INDEX `fk_Jornada_Profissional_Profissional1_idx` (`Profissional_id_profissional` ASC) VISIBLE,
  CONSTRAINT `fk_Jornada_Profissional_Profissional1`
    FOREIGN KEY (`Profissional_id_profissional`)
    REFERENCES `mydb`.`Profissional` (`id_profissional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco_Profissional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco_Profissional` (
  `id_endereçoProf` INT NOT NULL,
  `enderecoProf_rua` VARCHAR(100) NOT NULL,
  `endereçoProf_bairro` VARCHAR(100) NOT NULL,
  `enderecoProf_numero` VARCHAR(3) NOT NULL,
  `enderecoProf_cep` VARCHAR(9) NOT NULL,
  `Profissional_id_Profissional` INT NOT NULL,
  PRIMARY KEY (`id_endereçoProf`),
  INDEX `fk_Endereco_Profissional1_idx` (`Profissional_id_Profissional` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Profissional1`
    FOREIGN KEY (`Profissional_id_Profissional`)
    REFERENCES `mydb`.`Profissional` (`id_profissional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contato_Profissional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contato_Profissional` (
  `id_contatoProfissional` INT NOT NULL,
  `contatoProf_email` VARCHAR(100) NOT NULL,
  `contatoProf_telefone` VARCHAR(14) NOT NULL,
  `Profissional_id_profissional` INT NOT NULL,
  PRIMARY KEY (`id_contatoProfissional`),
  INDEX `fk_Contato_Profissional1_idx` (`Profissional_id_profissional` ASC) VISIBLE,
  CONSTRAINT `fk_Contato_Profissional1`
    FOREIGN KEY (`Profissional_id_profissional`)
    REFERENCES `mydb`.`Profissional` (`id_profissional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `id_departamento` INT NOT NULL,
  `departamento_nome` VARCHAR(100) NOT NULL,
  `departamento_descricao` VARCHAR(500) NOT NULL,
  `Servico_id_servico` INT NOT NULL,
  PRIMARY KEY (`id_departamento`),
  UNIQUE INDEX `departamento_nome_UNIQUE` (`departamento_nome` ASC) VISIBLE,
  INDEX `fk_Departamento_Servico1_idx` (`Servico_id_servico` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_Servico1`
    FOREIGN KEY (`Servico_id_servico`)
    REFERENCES `mydb`.`Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servico` (
  `id_servico` INT NOT NULL,
  `servico_nome` VARCHAR(100) NOT NULL,
  `servico_duracao` INT NOT NULL,
  `Departamento_id_departamento` INT NOT NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `fk_Servico_Departamento1_idx` (`Departamento_id_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_Departamento1`
    FOREIGN KEY (`Departamento_id_departamento`)
    REFERENCES `mydb`.`Departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Agendamento` (
  `id_agendamento` INT NOT NULL,
  `agendamento_data` DATE NOT NULL,
  `agendamento_horaInicio` DATETIME NOT NULL,
  `agendamento_status` VARCHAR(10) NOT NULL,
  `agendamento_observacao` VARCHAR(500) NULL,
  `Profissional_id_Profissional` INT NOT NULL,
  `Servico_id_servico` INT NOT NULL,
  `agendamento_horaFim` DATETIME NOT NULL,
  PRIMARY KEY (`id_agendamento`),
  INDEX `fk_Agendamento_Profissional1_idx` (`Profissional_id_Profissional` ASC) VISIBLE,
  INDEX `fk_Agendamento_Servico1_idx` (`Servico_id_servico` ASC) VISIBLE,
  CONSTRAINT `fk_Agendamento_Profissional1`
    FOREIGN KEY (`Profissional_id_Profissional`)
    REFERENCES `mydb`.`Profissional` (`id_profissional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agendamento_Servico1`
    FOREIGN KEY (`Servico_id_servico`)
    REFERENCES `mydb`.`Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Profissional_has_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Profissional_has_Servico` (
  `id_profissionalServico` INT NOT NULL AUTO_INCREMENT,
  `Servico_id_servico` INT NOT NULL,
  `Profissional_id_profissional` INT NOT NULL,
  INDEX `fk_Servico_has_Profissional_Profissional1_idx` (`Profissional_id_profissional` ASC) VISIBLE,
  INDEX `fk_Servico_has_Profissional_Servico1_idx` (`Servico_id_servico` ASC) VISIBLE,
  PRIMARY KEY (`id_profissionalServico`),
  CONSTRAINT `fk_Servico_has_Profissional_Servico1`
    FOREIGN KEY (`Servico_id_servico`)
    REFERENCES `mydb`.`Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Profissional_Profissional1`
    FOREIGN KEY (`Profissional_id_profissional`)
    REFERENCES `mydb`.`Profissional` (`id_profissional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Departamento_has_Profissional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Departamento_has_Profissional` (
  `Departamento_id_departamento` INT NOT NULL,
  `Profissional_id_Profissional` INT NOT NULL,
  PRIMARY KEY (`Departamento_id_departamento`, `Profissional_id_Profissional`),
  INDEX `fk_Departamento_has_Profissional_Profissional1_idx` (`Profissional_id_Profissional` ASC) VISIBLE,
  INDEX `fk_Departamento_has_Profissional_Departamento1_idx` (`Departamento_id_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_has_Profissional_Departamento1`
    FOREIGN KEY (`Departamento_id_departamento`)
    REFERENCES `mydb`.`Departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Departamento_has_Profissional_Profissional1`
    FOREIGN KEY (`Profissional_id_Profissional`)
    REFERENCES `mydb`.`Profissional` (`id_profissional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Agendamento_has_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Agendamento_has_Cliente` (
  `id_agendamentoCliente` INT NOT NULL AUTO_INCREMENT,
  `Cliente_id_cliente` INT NOT NULL,
  `Agendamento_id_agendamento` INT NOT NULL,
  PRIMARY KEY (`id_agendamentoCliente`),
  INDEX `fk_Cliente_has_Agendamento_Agendamento1_idx` (`Agendamento_id_agendamento` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Agendamento_Cliente1_idx` (`Cliente_id_cliente` ASC) VISIBLE,
  UNIQUE INDEX `id_agendamentoCliente_UNIQUE` (`id_agendamentoCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Agendamento_Cliente1`
    FOREIGN KEY (`Cliente_id_cliente`)
    REFERENCES `mydb`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Agendamento_Agendamento1`
    FOREIGN KEY (`Agendamento_id_agendamento`)
    REFERENCES `mydb`.`Agendamento` (`id_agendamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `id_departamento` INT NOT NULL,
  `departamento_nome` VARCHAR(100) NOT NULL,
  `departamento_descricao` VARCHAR(500) NOT NULL,
  `Servico_id_servico` INT NOT NULL,
  PRIMARY KEY (`id_departamento`),
  UNIQUE INDEX `departamento_nome_UNIQUE` (`departamento_nome` ASC) VISIBLE,
  INDEX `fk_Departamento_Servico1_idx` (`Servico_id_servico` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_Servico1`
    FOREIGN KEY (`Servico_id_servico`)
    REFERENCES `mydb`.`Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Profissional_has_Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Profissional_has_Departamento` (
  `id_profissionalDepartamento` INT NOT NULL AUTO_INCREMENT,
  `Departamento_id_departamento` INT NOT NULL,
  `Profissional_id_profissional` INT NOT NULL,
  PRIMARY KEY (`id_profissionalDepartamento`),
  INDEX `fk_Departamento_has_Profissional1_Profissional1_idx` (`Profissional_id_profissional` ASC) VISIBLE,
  INDEX `fk_Departamento_has_Profissional1_Departamento1_idx` (`Departamento_id_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_has_Profissional1_Departamento1`
    FOREIGN KEY (`Departamento_id_departamento`)
    REFERENCES `mydb`.`Departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Departamento_has_Profissional1_Profissional1`
    FOREIGN KEY (`Profissional_id_profissional`)
    REFERENCES `mydb`.`Profissional` (`id_profissional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jornada Profissional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jornada Profissional` (
  `id_jornadaProfissional` INT NOT NULL AUTO_INCREMENT,
  `Profissional_id_profissional` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_jornadaProfissional`),
  UNIQUE INDEX `id_jornadaProfissional_UNIQUE` (`id_jornadaProfissional` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jornada_Profissional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jornada_Profissional` (
  `id_jornadaProfissional` INT NOT NULL AUTO_INCREMENT,
  `jornada_semana` TINYINT NOT NULL,
  `jornada_inicio` TIME NOT NULL,
  `jornada_fim` TIME NOT NULL,
  `jornada_inicioAlmoco` TIME NOT NULL,
  `jornada_fimAlmoco` TIME NOT NULL,
  `Profissional_id_profissional` INT NOT NULL,
  PRIMARY KEY (`id_jornadaProfissional`),
  UNIQUE INDEX `id_jornadaProfissional_UNIQUE` (`id_jornadaProfissional` ASC) VISIBLE,
  INDEX `fk_Jornada_Profissional_Profissional1_idx` (`Profissional_id_profissional` ASC) VISIBLE,
  CONSTRAINT `fk_Jornada_Profissional_Profissional1`
    FOREIGN KEY (`Profissional_id_profissional`)
    REFERENCES `mydb`.`Profissional` (`id_profissional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco_Cliente` (
  `id_endereçoCliente` INT NOT NULL,
  `enderecoClien_rua` VARCHAR(100) NOT NULL,
  `endereçoClien_bairro` VARCHAR(100) NOT NULL,
  `enderecoClien_numero` VARCHAR(3) NOT NULL,
  `enderecoClien_cep` VARCHAR(9) NOT NULL,
  `Cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_endereçoCliente`),
  INDEX `fk_Endereco_Cliente_idx` (`Cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Cliente0`
    FOREIGN KEY (`Cliente_id_cliente`)
    REFERENCES `mydb`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contato_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contato_Cliente` (
  `id_contatoCliente` INT NOT NULL,
  `contatoClien_email` VARCHAR(100) NOT NULL,
  `contatoClien_telefone` VARCHAR(14) NOT NULL,
  `Cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_contatoCliente`),
  INDEX `fk_Contato_Cliente1_idx` (`Cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Contato_Cliente10`
    FOREIGN KEY (`Cliente_id_cliente`)
    REFERENCES `mydb`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
