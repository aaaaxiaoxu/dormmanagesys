ALTER TABLE `churusushe`
  ADD COLUMN `churuleixing` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '通行类型' AFTER `fangjianhao`;

UPDATE `churusushe`
SET `churuleixing` = '入宿'
WHERE `churuleixing` IS NULL OR `churuleixing` = '';
