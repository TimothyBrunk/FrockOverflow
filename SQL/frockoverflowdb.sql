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
  `email` VARCHAR(45) NULL,
  `type` TINYINT(2) NOT NULL,
  `display_name` VARCHAR(45) NOT NULL,
  `date_created` DATE NOT NULL,
  `password` VARCHAR(45) NULL,
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
  `timestamp` DATE NOT NULL,
  `body` VARCHAR(1000) NOT NULL,
  `status` VARCHAR(45) NULL,
  `rating` INT NULL,
  `views` INT NULL,
  `flag` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frockoverflowdb`.`answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frockoverflowdb`.`answer` ;

CREATE TABLE IF NOT EXISTS `frockoverflowdb`.`answer` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `question_id` INT NOT NULL,
  `timestamp` DATE NULL,
  `body` VARCHAR(1000) NOT NULL,
  `rating` INT NULL,
  `answer_status` VARCHAR(45) NULL,
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
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`) VALUES (1001, 'Sarah', 'Lobser', 'sarah.lobser@gmail.com', 1, 'lobes', NOW(), 'stub');
INSERT INTO `frockoverflowdb`.`user` (`id`, `firstname`, `lastname`, `email`, `type`, `display_name`, `date_created`, `password`) VALUES (1002, 'Tim', 'Brunk', 'timothybrunk@gmail.com', 1, 'brunky', NOW(), 'password');

COMMIT;


-- -----------------------------------------------------
-- Data for table `frockoverflowdb`.`question`
-- -----------------------------------------------------
START TRANSACTION;
USE `frockoverflowdb`;
INSERT INTO `frockoverflowdb`.`question` (`id`, `user_id`, `timestamp`, `body`, `status`, `rating`, `views`, `flag`) VALUES (1, 1001, NOW(), 'how do I work this fancy machine?', 'pending', 0, 0, NULL);
INSERT INTO `frockoverflowdb`.`question` (`id`, `user_id`, `timestamp`, `body`, `status`, `rating`, `views`, `flag`) VALUES (2, 1002, NOW(), 'how come my code doesn\'t do stuff?', 'pending', 0, 0, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `frockoverflowdb`.`answer`
-- -----------------------------------------------------
START TRANSACTION;
USE `frockoverflowdb`;
INSERT INTO `frockoverflowdb`.`answer` (`id`, `user_id`, `question_id`, `timestamp`, `body`, `rating`, `answer_status`, `flag`) VALUES (1, 1002, 1, 'NOW()', 'pending', NOW(), 'pending', 'Try turning the machine \"on\"');
INSERT INTO `frockoverflowdb`.`answer` (`id`, `user_id`, `question_id`, `timestamp`, `body`, `rating`, `answer_status`, `flag`) VALUES (2, 1001, 2, 'NOW()', 'pending', NOW(), 'pending', 'You forgot a semicolon ;');

COMMIT;

