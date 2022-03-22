-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ssafit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ssafit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ssafit` DEFAULT CHARACTER SET utf8 ;
USE `ssafit` ;

-- -----------------------------------------------------
-- Table `ssafit`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`user` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`user` (
  `id` VARCHAR(50) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ssafit`.`follow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`follow` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`follow` (
  `follow_id` VARCHAR(50) NOT NULL,
  `user_id` VARCHAR(50) NOT NULL,
  INDEX `follow_user_id_FK_idx` (`user_id` ASC) VISIBLE,
  INDEX `follow_follow_id_FK_idx` (`follow_id` ASC) VISIBLE,
  PRIMARY KEY (`follow_id`, `user_id`),
  CONSTRAINT `follow_follow_id_FK`
    FOREIGN KEY (`follow_id`)
    REFERENCES `ssafit`.`user` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `follow_user_id_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `ssafit`.`user` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ssafit`.`part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`part` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`part` (
  `id` VARCHAR(20) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ssafit`.`video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`video` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`video` (
  `id` VARCHAR(30) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `part_id` VARCHAR(20) NULL DEFAULT NULL,
  `channel_name` VARCHAR(50) NOT NULL,
  `url` VARCHAR(200) NOT NULL,
  `view_cnt` INT(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `video_part_id_FK_idx` (`part_id` ASC) VISIBLE,
  CONSTRAINT `video_part_id_FK`
    FOREIGN KEY (`part_id`)
    REFERENCES `ssafit`.`part` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ssafit`.`like_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`like_video` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`like_video` (
  `video_id` VARCHAR(30) NOT NULL,
  `user_id` VARCHAR(50) NOT NULL,
  INDEX `like_video_user_id_FK_idx` (`user_id` ASC) VISIBLE,
  INDEX `like_video_video_id_FK_idx` (`video_id` ASC) VISIBLE,
  PRIMARY KEY (`video_id`, `user_id`),
  CONSTRAINT `like_video_user_id_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `ssafit`.`user` (`id`),
  CONSTRAINT `like_video_video_id_FK`
    FOREIGN KEY (`video_id`)
    REFERENCES `ssafit`.`video` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ssafit`.`review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`review` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`review` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(2000) NOT NULL,
  `user_id` VARCHAR(50) NOT NULL,
  `reg_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `video_id` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`no`),
  INDEX `review_video_id_FK_idx` (`video_id` ASC) VISIBLE,
  INDEX `review_user_id_FK_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `review_user_id_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `ssafit`.`user` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `review_video_id_FK`
    FOREIGN KEY (`video_id`)
    REFERENCES `ssafit`.`video` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- part 기본 데이터 입력
insert into part (id, `name`)
values('0001', '전신'),
	  ('0002', '상체'),
	  ('0003', '하체'),
	  ('0004', '복부');
      
-- video 기본 데이터 입력
insert into `video` (id, title, part_id, channel_name, url, view_cnt)
values('gMaB-fG4u4g', '전신 다이어트 최고의 운동 [칼소폭 찐 핵핵매운맛]', '0001', 'ThankyouBUBU', 
				'https://www.youtube.com/embed/gMaB-fG4u4g', 0),
	  ('swRNeYw1JkY', '하루 15분! 전신 칼로리 불태우는 다이어트 운동', '0001', 'ThankyouBUBU',
				'https://www.youtube.com/embed/swRNeYw1JkY', 0),
	  ('54tTYO-vU2E', '상체 다이어트 최고의 운동 BEST [팔뚝살/겨드랑이살/등살/가슴어깨라인]', '0002', 'ThankyouBUBU',
				'https://www.youtube.com/embed/54tTYO-vU2E', 0),
	  ('QqqZH3j_vH0', '상체비만 다이어트 최고의 운동 [상체 핵매운맛]', '0002', 'ThankyouBUBU',
				'https://www.youtube.com/embed/QqqZH3j_vH0', 0),                
      ('tzN6ypk6Sps', '하체운동이 중요한 이유? 이것만 보고 따라하자 ! [하체운동 교과서]', '0003', '김강민',
				'https://www.youtube.com/embed/tzN6ypk6Sps', 2),
	  ('u5OgcZdNbMo', '저는 하체 식주의자 입니다', '0003', 'GYM종국', 
				'https://www.youtube.com/embed/u5OgcZdNbMo', 0),
	  ('PjGcOP-TQPE', '11자복근 복부 최고의 운동 [복근 핵매운맛]', '0004', 'ThankyouBUBU',
				'https://www.youtube.com/embed/PjGcOP-TQPE', 3),
	  ('7TLk7pscICk', '(Sub)누워서하는 5분 복부운동!! 효과보장! (매일 2주만 해보세요!)', '0004', 'SomiFit',
				'https://www.youtube.com/embed/7TLk7pscICk', 5);

-- user 기본 데이터 입력                
insert into user(id, password, email)
values('익명', '1234', 'ssafy@ssafy.com'),
	  ('ssafy', 'ssafy', 'ssafy@ssafy.com');

