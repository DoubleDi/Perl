-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'teacher'
-- 
-- ---

DROP TABLE IF EXISTS `teacher`;
		
CREATE TABLE `teacher` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(256) NOT NULL,
  `last_name` VARCHAR(256) NOT NULL,
  `floor` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'student'
-- 
-- ---

DROP TABLE IF EXISTS `student`;
		
CREATE TABLE `student` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(256) NOT NULL,
  `faculty` VARCHAR(512) NULL DEFAULT NULL,
  `class` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'homework'
-- 
-- ---

DROP TABLE IF EXISTS `homework`;
		
CREATE TABLE `homework` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(256) NOT NULL,
  `path` VARCHAR(512) NULL DEFAULT NULL,
  `max_points` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'grade'
-- 
-- ---

DROP TABLE IF EXISTS `grade`;
		
CREATE TABLE `grade` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `homework_id` INTEGER NOT NULL,
  `student_id` INTEGER NOT NULL,
  `teacher_id` INTEGER NOT NULL,
  `points` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `grade` ADD FOREIGN KEY (homework_id) REFERENCES `homework` (`id`);
ALTER TABLE `grade` ADD FOREIGN KEY (student_id) REFERENCES `student` (`id`);
ALTER TABLE `grade` ADD FOREIGN KEY (teacher_id) REFERENCES `teacher` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `teacher` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `student` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `homework` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `grade` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `teacher` (`id`,`first_name`,`last_name`,`floor`) VALUES
-- ('','','','');
-- INSERT INTO `student` (`id`,`name`,`faculty`,`class`) VALUES
-- ('','','','');
-- INSERT INTO `homework` (`id`,`name`,`path`,`max_points`) VALUES
-- ('','','','');
-- INSERT INTO `grade` (`id`,`homework_id`,`student_id`,`teacher_id`,`points`) VALUES
-- ('','','','','');
