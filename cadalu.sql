-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           10.4.17-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versão:              11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for cadalu
CREATE DATABASE IF NOT EXISTS `cadalu` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `cadalu`;

-- Dumping structure for table cadalu.agrupamentos
CREATE TABLE IF NOT EXISTS `agrupamentos` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`identidade`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.agrupamentos: ~2 rows (approximately)
/*!40000 ALTER TABLE `agrupamentos` DISABLE KEYS */;
INSERT INTO `agrupamentos` (`identidade`, `nome`) VALUES
	(1, 'Agrupamento 1'),
	(2, 'Agrupamento 2');
/*!40000 ALTER TABLE `agrupamentos` ENABLE KEYS */;

-- Dumping structure for table cadalu.alunos
CREATE TABLE IF NOT EXISTS `alunos` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL DEFAULT '0',
  `turma` int(11) NOT NULL,
  `pai1` int(11) NOT NULL,
  `pai2` int(11) DEFAULT NULL,
  PRIMARY KEY (`identidade`),
  KEY `FK_alunos_turmas` (`turma`),
  KEY `FK_alunos_pais` (`pai1`),
  KEY `FK_alunos_pais_2` (`pai2`),
  CONSTRAINT `FK_alunos_pais` FOREIGN KEY (`pai1`) REFERENCES `pais` (`identidade`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_alunos_pais_2` FOREIGN KEY (`pai2`) REFERENCES `pais` (`identidade`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_alunos_turmas` FOREIGN KEY (`turma`) REFERENCES `turmas` (`identidade`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.alunos: ~3 rows (approximately)
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` (`identidade`, `nome`, `turma`, `pai1`, `pai2`) VALUES
	(1, 'Francisco', 1, 1, 2),
	(2, 'Antonieta', 2, 3, NULL),
	(3, 'Josué', 3, 2, 1);
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;

-- Dumping structure for table cadalu.avaliacoes
CREATE TABLE IF NOT EXISTS `avaliacoes` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `aval` varchar(50) NOT NULL,
  `tipo` varchar(250) NOT NULL DEFAULT '0',
  `aluno` int(11) NOT NULL DEFAULT 0,
  `avaliador` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identidade`),
  KEY `FK_avaliacoes_alunos` (`aluno`),
  KEY `FK_avaliacoes_professores` (`avaliador`),
  CONSTRAINT `FK_avaliacoes_alunos` FOREIGN KEY (`aluno`) REFERENCES `alunos` (`identidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_avaliacoes_professores` FOREIGN KEY (`avaliador`) REFERENCES `professores` (`identidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.avaliacoes: ~5 rows (approximately)
/*!40000 ALTER TABLE `avaliacoes` DISABLE KEYS */;
INSERT INTO `avaliacoes` (`identidade`, `aval`, `tipo`, `aluno`, `avaliador`) VALUES
	(1, 'Aprovado - Excelente', '1º Período', 1, 2),
	(2, 'Muito Bom', 'Teste', 3, 1),
	(3, '3', '1º Período', 3, 1),
	(4, 'Bom', 'Teste', 2, 1),
	(5, '4', '1º Período', 2, 1);
/*!40000 ALTER TABLE `avaliacoes` ENABLE KEYS */;

-- Dumping structure for table cadalu.disciplinas
CREATE TABLE IF NOT EXISTS `disciplinas` (
  `turma` int(11) NOT NULL,
  `professor` int(11) NOT NULL,
  PRIMARY KEY (`turma`,`professor`) USING BTREE,
  KEY `FK_disciplinas_professores` (`professor`),
  CONSTRAINT `FK_disciplinas_professores` FOREIGN KEY (`professor`) REFERENCES `professores` (`identidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_disciplinas_turmas` FOREIGN KEY (`turma`) REFERENCES `turmas` (`identidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.disciplinas: ~3 rows (approximately)
/*!40000 ALTER TABLE `disciplinas` DISABLE KEYS */;
INSERT INTO `disciplinas` (`turma`, `professor`) VALUES
	(1, 2),
	(2, 1),
	(3, 1);
/*!40000 ALTER TABLE `disciplinas` ENABLE KEYS */;

-- Dumping structure for table cadalu.escolas
CREATE TABLE IF NOT EXISTS `escolas` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL DEFAULT 'Escola',
  `agrup` int(11) NOT NULL,
  PRIMARY KEY (`identidade`),
  KEY `FK_escolas_agrupamentos` (`agrup`),
  CONSTRAINT `FK_escolas_agrupamentos` FOREIGN KEY (`agrup`) REFERENCES `agrupamentos` (`identidade`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.escolas: ~2 rows (approximately)
/*!40000 ALTER TABLE `escolas` DISABLE KEYS */;
INSERT INTO `escolas` (`identidade`, `nome`, `agrup`) VALUES
	(1, 'Escola 1', 1),
	(2, 'Escola 2', 2);
/*!40000 ALTER TABLE `escolas` ENABLE KEYS */;

-- Dumping structure for table cadalu.mensagens
CREATE TABLE IF NOT EXISTS `mensagens` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `aluno` int(11) NOT NULL,
  `tema` varchar(50) NOT NULL,
  `texto` varchar(255) DEFAULT 'Sem texto...',
  `professor` int(11) NOT NULL,
  `datahora` date NOT NULL DEFAULT curdate(),
  `enviada` binary(2) NOT NULL,
  PRIMARY KEY (`identidade`),
  KEY `FK_mensagens_professores` (`professor`),
  KEY `FK_mensagens_alunos` (`aluno`),
  CONSTRAINT `FK_mensagens_alunos` FOREIGN KEY (`aluno`) REFERENCES `alunos` (`identidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_mensagens_professores` FOREIGN KEY (`professor`) REFERENCES `professores` (`identidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.mensagens: ~2 rows (approximately)
/*!40000 ALTER TABLE `mensagens` DISABLE KEYS */;
INSERT INTO `mensagens` (`identidade`, `aluno`, `tema`, `texto`, `professor`, `datahora`, `enviada`) VALUES
	(1, 1, 'O seu filho tem piolhos', 'Apanhou-os hoje na escola.', 2, '2021-12-15', _binary 0x0000),
	(2, 3, 'O Josué mordeu a grade de ferro', 'Hoje, logo após ter comido espinafres. Levado ao dentista o gradeamento afectado. Não há danos estruturais.', 1, '2021-12-16', _binary 0x0000),
	(3, 2, 'Publicação dos horários no placard', 'Foram hoje publicados os horários para o 6º ano.', 2, '2021-11-09', _binary 0x0000);
/*!40000 ALTER TABLE `mensagens` ENABLE KEYS */;

-- Dumping structure for table cadalu.pais
CREATE TABLE IF NOT EXISTS `pais` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telefone` int(9) NOT NULL DEFAULT 13456789,
  `password` varchar(255) NOT NULL DEFAULT '123456',
  PRIMARY KEY (`identidade`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.pais: ~3 rows (approximately)
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` (`identidade`, `nome`, `email`, `telefone`, `password`) VALUES
	(1, 'Vitor Castro', 'v.castro@kamil.com', 912365987, '123456'),
	(2, 'Amelia Sousa', 'asousa@kamil.com', 923456123, '123456'),
	(3, 'Josefina Teixeira', 'j.teixeira@kamil.com', 921654987, '123456');
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;

-- Dumping structure for table cadalu.professores
CREATE TABLE IF NOT EXISTS `professores` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telefone` int(9) NOT NULL DEFAULT 123456789,
  `disciplina` varchar(50) NOT NULL DEFAULT 'Geral',
  `password` varchar(50) NOT NULL DEFAULT '123456',
  `escola` int(11) NOT NULL,
  PRIMARY KEY (`identidade`),
  KEY `FK_professores_escolas` (`escola`),
  CONSTRAINT `FK_professores_escolas` FOREIGN KEY (`escola`) REFERENCES `escolas` (`identidade`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.professores: ~2 rows (approximately)
/*!40000 ALTER TABLE `professores` DISABLE KEYS */;
INSERT INTO `professores` (`identidade`, `nome`, `email`, `telefone`, `disciplina`, `password`, `escola`) VALUES
	(1, 'José Manel', 'j.manel@hmail.com', 965123456, 'Historia', '123456', 2),
	(2, 'Maria Rita', 'm.rita@jmail.com', 945123456, 'Geral', '123456', 1);
/*!40000 ALTER TABLE `professores` ENABLE KEYS */;

-- Dumping structure for table cadalu.sumario
CREATE TABLE IF NOT EXISTS `sumario` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `professor` int(11) NOT NULL,
  `turma` int(11) NOT NULL,
  `texto` varchar(255) NOT NULL,
  `datah` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`identidade`),
  KEY `FK_sumario_professores` (`professor`),
  KEY `FK_sumario_turmas` (`turma`),
  CONSTRAINT `FK_sumario_professores` FOREIGN KEY (`professor`) REFERENCES `professores` (`identidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_sumario_turmas` FOREIGN KEY (`turma`) REFERENCES `turmas` (`identidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.sumario: ~5 rows (approximately)
/*!40000 ALTER TABLE `sumario` DISABLE KEYS */;
INSERT INTO `sumario` (`identidade`, `professor`, `turma`, `texto`, `datah`) VALUES
	(1, 2, 1, 'Inglês - Verbo "To Be"', '2021-12-23'),
	(2, 1, 3, 'A reconquista', '2021-12-23'),
	(3, 2, 1, 'Matemática - Inequações', '2021-12-23'),
	(4, 2, 1, 'Português - "Os Lusíadas"', '2021-12-23'),
	(5, 1, 2, 'A Batalha de Aljubarrota', '2021-12-23');
/*!40000 ALTER TABLE `sumario` ENABLE KEYS */;

-- Dumping structure for table cadalu.turmas
CREATE TABLE IF NOT EXISTS `turmas` (
  `identidade` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL DEFAULT 'turma',
  `escola` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identidade`),
  KEY `FK_turmas_escolas` (`escola`),
  CONSTRAINT `FK_turmas_escolas` FOREIGN KEY (`escola`) REFERENCES `escolas` (`identidade`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cadalu.turmas: ~3 rows (approximately)
/*!40000 ALTER TABLE `turmas` DISABLE KEYS */;
INSERT INTO `turmas` (`identidade`, `nome`, `escola`) VALUES
	(1, '2ªClasse', 1),
	(2, '6ªB', 2),
	(3, '5ºA', 2);
/*!40000 ALTER TABLE `turmas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
