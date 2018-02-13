CREATE DATABASE  IF NOT EXISTS `tasktrackermysql`;
USE `tasktrackermysql`;


DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id_comment` int(11) NOT NULL,
  `Text` text,
  `task_id_task` int(11) NOT NULL,
  `user_id_user` int(11) NOT NULL,
  PRIMARY KEY (`id_comment`),
  KEY `fk_Comment_Task1_idx` (`task_id_task`),
  KEY `fk_Comment_User1_idx` (`user_id_user`),
  CONSTRAINT `fk_Comment_Task1` FOREIGN KEY (`task_id_task`) REFERENCES `task` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comment_User1` FOREIGN KEY (`user_id_user`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `comment` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id_project` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Manager_id` int(11) NOT NULL,
  PRIMARY KEY (`id_project`),
  KEY `fk_Project_User1_idx` (`Manager_id`),
  CONSTRAINT `fk_Project_User1` FOREIGN KEY (`Manager_id`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

LOCK TABLES `project` WRITE;

INSERT INTO `project` VALUES (1,'Weapon',1),(2,'TaskTracker',1),(3,'task',1),(4,'TASLKKK',1),(5,'project',13),(6,'rest',13);

UNLOCK TABLES;

DROP TABLE IF EXISTS `project_has_user`;

CREATE TABLE `project_has_user` (
  `project_id` int(11) NOT NULL,
  `developer_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`,`developer_id`),
  KEY `fk_Project_has_User_User1_idx` (`developer_id`),
  KEY `fk_Project_has_User_Project1_idx` (`project_id`),
  CONSTRAINT `fk_Project_has_User_Project1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id_project`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Project_has_User_User1` FOREIGN KEY (`developer_id`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `project_has_user` WRITE;

UNLOCK TABLES;


DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


LOCK TABLES `role` WRITE;

INSERT INTO `role` VALUES (1,'ROLE_MANAGER'),(2,'ROLE_DEVELOPER');

UNLOCK TABLES;


DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `id_task` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Status` enum('W','I','V','R') NOT NULL,
  `project_id_project` int(11) NOT NULL,
  `user_id_user` int(11) NOT NULL,
  PRIMARY KEY (`id_task`),
  KEY `fk_Task_Project_idx` (`project_id_project`),
  KEY `fk_Task_User1_idx` (`user_id_user`),
  CONSTRAINT `fk_Task_Project` FOREIGN KEY (`project_id_project`) REFERENCES `project` (`id_project`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_User1` FOREIGN KEY (`user_id_user`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


LOCK TABLES `task` WRITE;

INSERT INTO `task` VALUES (1,'task1','add initial files','R',5,13),(2,'task2','commit changes','I',5,13);

UNLOCK TABLES;


DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `Firstname` varchar(255) NOT NULL,
  `Lastname` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `id_role` int(11) NOT NULL,
  PRIMARY KEY (`id_user`),
  KEY `fk_User_Role1_idx` (`id_role`),
  CONSTRAINT `fk_User_Role1` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;


LOCK TABLES `user` WRITE;

INSERT INTO `user` VALUES (1,'FN','LN','ciborg003','$2a$10$gtn0sNFIhJvIkWHeiDx34O6gKHJhb8SrtbBo4p2wtDAb3oQj17wzu',1),(2,'FN','LN','ciborg','$2a$10$gtn0sNFIhJvIkWHeiDx34O6gKHJhb8SrtbBo4p2wtDAb3oQj17wzu',1),(11,'f','f','l','$2a$10$yH/0Il8W8DCY1tcs5P4S1.pCy1xlhZ5kIrs9.X2ywhTRNIxinMtb.',1),(12,'ff','ff','ll','$2a$10$wEmWbiEu5FhS1K9K2UE99OPTwO9bBiBNvK9hD7o8.IUSFWKkN5C/O',2),(13,'rasta','rasta','rasta','$2a$10$1KEiMpGI7gE8Hj3kXBdMwu2br9nHNIZmVZVueDvJ3iJp7ksMXKYn6',1);

UNLOCK TABLES;