-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema frockoverflowdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `frockoverflowdb` ;

-- -----------------------------------------------------
-- Schema frockoverflowdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `frockoverflowdb` DEFAULT CHARACTER SET utf8 ;
USE `frockoverflowdb` ;

-- -----------------------------------------------------
-- Table `frockoverflowdb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`user` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `type` TINYINT(3) NOT NULL DEFAULT 1,
  `display_name` VARCHAR(45) NOT NULL,
  `date_created` DATETIME NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `theme` INT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `email_UNIQUE` ON `frockoverflowdb`.`user` (`email` ASC);


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`question` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`question` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `body` VARCHAR(2000) NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT 'Posted',
  `rating` INT NULL DEFAULT 0,
  `views` INT NULL DEFAULT 0,
  `flag` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`answer` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`answer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `question_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `body` VARCHAR(2000) NOT NULL,
  `answer_status` VARCHAR(45) NULL DEFAULT 'Posted',
  `rating` INT NULL DEFAULT 0,
  `flag` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`tag` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`tag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `body` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `body_UNIQUE` ON `frockoverflowdb`.`tag` (`body` ASC);


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`tag_assignment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`tag_assignment` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`tag_assignment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tag_id` INT NOT NULL,
  `question_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`vote` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`vote` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `value` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`vote_assignment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`vote_assignment` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`vote_assignment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `answer_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `vote_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`qcomment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`qcomment` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`qcomment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `body` VARCHAR(500) NOT NULL,
  `question_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`acomment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`acomment` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`acomment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `body` VARCHAR(500) NOT NULL,
  `answer_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `frockoverflowdb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `frockoverflowdb`;
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`, `theme`) VALUES (1001, 'Sarah', 'Lobser', 'sarah.lobser@gmail.com', 2, 'lobes', NOW(), 'stub', NULL);
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`, `theme`) VALUES (1002, 'Tim', 'Brunk', 'timothybrunk@gmail.com', 2, 'brunky', NOW(), 'password', NULL);
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`, `theme`) VALUES (1003, 'Brenton', 'Gumucio', 'brenton.gumucio@gmail.com', 2, 'gumi', NOW(), 'brenton', NULL);
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`, `theme`) VALUES (1000, 'Arnold', 'Poindexter', 'guest@email.com', 0, 'guest', NOW(), 'guest', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `frockoverflowdb`.`question`
-- -----------------------------------------------------
START TRANSACTION;
USE `frockoverflowdb`;
INSERT INTO `frockoverflowdb`.`question` (`id`, `user_id`, `timestamp`, `body`, `status`, `rating`, `views`, `flag`) VALUES (1, 1001, NOW(), 'how do I work this fancy machine?', 'Posted', 0, 0, NULL);
INSERT INTO `frockoverflowdb`.`question` (`id`, `user_id`, `timestamp`, `body`, `status`, `rating`, `views`, `flag`) VALUES (2, 1002, NOW(), 'how come my code doesn\'t do stuff?', 'Posted', 0, 0, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `frockoverflowdb`.`answer`
-- -----------------------------------------------------
START TRANSACTION;
USE `frockoverflowdb`;
INSERT INTO `frockoverflowdb`.`answer` (`id`, `user_id`, `question_id`, `timestamp`, `body`, `answer_status`, `rating`, `flag`) VALUES (1, 1002, 1, NOW(), 'Try turning the machine \"on\"', 'Posted', 0, '');
INSERT INTO `frockoverflowdb`.`answer` (`id`, `user_id`, `question_id`, `timestamp`, `body`, `answer_status`, `rating`, `flag`) VALUES (2, 1001, 2, NOW(), 'You forgot a semicolon ;', 'Posted', 0, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `frockoverflowdb`.`tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `frockoverflowdb`;
INSERT INTO `frockoverflowdb`.`tag` (`id`, `body`) VALUES (1, 'java');
INSERT INTO `frockoverflowdb`.`tag` (`id`, `body`) VALUES (2, 'nerds');
INSERT INTO `frockoverflowdb`.`tag` (`id`, `body`) VALUES (3, 'beans');
INSERT INTO `frockoverflowdb`.`tag` (`id`, `body`) VALUES (4, 'jpa');
INSERT INTO `frockoverflowdb`.`tag` (`id`, `body`) VALUES (5, 'sql');

COMMIT;


-- -----------------------------------------------------
-- Data for table `frockoverflowdb`.`tag_assignment`
-- -----------------------------------------------------
START TRANSACTION;
USE `frockoverflowdb`;
INSERT INTO `frockoverflowdb`.`tag_assignment` (`id`, `tag_id`, `question_id`) VALUES (1, 1, 1);
INSERT INTO `frockoverflowdb`.`tag_assignment` (`id`, `tag_id`, `question_id`) VALUES (2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `frockoverflowdb`.`vote`
-- -----------------------------------------------------
START TRANSACTION;
USE `frockoverflowdb`;
INSERT INTO `frockoverflowdb`.`vote` (`id`, `value`) VALUES (1, 1);
INSERT INTO `frockoverflowdb`.`vote` (`id`, `value`) VALUES (2, -1);

COMMIT;

