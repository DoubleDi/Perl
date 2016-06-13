-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'user'
-- 
-- ---

DROP TABLE IF EXISTS `user`;
		
CREATE TABLE `user` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `avatar` VARCHAR(200) NULL DEFAULT NULL,
  `password` VARCHAR(50) NULL DEFAULT NULL,
  `nickname` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---


-- ---
-- Table Properties
-- ---

-- ALTER TABLE `user` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `user` (`id`,`avatar`,`password`,`nickname`) VALUES
-- ('','','','');
