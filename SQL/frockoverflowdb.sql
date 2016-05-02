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
  `body` VARCHAR(1000) NOT NULL,
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
  `body` VARCHAR(1000) NOT NULL,
  `answer_status` VARCHAR(45) NULL DEFAULT 'Posted',
  `rating` INT NULL DEFAULT 0,
  `flag` VARCHAR(45) NULL,
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
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`) VALUES (1001, 'Sarah', 'Lobser', 'sarah.lobser@gmail.com', 2, 'lobes', NOW(), 'stub');
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`) VALUES (1002, 'Tim', 'Brunk', 'timothybrunk@gmail.com', 2, 'brunky', NOW(), 'password');
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`) VALUES (1003, 'Brenton', 'Gumucio', 'brenton.gumucio@gmail.com', 2, 'gumi', NOW(), 'brenton');
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`) VALUES (1000, 'Arnold', 'Poindexter', 'guest@email.com', 0, 'guest', NOW(), 'guest');

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

