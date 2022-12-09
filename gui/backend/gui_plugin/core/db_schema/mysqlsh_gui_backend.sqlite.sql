/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License, version 2.0,
 * as published by the Free Software Foundation.
 *
 * This program is also distributed with certain software (including
 * but not limited to OpenSSL) that is licensed under separate terms, as
 * designated in a particular file or component or in included license
 * documentation.  The authors of MySQL hereby grant you an additional
 * permission to link the program and your derivative works with the
 * separately licensed software that they have included with MySQL.
 * This program is distributed in the hope that it will be useful,  but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
 * the GNU General Public License, version 2.0, for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
 */

-- MySQL Script generated by MySQL Workbench
-- Fri Oct  8 13:20:37 2021
-- Model: MSG Model    Version: 1.0
-- MySQL Workbench Forward Engineering


PRAGMA foreign_keys = OFF;


-- -----------------------------------------------------
-- Schema gui_backend
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `db_connection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_connection` ;

CREATE TABLE IF NOT EXISTS `db_connection` (
  `id` INTEGER NOT NULL,
  `db_type` VARCHAR(45) NOT NULL,
  `caption` VARCHAR(256) NULL,
  `description` VARCHAR(200) NULL,
  `options` TEXT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `db_connection_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_connection_group` ;

CREATE TABLE IF NOT EXISTS `db_connection_group` (
  `id` INTEGER NOT NULL,
  `caption` VARCHAR(80) NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `db_connection_has_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_connection_has_tag` ;

CREATE TABLE IF NOT EXISTS `db_connection_has_tag` (
  `profile_id` INTEGER NOT NULL,
  `db_connection_id` INTEGER NOT NULL,
  `tag_id` INTEGER NOT NULL,
  PRIMARY KEY (`profile_id`, `db_connection_id`, `tag_id`),
  CONSTRAINT `fk_db_connection_has_tag_db_connection1`
    FOREIGN KEY (`profile_id` , `db_connection_id`)
    REFERENCES `profile_has_db_connection` (`profile_id` , `db_connection_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_db_connection_has_tag_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_db_connection_has_tag_tag1_idx` ON `db_connection_has_tag` (`tag_id` ASC);

CREATE INDEX `fk_db_connection_has_tag_db_connection_idx` ON `db_connection_has_tag` (`profile_id` ASC, `db_connection_id` ASC);





-- -----------------------------------------------------
-- Table `data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data` ;

CREATE TABLE IF NOT EXISTS `data` (
  `id` INTEGER NOT NULL,
  `data_category_id` INTEGER NOT NULL,
  `caption` VARCHAR(256) NULL,
  `content` TEXT NULL,
  `created` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_data_data_category1`
    FOREIGN KEY (`data_category_id`)
    REFERENCES `data_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `module_data_caption_idx` ON `data` (`caption` ASC);
CREATE INDEX `fk_data_data_category1_idx` ON `data` (`data_category_id` ASC);


-- -----------------------------------------------------
-- Table `data_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_category` ;

CREATE TABLE IF NOT EXISTS `data_category` (
  `id` INTEGER NOT NULL,
  `parent_category_id` INTEGER NULL,
  `name` VARCHAR(80) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_module_data_category_module_data_category1`
    FOREIGN KEY (`parent_category_id`)
    REFERENCES `data_category` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);

CREATE INDEX `fk_module_data_category_module_data_category1_idx` ON `data_category` (`parent_category_id` ASC);





-- -----------------------------------------------------
-- Table `data_folder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_folder` ;

CREATE TABLE IF NOT EXISTS `data_folder` (
  `id` INTEGER NOT NULL,
  `caption` VARCHAR(80) NULL,
  `parent_folder_id` INTEGER NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_module_data_folder_module_data_folder1`
    FOREIGN KEY (`parent_folder_id`)
    REFERENCES `data_folder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_module_data_folder_module_data_folder1_idx` ON `data_folder` (`parent_folder_id` ASC);





-- -----------------------------------------------------
-- Table `data_folder_has_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_folder_has_data` ;

CREATE TABLE IF NOT EXISTS `data_folder_has_data` (
  `data_id` INTEGER NOT NULL,
  `data_folder_id` INTEGER NOT NULL,
  `read_only` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`data_id`, `data_folder_id`),
  CONSTRAINT `fk_data_has_data_folder_data1`
    FOREIGN KEY (`data_id`)
    REFERENCES `data` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_has_data_folder_data_folder1`
    FOREIGN KEY (`data_folder_id`)
    REFERENCES `data_folder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_data_has_data_folder_data_folder1_idx` ON `data_folder_has_data` (`data_folder_id` ASC);

CREATE INDEX `fk_data_has_data_folder_data1_idx` ON `data_folder_has_data` (`data_id` ASC);





-- -----------------------------------------------------
-- Table `data_has_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_has_tag` ;

CREATE TABLE IF NOT EXISTS `data_has_tag` (
  `profile_id` INTEGER NOT NULL,
  `data_id` INTEGER NOT NULL,
  `tag_id` INTEGER NOT NULL,
  PRIMARY KEY (`profile_id`, `data_id`, `tag_id`),
  CONSTRAINT `fk_data_has_tag_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_data_has_tag_tag1_idx` ON `data_has_tag` (`tag_id` ASC);





-- -----------------------------------------------------
-- Table `privilege`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `privilege` ;

CREATE TABLE IF NOT EXISTS `privilege` (
  `id` INTEGER NOT NULL,
  `privilege_type_id` INTEGER NOT NULL,
  `name` VARCHAR(100) NULL,
  `access_pattern` VARCHAR(250) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_privilege_privilege_type1`
    FOREIGN KEY (`privilege_type_id`)
    REFERENCES `privilege_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_privilege_privilege_type1_idx` ON `privilege` (`privilege_type_id` ASC);





-- -----------------------------------------------------
-- Table `privilege_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `privilege_type` ;

CREATE TABLE IF NOT EXISTS `privilege_type` (
  `id` INTEGER NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile` ;

CREATE TABLE IF NOT EXISTS `profile` (
  `id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  `name` VARCHAR(80) NULL,
  `description` VARCHAR(200) NULL,
  `options` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_profile_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_profile_user1_idx` ON `profile` (`user_id` ASC);





-- -----------------------------------------------------
-- Table `profile_has_db_connection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile_has_db_connection` ;

CREATE TABLE IF NOT EXISTS `profile_has_db_connection` (
  `profile_id` INTEGER NOT NULL,
  `db_connection_id` INTEGER NOT NULL,
  `folder_path` VARCHAR(1024) NULL,
  `index` INTEGER NULL,
  PRIMARY KEY (`profile_id`, `db_connection_id`),
  CONSTRAINT `fk_profile_has_db_connection_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_has_db_connection_db_connection1`
    FOREIGN KEY (`db_connection_id`)
    REFERENCES `db_connection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_profile_has_db_connection_db_connection1_idx` ON `profile_has_db_connection` (`db_connection_id` ASC);

CREATE INDEX `fk_profile_has_db_connection_user_profile1_idx` ON `profile_has_db_connection` (`profile_id` ASC);





-- -----------------------------------------------------
-- Table `data_profile_tree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_profile_tree` ;

CREATE TABLE IF NOT EXISTS `data_profile_tree` (
  `profile_id` INTEGER NOT NULL,
  `root_folder_id` INTEGER NOT NULL,
  `tree_identifier` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`profile_id`, `root_folder_id`),
  CONSTRAINT `fk_profile_has_module_data_folder_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_has_module_data_folder_module_data_folder1`
    FOREIGN KEY (`root_folder_id`)
    REFERENCES `data_folder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_profile_has_module_data_folder_profile1_idx` ON `data_profile_tree` (`profile_id` ASC);

CREATE INDEX `fk_profile_has_module_data_folder_module_data_folder1_idx` ON `data_profile_tree` (`root_folder_id` ASC);




-- -----------------------------------------------------
-- Table `role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `role` ;

CREATE TABLE IF NOT EXISTS `role` (
  `id` INTEGER NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `role_has_privilege`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `role_has_privilege` ;

CREATE TABLE IF NOT EXISTS `role_has_privilege` (
  `role_id` INTEGER NOT NULL,
  `privilege_id` INTEGER NOT NULL,
  PRIMARY KEY (`role_id`, `privilege_id`),
  CONSTRAINT `fk_role_has_privilege_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_has_privilege_privilege1`
    FOREIGN KEY (`privilege_id`)
    REFERENCES `privilege` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_role_has_privilege_privilege1_idx` ON `role_has_privilege` (`privilege_id` ASC);

CREATE INDEX `fk_role_has_privilege_role_idx` ON `role_has_privilege` (`role_id` ASC);





-- -----------------------------------------------------
-- Table `session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `session` ;

CREATE TABLE IF NOT EXISTS `session` (
  `id` INTEGER NOT NULL,
  `continued_session_id` INTEGER NULL,
  `user_id` INTEGER NULL,
  `uuid` BLOB(16) NULL,
  `started` DATETIME NULL,
  `ended` DATETIME NULL,
  `source_ip` VARCHAR(256) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_session_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_session1`
    FOREIGN KEY (`continued_session_id`)
    REFERENCES `session` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_session_users1_idx` ON `session` (`user_id` ASC);

CREATE INDEX `fk_session_session1_idx` ON `session` (`continued_session_id` ASC);





-- -----------------------------------------------------
-- Table `tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tag` ;

CREATE TABLE IF NOT EXISTS `tag` (
  `id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  `caption` VARCHAR(80) NULL,
  `color` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tag_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_tag_user1_idx` ON `tag` (`user_id` ASC);





-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INTEGER NOT NULL,
  `default_profile_id` INTEGER NULL,
  `name` VARCHAR(45) NULL,
  `password_hash` VARCHAR(256) NULL,
  `allowed_hosts` VARCHAR(512) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_profile1`
    FOREIGN KEY (`default_profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_user_profile1_idx` ON `user` (`default_profile_id` ASC);

CREATE UNIQUE INDEX `name_UNIQUE` ON `user` (`name` ASC);





-- -----------------------------------------------------
-- Table `user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_group` ;

CREATE TABLE IF NOT EXISTS `user_group` (
  `id` INTEGER NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `data_user_group_tree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_user_group_tree` ;

CREATE TABLE IF NOT EXISTS `data_user_group_tree` (
  `user_group_id` INTEGER NOT NULL,
  `root_folder_id` INTEGER NOT NULL,
  `tree_identifier` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_group_id`, `root_folder_id`),
  CONSTRAINT `fk_user_group_has_module_data_folder_user_group1`
    FOREIGN KEY (`user_group_id`)
    REFERENCES `user_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_has_module_data_folder_module_data_folder1`
    FOREIGN KEY (`root_folder_id`)
    REFERENCES `data_folder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_user_group_has_module_data_folder_user_group1_idx` ON `data_user_group_tree` (`user_group_id` ASC);

CREATE INDEX `fk_user_group_has_module_data_folder_module_data_folder1_idx` ON `data_user_group_tree` (`root_folder_id` ASC);





-- -----------------------------------------------------
-- Table `user_group_has_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_group_has_user` ;

CREATE TABLE IF NOT EXISTS `user_group_has_user` (
  `user_group_id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  `owner` TINYINT NULL,
  PRIMARY KEY (`user_group_id`, `user_id`),
  CONSTRAINT `fk_user_group_has_user_user_group1`
    FOREIGN KEY (`user_group_id`)
    REFERENCES `user_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_user_group_has_user_user1_idx` ON `user_group_has_user` (`user_id` ASC);

CREATE INDEX `fk_user_group_has_user_user_group1_idx` ON `user_group_has_user` (`user_group_id` ASC);





-- -----------------------------------------------------
-- Table `user_has_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_role` ;

CREATE TABLE IF NOT EXISTS `user_has_role` (
  `user_id` INTEGER NOT NULL,
  `role_id` INTEGER NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  CONSTRAINT `fk_users_has_role_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_role_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_users_has_role_role1_idx` ON `user_has_role` (`role_id` ASC);

CREATE INDEX `fk_users_has_role_users1_idx` ON `user_has_role` (`user_id` ASC);





-- -----------------------------------------------------
-- Schema gui_backend_log
-- -----------------------------------------------------
ATTACH DATABASE 'mysqlsh_gui_backend_log.sqlite3' as logs;

-- -----------------------------------------------------
-- Table `log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `logs`.`log` ;

CREATE TABLE IF NOT EXISTS `logs`.`log` (
  `id` INTEGER NOT NULL,
  `session_id` INTEGER NULL,
  `user_id` INTEGER NULL,
  `event_time` DATETIME NULL,
  `event_type` VARCHAR(45) NULL,
  `message` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_log_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_session1`
    FOREIGN KEY (`session_id`)
    REFERENCES `session` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `logs`.`message` ;

CREATE TABLE IF NOT EXISTS `logs`.`message` (
  `id` INTEGER NOT NULL,
  `session_id` INTEGER NOT NULL,
  `request_id` BLOB(16) NULL,
  `is_response` TINYINT NULL,
  `message` TEXT NULL,
  `sent` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_message_session1`
    FOREIGN KEY (`session_id`)
    REFERENCES `session` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- View `schema_version`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `schema_version` ;
CREATE VIEW schema_version (major, minor, patch) AS SELECT 0, 0, 16;

-- -----------------------------------------------------
-- Data for table `data_category`
-- -----------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO `data_category` (`id`, `parent_category_id`, `name`) VALUES (1, NULL, 'Text');
INSERT INTO `data_category` (`id`, `parent_category_id`, `name`) VALUES (2, 1, 'Script');
INSERT INTO `data_category` (`id`, `parent_category_id`, `name`) VALUES (3, 1, 'JSON');
INSERT INTO `data_category` (`id`, `parent_category_id`, `name`) VALUES (4, 2, 'MySQL Script');
INSERT INTO `data_category` (`id`, `parent_category_id`, `name`) VALUES (5, 2, 'Python Script');
INSERT INTO `data_category` (`id`, `parent_category_id`, `name`) VALUES (6, 2, 'JavaScript Script');
INSERT INTO `data_category` (`id`, `parent_category_id`, `name`) VALUES (7, 2, 'TypeScript Script');
INSERT INTO `data_category` (`id`, `parent_category_id`, `name`) VALUES (8, 2, 'SQLite Script');

COMMIT;

-- -----------------------------------------------------
-- Data for table `privilege`
-- -----------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO `privilege` (`id`, `privilege_type_id`, `name`, `access_pattern`) VALUES (1, 1, 'Full access to all python globals', '.*');
INSERT INTO `privilege` (`id`, `privilege_type_id`, `name`, `access_pattern`) VALUES (2, 2, 'Full access to all web gui modules', '.*');
INSERT INTO `privilege` (`id`, `privilege_type_id`, `name`, `access_pattern`) VALUES (3, 1, 'Access to common gui extension objects', 'gui\\.(modules|sqleditor)\\.\\w*');
INSERT INTO `privilege` (`id`, `privilege_type_id`, `name`, `access_pattern`) VALUES (4, 2, 'Access to all web gui modules except shell', '\\b(?!shell\\b)\\w+');
INSERT INTO `privilege` (`id`, `privilege_type_id`, `name`, `access_pattern`) VALUES (5, 1, 'Access to selected gui.users functions', 'gui\\.users\\.(get_gui_module_list|list_profiles|get_profile|add_profile|get_default_profile|set_default_profile|set_web_session_profile)');

COMMIT;


-- -----------------------------------------------------
-- Data for table `privilege_type`
-- -----------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO `privilege_type` (`id`, `name`) VALUES (1, 'Python Environment Access');
INSERT INTO `privilege_type` (`id`, `name`) VALUES (2, 'GUI Module Access');

COMMIT;


-- -----------------------------------------------------
-- Data for table `role`
-- -----------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO `role` (`id`, `name`, `description`) VALUES (1, 'Administrator', 'Administrator with full access');
INSERT INTO `role` (`id`, `name`, `description`) VALUES (2, 'Poweruser', 'Web user with full access');
INSERT INTO `role` (`id`, `name`, `description`) VALUES (3, 'User', 'Web user with full access expect to the shell module');

COMMIT;


-- -----------------------------------------------------
-- Data for table `role_has_privilege`
-- -----------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO `role_has_privilege` (`role_id`, `privilege_id`) VALUES (1, 1);
INSERT INTO `role_has_privilege` (`role_id`, `privilege_id`) VALUES (1, 2);
INSERT INTO `role_has_privilege` (`role_id`, `privilege_id`) VALUES (2, 2);
INSERT INTO `role_has_privilege` (`role_id`, `privilege_id`) VALUES (2, 3);
INSERT INTO `role_has_privilege` (`role_id`, `privilege_id`) VALUES (3, 3);
INSERT INTO `role_has_privilege` (`role_id`, `privilege_id`) VALUES (3, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_group`
-- -----------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO `user_group` (`id`, `name`, `description`) VALUES (1, 'all', 'All Users');

COMMIT;



PRAGMA foreign_keys = ON;

