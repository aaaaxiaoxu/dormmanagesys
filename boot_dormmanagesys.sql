-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: xz0100-2
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aboutus`
--

DROP TABLE IF EXISTS `aboutus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aboutus` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `subtitle` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '副标题',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `picture1` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '图片1',
  `picture2` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '图片2',
  `picture3` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '图片3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='关于我们';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aboutus`
--

LOCK TABLES `aboutus` WRITE;
/*!40000 ALTER TABLE `aboutus` DISABLE KEYS */;
INSERT INTO `aboutus` VALUES (1,'2026-01-08 09:35:53','关于我们','ABOUT US','不管你想要怎样的生活，你都要去努力争取，不多尝试一些事情怎么知道自己适合什么、不适合什么呢?\n你说你喜欢读书，让我给你列书单，你还问我哪里有那么多时间看书;你说自己梦想的职业是广告文案，问我如何成为一个文案，应该具备哪些素质;你说你计划晨跑，但总是因为学习、工作辛苦或者身体不舒服第二天起不了床;你说你一直梦想一个人去长途旅行，但是没钱，父母觉得危险。其实，我已经厌倦了你这样说说而已的把戏，我觉得就算我告诉你如何去做，你也不会照做，因为你根本什么都不做。','upload/aboutus_picture1.jpg','upload/aboutus_picture2.jpg','upload/aboutus_picture3.jpg');
/*!40000 ALTER TABLE `aboutus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `churusushe`
--

DROP TABLE IF EXISTS `churusushe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `churusushe` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sushemingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍名称',
  `susheleixing` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍类型',
  `susheloudong` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍楼栋',
  `fangjianhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '房间号',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生学号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生姓名',
  `churushijian` datetime DEFAULT NULL COMMENT '出入时间',
  `xiangpian` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '相片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1777012825862 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='出入宿舍';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `churusushe`
--

LOCK TABLES `churusushe` WRITE;
/*!40000 ALTER TABLE `churusushe` DISABLE KEYS */;
INSERT INTO `churusushe` VALUES (62,'2026-01-08 09:35:53','宿舍名称2','宿舍类型2','宿舍楼栋2','房间号2','学生学号2','学生姓名2','2026-01-08 17:35:53','upload/churusushe_xiangpian2.jpg,upload/churusushe_xiangpian3.jpg,upload/churusushe_xiangpian4.jpg'),(63,'2026-01-08 09:35:53','宿舍名称3','宿舍类型3','宿舍楼栋3','房间号3','学生学号3','学生姓名3','2026-01-08 17:35:53','upload/churusushe_xiangpian3.jpg,upload/churusushe_xiangpian4.jpg,upload/churusushe_xiangpian5.jpg'),(64,'2026-01-08 09:35:53','宿舍名称4','宿舍类型4','宿舍楼栋4','房间号4','学生学号4','学生姓名4','2026-01-08 17:35:53','upload/churusushe_xiangpian4.jpg,upload/churusushe_xiangpian5.jpg,upload/churusushe_xiangpian6.jpg'),(65,'2026-01-08 09:35:53','宿舍名称5','宿舍类型5','宿舍楼栋5','房间号5','学生学号5','学生姓名5','2026-01-08 17:35:53','upload/churusushe_xiangpian5.jpg,upload/churusushe_xiangpian6.jpg,upload/churusushe_xiangpian7.jpg'),(66,'2026-01-08 09:35:53','宿舍名称6','宿舍类型6','宿舍楼栋6','房间号6','学生学号6','学生姓名6','2026-01-08 17:35:53','upload/churusushe_xiangpian6.jpg,upload/churusushe_xiangpian7.jpg,upload/churusushe_xiangpian8.jpg'),(67,'2026-01-08 09:35:53','宿舍名称7','宿舍类型7','宿舍楼栋7','房间号7','学生学号7','学生姓名7','2026-01-08 17:35:53','upload/churusushe_xiangpian7.jpg,upload/churusushe_xiangpian8.jpg,upload/churusushe_xiangpian9.jpg'),(68,'2026-01-08 09:35:53','宿舍名称8','宿舍类型8','宿舍楼栋8','房间号8','学生学号8','学生姓名8','2026-01-08 17:35:53','upload/churusushe_xiangpian8.jpg,upload/churusushe_xiangpian9.jpg,upload/churusushe_xiangpian10.jpg'),(1777011598034,'2026-04-24 06:19:57','博学苑1-201','男生','1号楼','201','1','林泽宇','2026-04-24 14:19:48','upload/1777011595416.jpg'),(1777012744816,'2026-04-24 06:39:04','博学苑1-201','男生','1号楼','201','1','林泽宇','2026-04-24 14:38:50','upload/1777012740991.jpg'),(1777012825861,'2026-04-24 06:40:24','博学苑2-306','女生','2号楼','306','20241009','苏念安','2026-04-24 14:40:12','upload/1777012822766.jpg');
/*!40000 ALTER TABLE `churusushe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='配置文件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'picture1','upload/picture1.jpg'),(2,'picture2','upload/picture2.jpg'),(3,'picture3','upload/picture3.jpg'),(7,'APIKey','ihML0NfEM0jokUAuBD9tbYtW'),(8,'SecretKey','WK2bRUFf2uNe3oEoQXULpi8Y37aCvFdD');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum`
--

DROP TABLE IF EXISTS `forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '帖子标题',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '帖子内容',
  `parentid` bigint DEFAULT NULL COMMENT '父节点id',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户名',
  `avatarurl` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '头像',
  `isdone` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1777012663895 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='交流论坛';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum`
--

LOCK TABLES `forum` WRITE;
/*!40000 ALTER TABLE `forum` DISABLE KEYS */;
INSERT INTO `forum` VALUES (101,'2026-01-08 01:35:53','宿舍一楼洗衣机排队太久怎么办','<p>最近晚高峰洗衣机经常要排半小时，大家有没有更好的错峰建议？</p>',0,11,'学生1','学生','开放'),(102,'2026-01-09 02:20:11','求推荐安静一点的自习地点','<p>宿舍晚上有点吵，想找校内适合晚自习的地方，欢迎推荐。</p>',0,12,'学生2','学生','开放'),(103,'2026-01-10 10:05:21','3号楼热水供应恢复通知','<p>今天晚上 8 点开始恢复热水供应，大家可以正常使用了。</p>',0,1737478901989,'宿管1','宿管','关闭'),(104,'2026-01-11 01:16:48','有人愿意一起晨跑吗','<p>准备这学期坚持晨跑，想找几个同学一起打卡互相监督。</p>',0,13,'学生3','学生','开放'),(105,'2026-01-12 12:11:32','宿舍门禁识别速度有点慢','<p>晚上高峰进出宿舍时识别稍慢，大家这两天有同样感觉吗？</p>',0,14,'学生4','学生','开放'),(106,'2026-01-13 06:28:07','失物招领：图书馆借书证','<p>在一号楼大厅捡到借书证一张，看到的同学可以来认领。</p>',0,1,'admin','管理员','关闭'),(201,'2026-01-08 02:02:13','宿舍一楼洗衣机排队太久怎么办','可以试试中午或者上午去，人会少很多。',101,12,'学生2','学生',NULL),(202,'2026-01-08 02:30:43','宿舍一楼洗衣机排队太久怎么办','我们已经在统计晚高峰使用情况，后面会考虑调整开放时间。',101,1737478901989,'宿管1','宿管',NULL),(203,'2026-01-08 03:06:19','宿舍一楼洗衣机排队太久怎么办','回复楼上，我昨天中午去确实基本不用等。',201,11,'学生1','学生',NULL),(204,'2026-01-09 03:15:22','求推荐安静一点的自习地点','图书馆四楼东侧自习区比较安静，插座也多。',102,13,'学生3','学生',NULL),(205,'2026-01-09 03:48:35','求推荐安静一点的自习地点','教学楼 B 区晚上 9 点前也可以去，空教室不少。',102,14,'学生4','学生',NULL),(206,'2026-01-10 10:20:03','3号楼热水供应恢复通知','收到，辛苦老师通知。',103,11,'学生1','学生',NULL),(207,'2026-01-11 02:07:18','有人愿意一起晨跑吗','我可以，早上 6:40 在宿舍楼下集合怎么样？',104,12,'学生2','学生',NULL),(208,'2026-01-12 12:36:55','宿舍门禁识别速度有点慢','我们已经联系维护人员排查，明天会做一次设备检查。',105,1,'admin','管理员',NULL),(209,'2026-01-12 13:01:47','宿舍门禁识别速度有点慢','今天 8 点左右确实排得比较长。',105,13,'学生3','学生',NULL),(210,'2026-01-13 07:05:29','失物招领：图书馆借书证','已经联系到失主了，谢谢管理员。',106,14,'学生4','学生',NULL),(1777012637797,'2026-04-24 06:37:17','宿舍门禁识别速度有点慢','12312312',105,1737478901989,'1','宿管',NULL),(1777012640743,'2026-04-24 06:37:20','宿舍门禁识别速度有点慢','12321312',209,1737478901989,'1','宿管',NULL),(1777012645447,'2026-04-24 06:37:24','宿舍门禁识别速度有点慢','123213',1777012640743,1737478901989,'1','宿管',NULL),(1777012663894,'2026-04-24 06:37:43','宿舍门禁识别速度有点慢','44444',1777012645447,11,'1','学生',NULL);
/*!40000 ALTER TABLE `forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jinrusushe`
--

DROP TABLE IF EXISTS `jinrusushe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jinrusushe` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sushemingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍名称',
  `susheleixing` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍类型',
  `susheloudong` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍楼栋',
  `fangjianhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '房间号',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生学号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生姓名',
  `jinrushijian` datetime DEFAULT NULL COMMENT '进入时间',
  `zhaopian` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '照片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1739333234929 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='进入宿舍';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jinrusushe`
--

LOCK TABLES `jinrusushe` WRITE;
/*!40000 ALTER TABLE `jinrusushe` DISABLE KEYS */;
INSERT INTO `jinrusushe` VALUES (51,'2026-01-08 09:35:53','宿舍名称1','宿舍类型1','宿舍楼栋1','房间号1','1','访客姓名1','2026-01-08 17:35:53','upload/jinrusushe_zhaopian1.jpg,upload/jinrusushe_zhaopian2.jpg,upload/jinrusushe_zhaopian3.jpg'),(52,'2026-01-08 09:35:53','宿舍名称2','宿舍类型2','宿舍楼栋2','房间号2','访客手机号2','访客姓名2','2026-01-08 17:35:53','upload/jinrusushe_zhaopian2.jpg,upload/jinrusushe_zhaopian3.jpg,upload/jinrusushe_zhaopian4.jpg'),(53,'2026-01-08 09:35:53','宿舍名称3','宿舍类型3','宿舍楼栋3','房间号3','访客手机号3','访客姓名3','2026-01-08 17:35:53','upload/jinrusushe_zhaopian3.jpg,upload/jinrusushe_zhaopian4.jpg,upload/jinrusushe_zhaopian5.jpg'),(54,'2026-01-08 09:35:53','宿舍名称4','宿舍类型4','宿舍楼栋4','房间号4','访客手机号4','访客姓名4','2026-01-08 17:35:53','upload/jinrusushe_zhaopian4.jpg,upload/jinrusushe_zhaopian5.jpg,upload/jinrusushe_zhaopian6.jpg'),(55,'2026-01-08 09:35:53','宿舍名称5','宿舍类型5','宿舍楼栋5','房间号5','访客手机号5','访客姓名5','2026-01-08 17:35:53','upload/jinrusushe_zhaopian5.jpg,upload/jinrusushe_zhaopian6.jpg,upload/jinrusushe_zhaopian7.jpg'),(56,'2026-01-08 09:35:53','宿舍名称6','宿舍类型6','宿舍楼栋6','房间号6','访客手机号6','访客姓名6','2026-01-08 17:35:53','upload/jinrusushe_zhaopian6.jpg,upload/jinrusushe_zhaopian7.jpg,upload/jinrusushe_zhaopian8.jpg'),(57,'2026-01-08 09:35:53','宿舍名称7','宿舍类型7','宿舍楼栋7','房间号7','访客手机号7','访客姓名7','2026-01-08 17:35:53','upload/jinrusushe_zhaopian7.jpg,upload/jinrusushe_zhaopian8.jpg,upload/jinrusushe_zhaopian9.jpg'),(58,'2026-01-08 09:35:53','宿舍名称8','宿舍类型8','宿舍楼栋8','房间号8','访客手机号8','访客姓名8','2026-01-08 17:35:53','upload/jinrusushe_zhaopian8.jpg,upload/jinrusushe_zhaopian9.jpg,upload/jinrusushe_zhaopian10.jpg'),(1739333003232,'2026-01-12 04:03:22','1','1','1','1','1','1','2026-01-12 12:03:18',''),(1739333234928,'2026-01-12 04:07:14','1','1','1','1','1','1','2026-01-12 12:07:03','upload/1739333232099.jpg');
/*!40000 ALTER TABLE `jinrusushe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaoqinxinxi`
--

DROP TABLE IF EXISTS `kaoqinxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kaoqinxinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sushemingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍名称',
  `susheleixing` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍类型',
  `susheloudong` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍楼栋',
  `fangjianhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '房间号',
  `yuefen` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '月份',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生学号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生姓名',
  `wanguitianshu` int DEFAULT NULL COMMENT '晚归天数',
  `queqintianshu` int DEFAULT NULL COMMENT '缺寝天数',
  `qingjiatianshu` int DEFAULT NULL COMMENT '请假天数',
  `dengjishijian` date DEFAULT NULL COMMENT '登记时间',
  `beizhu` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='考勤信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaoqinxinxi`
--

LOCK TABLES `kaoqinxinxi` WRITE;
/*!40000 ALTER TABLE `kaoqinxinxi` DISABLE KEYS */;
INSERT INTO `kaoqinxinxi` VALUES (91,'2026-01-02 09:35:53','宿舍名称1','宿舍类型1','宿舍楼栋1','房间号1','月份1','学生学号1','学生姓名1',1,1,1,'2026-01-02','备注1'),(92,'2026-01-02 09:35:53','宿舍名称2','宿舍类型2','宿舍楼栋2','房间号2','月份2','学生学号2','学生姓名2',2,2,2,'2026-01-02','备注2'),(93,'2026-01-02 09:35:53','宿舍名称3','宿舍类型3','宿舍楼栋3','房间号3','月份3','学生学号3','学生姓名3',3,3,3,'2026-01-02','备注3'),(94,'2026-01-02 09:35:53','宿舍名称4','宿舍类型4','宿舍楼栋4','房间号4','月份4','学生学号4','学生姓名4',4,4,4,'2026-01-02','备注4'),(95,'2026-01-02 09:35:53','宿舍名称5','宿舍类型5','宿舍楼栋5','房间号5','月份5','学生学号5','学生姓名5',5,5,5,'2026-01-02','备注5'),(96,'2026-01-02 09:35:53','宿舍名称6','宿舍类型6','宿舍楼栋6','房间号6','月份6','学生学号6','学生姓名6',6,6,6,'2026-01-02','备注6'),(97,'2026-01-02 09:35:53','宿舍名称7','宿舍类型7','宿舍楼栋7','房间号7','月份7','学生学号7','学生姓名7',7,7,7,'2026-01-02','备注7'),(98,'2026-01-02 09:35:53','宿舍名称8','宿舍类型8','宿舍楼栋8','房间号8','月份8','学生学号8','学生姓名8',8,8,8,'2026-01-02','备注8');
/*!40000 ALTER TABLE `kaoqinxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '留言人id',
  `username` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户名',
  `avatarurl` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '头像',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '留言内容',
  `cpicture` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '留言图片',
  `reply` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '回复内容',
  `rpicture` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '回复图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1777012084339 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='留言板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (141,'2026-01-02 09:35:53',1,'用户名1','upload/messages_avatarurl1.jpg','留言内容1','upload/messages_cpicture1.jpg','回复内容1','upload/messages_rpicture1.jpg'),(142,'2026-01-02 09:35:53',2,'用户名2','upload/messages_avatarurl2.jpg','留言内容2','upload/messages_cpicture2.jpg','回复内容2','upload/messages_rpicture2.jpg'),(143,'2026-01-02 09:35:53',3,'用户名3','upload/messages_avatarurl3.jpg','留言内容3','upload/messages_cpicture3.jpg','回复内容3','upload/messages_rpicture3.jpg'),(144,'2026-01-02 09:35:53',4,'用户名4','upload/messages_avatarurl4.jpg','留言内容4','upload/messages_cpicture4.jpg','回复内容4','upload/messages_rpicture4.jpg'),(145,'2026-01-02 09:35:53',5,'用户名5','upload/messages_avatarurl5.jpg','留言内容5','upload/messages_cpicture5.jpg','回复内容5','upload/messages_rpicture5.jpg'),(146,'2026-01-02 09:35:53',6,'用户名6','upload/messages_avatarurl6.jpg','留言内容6','upload/messages_cpicture6.jpg','回复内容6','upload/messages_rpicture6.jpg'),(147,'2026-01-02 09:35:53',7,'用户名7','upload/messages_avatarurl7.jpg','留言内容7','upload/messages_cpicture7.jpg','回复内容7','upload/messages_rpicture7.jpg'),(148,'2026-01-02 09:35:53',8,'用户名8','upload/messages_avatarurl8.jpg','留言内容8','upload/messages_cpicture8.jpg','回复内容8','upload/messages_rpicture8.jpg'),(1776153193209,'2026-04-14 07:53:13',11,'1',NULL,'系统功能出问题了怎么办',NULL,'别着急呀。您可以先退出系统重新登录试试看，检查下网络连接是否正常。要是问题还没解决，您可以在系统的报修模块提交问题，也可以联系宿管来协助处理哈。',NULL),(1776161713105,'2026-04-14 10:15:13',11,'1',NULL,'请假申请要怎么提交',NULL,'您好，您可以在宿舍管理系统里找到“请假申请”模块。进入后，按系统提示填写请假原因、请假时间等信息，确认无误后提交就行。要是在操作中遇到问题，也能联系宿管寻求帮助。',NULL),(1776161725029,'2026-04-14 10:15:25',11,'1',NULL,'宿舍晚上太吵了怎么处理',NULL,'同学你好呀，你可以先和室友友好沟通，提醒他们注意保持安静。如果沟通后还是很吵，你可以跟宿管反映这个情况，让宿管帮忙协调处理。也可以在宿舍管理系统的论坛模块反馈，寻求大家的帮助和建议哦。',NULL),(1776999489743,'2026-04-24 02:58:09',1,'admin',NULL,'你好',NULL,'您好呀！有什么宿舍相关的问题，比如宿舍噪音、宿舍矛盾、报修、卫生、水电费、出入登记、请假、考勤、系统使用方面的问题，都可以跟我说哦。',NULL),(1777000583240,'2026-04-24 03:16:23',1,'admin',NULL,'你好',NULL,'您好呀！有什么宿舍相关的问题，比如宿舍噪音、宿舍矛盾、报修、卫生、水电费、出入登记、请假、考勤、系统使用问题等，都可以跟我说哦。',NULL),(1777000864435,'2026-04-24 03:21:04',11,'1',NULL,'你好',NULL,'你好呀！有什么宿舍相关的问题都可以跟我说，像宿舍噪音、宿舍矛盾、报修、卫生、水电费、出入登记、请假、考勤、系统使用问题这些我都能帮你解答呢。',NULL),(1777001321538,'2026-04-24 03:28:41',11,'1',NULL,'你好',NULL,'你好呀！有任何宿舍管理相关的问题，像宿舍分配、报修、卫生、水电费等，都可以跟我说哦。',NULL),(1777001340840,'2026-04-24 03:29:01',11,'1',NULL,'我的身份是什么',NULL,'您的身份是学生哦，您可以登录系统，在个人信息页面查看更详细的身份信息，一般在系统的个人中心位置就能找到该页面。',NULL),(1777012084338,'2026-04-24 06:28:04',1,'admin',NULL,'我是谁',NULL,'您好，您是管理员，用户名是“admin”。在宿舍管理系统中，您可以进行系统配置、数据管理、宿舍资源统筹、角色权限和全局业务处理等操作。若您在后续操作中有任何问题，随时都能问我。',NULL);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `introduction` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '简介',
  `picture` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1739333256325 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='宿舍公告';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (111,'2026-01-02 09:35:53','有梦想，就要努力去实现','不管你想要怎样的生活，你都要去努力争取，不多尝试一些事情怎么知道自己适合什么、不适合什么呢?你说你喜欢读书，让我给你列书单，你还问我哪里有那么多时间看书;你说自己梦想的职业是广告文案，问我如何成为一个文案，应该具备哪些素质;你说你计划晨跑，但总是因为学习、工作辛苦或者身体不舒服第二天起不了床;你说你一直梦想一个人去长途旅行，但是没钱，父母觉得危险。','upload/news_picture1.jpg','<p>不管你想要怎样的生活，你都要去努力争取，不多尝试一些事情怎么知道自己适合什么、不适合什么呢?</p><p>你说你喜欢读书，让我给你列书单，你还问我哪里有那么多时间看书;你说自己梦想的职业是广告文案，问我如何成为一个文案，应该具备哪些素质;你说你计划晨跑，但总是因为学习、工作辛苦或者身体不舒服第二天起不了床;你说你一直梦想一个人去长途旅行，但是没钱，父母觉得危险。其实，我已经厌倦了你这样说说而已的把戏，我觉得就算我告诉你如何去做，你也不会照做，因为你根本什么都不做。</p><p>真正有行动力的人不需要别人告诉他如何做，因为他已经在做了。就算碰到问题，他也会自己想办法，自己动手去解决或者主动寻求可以帮助他的人，而不是等着别人为自己解决问题。</p><p>首先要学习独立思考。花一点时间想一下自己喜欢什么，梦想是什么，不要别人说想环游世界，你就说你的梦想是环游世界。</p><p>很多人说现实束缚了自己，其实在这个世界上，我们一直都可以有很多选择，生活的决定权也—直都在自己手上，只是我们缺乏行动力而已。</p><p>如果你觉得安于现状是你想要的，那选择安于现状就会让你幸福和满足;如果你不甘平庸，选择一条改变、进取和奋斗的道路，在这个追求的过程中，你也一样会感到快乐。所谓的成功，即是按照自己想要的生活方式生活。最糟糕的状态，莫过于当你想要选择一条不甘平庸、改变、进取和奋斗的道路时，却以一种安于现状的方式生活，最后抱怨自己没有得到想要的人生。</p><p>因为喜欢，你不是在苦苦坚持，也因为喜欢，你愿意投入时间、精力，长久以往，获得成功就是自然而然的事情。</p>'),(112,'2026-01-02 09:35:53','又是一年毕业季','又是一年毕业季，感慨万千，还记的自己刚进学校那时候的情景，我拖着沉重的行李箱站在偌大的教学楼前面，感叹自己未来的日子即将在这个陌生的校园里度过，而如今斗转星移，浮光掠影，弹指之间，那些青葱岁月如同白驹过隙般悄然从指缝溜走。过去的种种在胸口交集纠结，像打翻的五味瓶，甜蜜，酸楚，苦涩，一并涌上心头。','upload/news_picture2.jpg','<p>又是一年毕业季，感慨万千，还记的自己刚进学校那时候的情景，我拖着沉重的行李箱站在偌大的教学楼前面，感叹自己未来的日子即将在这个陌生的校园里度过，而如今斗转星移，浮光掠影，弹指之间，那些青葱岁月如同白驹过隙般悄然从指缝溜走。</p><p>过去的种种在胸口交集纠结，像打翻的五味瓶，甜蜜，酸楚，苦涩，一并涌上心头。一直都是晚会的忠实参与者，无论是台前还是幕后，忽然间，角色转变，那种感觉确实难以用语言表达。</p><p>	过去的三年，总是默默地期盼着这个好雨时节，因为这时候，会有灿烂的阳光，会有满目的百花争艳，会有香甜的冰激凌，这是个毕业的季节，当时不经世事的我们会殷切地期待学校那一大堆的活动，期待穿上绚丽的演出服或者礼仪服，站在大礼堂镁光灯下尽情挥洒我们的澎拜的激情。</p><p>百感交集，隔岸观火与身临其境的感觉竟是如此不同。从来没想过一场晚会送走的是我们自己的时候会是怎样的感情，毕业就真的意味着结束吗?倔强的我们不愿意承认，谢谢学弟学妹们慷慨的将这次的主题定为“我们在这里”。我知道，这可能是他们对我们这些过来人的尊敬和施舍。</p><p>没有为这场晚会排练、奔波，没有为班级、学生会、文学院出点力，还真有点不习惯，百般无奈中，用“工作忙”个万能的借口来搪塞自己，欺骗别人。其实自己心里明白，那只是在逃避，只是不愿面对繁华落幕后的萧条和落寞。大四了，大家各奔东西，想凑齐班上的人真的是难上加难，敏燕从越南回来，刚落地就匆匆回了学校，那么恋家的人也启程回来了，睿睿学姐也是从家赶来跟我们团圆。大家—如既往的寒暄、打趣、调侃对方，似乎一切又回到了当初的单纯美好。</p><p>看着舞台上活泼可爱的学弟学妹们，如同一群机灵的小精灵，清澈的眼神，稚嫩的肢体，轻快地步伐，用他们那热情洋溢的舞姿渲染着在场的每一个人，我知道，我不应该羡慕嫉妒他们，不应该顾自怜惜逝去的青春，不应该感叹夕阳无限好，曾经，我们也拥有过，曾经，我们也年轻过，曾经，我们也灿烂过。我深深地告诉自己，人生的每个阶段都是美的，年轻有年轻的活力，成熟也有成熟的魅力。多—份稳重、淡然、优雅，也是漫漫时光掠影遗留下的.珍贵赏赐。</p>'),(113,'2026-01-02 09:35:53','挫折路上，坚持常在心间','回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。','upload/news_picture3.jpg','<p>回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?</p><p>清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。</p><p>是的，面对道途上那无情的嘲讽，面对步伐中那重复的摔跤，面对激流与硬石之间猛烈的碰撞，我们必须选择那富于阴雨，却最终见到彩虹的荆棘路。也许，经历了那暴风雨的洗礼，我们便会变得自信，幸福也随之而来。</p><p>司马迁屡遭羞辱，却依然在狱中撰写《史记》，作为一名史学家，不因王权而极度赞赏，也不因卑微而极度批判，然而他在坚持自己操守的同时，却依然要受统治阶级的阻碍，他似乎无权选择自己的本职。但是，他不顾于此，只是在面对道途的阻隔之时，他依然选择了走下去的信念。终于一部开山巨作《史记》诞生，为后人留下一份馈赠，也许在他完成毕生的杰作之时，他微微地笑了，没有什么比梦想实现更快乐的了......</p><p>	或许正如“长风破浪会有时，直挂云帆济沧海”一般，欣欣然地走向看似深渊的崎岖路，而在一番耕耘之后，便会发现这里另有一番天地。也许这就是困难与快乐的交融。</p><p>也许在形形色色的社会中，我们常能看到一份坚持，一份自信，但这里却还有一类人。这类人在暴风雨来临之际，只会闪躲，从未懂得这也是一种历炼，这何尝不是一份快乐。在阴暗的角落里，总是独自在哭，带着伤愁，看不到一点希望。</p><p>我们不能堕落于此，而要像海燕那般，在苍茫的大海上，高傲地飞翔，任何事物都无法阻挡，任何事都是幸福快乐的。</p>'),(114,'2026-01-02 09:35:53','挫折是另一个生命的开端','当遇到挫折或失败，你是看见失败还是看见机会?挫折是我们每个人成长的必经之路，它不是你想有就有，想没有就没有的。有句名言说的好，如果你想一生摆脱苦难，你就得是神或者是死尸。这句话形象地说明了挫折是伴随着人生的，是谁都逃不掉的。','upload/news_picture4.jpg','<p>当遇到挫折或失败，你是看见失败还是看见机会?</p><p>挫折是我们每个人成长的必经之路，它不是你想有就有，想没有就没有的。有句名言说的好，如果你想一生摆脱苦难，你就得是神或者是死尸。这句话形象地说明了挫折是伴随着人生的，是谁都逃不掉的。</p><p>人生在世，从古到今，不分天子平民，机遇虽有不同，但总不免有身陷困境或遭遇难题之处，这时候唯有通权达变，才能使人转危为安，甚至反败为胜。</p><p>大部分的人，一生当中，最痛苦的经验是失去所爱的人，其次是丢掉一份工作。其实，经得起考验的人，就算是被开除也不会惊慌，要学会面对。</p><p>	“塞翁失马，焉知非福。”人生的道路，并不是每一步都迈向成功，这就是追求的意义。我们还要认识到一点，挫折作为一种情绪状态和一种个人体验，各人的耐受性是大不相同的，有的人经历了一次次挫折，就能够坚忍不拔，百折不挠;有的人稍遇挫折便意志消沉，一蹶不振。所以，挫折感是一种主观感受，因为人的目的和需要不同，成功标准不同，所以同一种活动对于不同的人可能会造成不同的挫折感受。</p><p>凡事皆以平常心来看待，对于生命顺逆不要太执著。能够“破我执”是很高层的人生境界。</p><p>人事的艰难就是一种考验。就像—支剑要有磨刀来磨，剑才会利:一块璞玉要有粗石来磨，才会发出耀眼的光芒。我们能够做到的，只是如何减少、避免那些由于自身的原因所造成的挫折，而在遇到痛苦和挫折之后，则力求化解痛苦，争取幸福。我们要知道，痛苦和挫折是双重性的，它既是我们人生中难以完全避免的，也是我们在争取成功时，不可缺少的一种动力。因为我认为，推动我们奋斗的力量，不仅仅是对成功的渴望，还有为摆脱痛苦和挫折而进行的奋斗。</p>'),(115,'2026-01-02 09:35:53','你要去相信，没有到不了的明天','有梦想就去努力，因为在这一辈子里面，现在不去勇敢的努力，也许就再也没有机会了。你要去相信，一定要相信，没有到不了的明天。不要被命运打败，让自己变得更强大。不管你现在是一个人走在异乡的街道上始终没有找到一丝归属感，还是你在跟朋友们一起吃饭开心址笑着的时候闪过一丝落寞。','upload/news_picture5.jpg','<p>有梦想就去努力，因为在这一辈子里面，现在不去勇敢的努力，也许就再也没有机会了。你要去相信，一定要相信，没有到不了的明天。不要被命运打败，让自己变得更强大。</p><p>不管你现在是一个人走在异乡的街道上始终没有找到一丝归属感，还是你在跟朋友们一起吃饭开心址笑着的时候闪过一丝落寞。</p><p>	不管你现在是在图书馆里背着怎么也看不进去的英语单词，还是你现在迷茫地看不清未来的方向不知道要往哪走。</p><p>不管你现在是在努力着去实现梦想却没能拉近与梦想的距离，还是你已经慢慢地找不到自己的梦想了。</p><p>你都要去相信，没有到不了的明天。</p><p>	有的时候你的梦想太大，别人说你的梦想根本不可能实现;有的时候你的梦想又太小，又有人说你胸无大志;有的时候你对死党说着将来要去环游世界的梦想，却换来他的不屑一顾，于是你再也不提自己的梦想;有的时候你突然说起将来要开个小店的愿望，却发现你讲述的那个人，并没有听到你在说什么。</p><p>不过又能怎么样呢，未来始终是自己的，梦想始终是自己的，没有人会来帮你实现它。</p><p>也许很多时候我们只是需要朋友的一句鼓励，一句安慰，却也得不到。但是相信我，世界上还有很多人，只是想要和你说说话。</p><p>因为我们都一样。一样的被人说成固执，一样的在追逐他们眼里根本不在意的东西。</p><p>所以，又有什么关系呢，别人始终不是你、不能懂你的心情，你又何必多去解释呢。这个世界会来阻止你，困难也会接踵而至，其实真正关键的只有自己，有没有那个倔强。</p><p>这个世界上没有不带伤的人，真正能治愈自己的，只有自己。</p>'),(116,'2026-01-02 09:35:53','离开是一种痛苦，是一种勇气，但同样也是一个考验，是一个新的开端','无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。','upload/news_picture6.jpg','<p>无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。离别的确是一种痛苦，但同样也是我们走入社会，走向新环境、新领域的一个开端，希望大家在以后新的工作岗位上能够确定自己的新起点，坚持不懈，向着更新、更高的目标前进，因为人生最美好的东西永远都在最前方!</p><p>忆往昔峥嵘岁月，看今朝潮起潮落，望未来任重而道远。作为新时代的我们，就应在失败时，能拼搏奋起，去谱写人生的辉煌。在成功时，亦能居安思危，不沉湎于一时的荣耀、鲜花和掌声中，时时刻刻怀着一颗积极寻找自己新的奶酪的心，处变不惊、成败不渝，始终踏着自己坚实的步伐，从零开始，不断向前迈进，这样才能在这风起云涌、变幻莫测的社会大潮中成为真正的弄潮儿!</p>'),(117,'2026-01-02 09:35:53','Leave未必是一种痛苦','无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。','upload/news_picture7.jpg','<p>无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。离别的确是一种痛苦，但同样也是我们走入社会，走向新环境、新领域的一个开端，希望大家在以后新的工作岗位上能够确定自己的新起点，坚持不懈，向着更新、更高的目标前进，因为人生最美好的东西永远都在最前方!</p><p>忆往昔峥嵘岁月，看今朝潮起潮落，望未来任重而道远。作为新时代的我们，就应在失败时，能拼搏奋起，去谱写人生的辉煌。在成功时，亦能居安思危，不沉湎于一时的荣耀、鲜花和掌声中，时时刻刻怀着一颗积极寻找自己新的奶酪的心，处变不惊、成败不渝，始终踏着自己坚实的步伐，从零开始，不断向前迈进，这样才能在这风起云涌、变幻莫测的社会大潮中成为真正的弄潮儿!</p>'),(118,'2026-01-02 09:35:53','坚持才会成功','回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。','upload/news_picture8.jpg','<p>回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?</p><p>清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。</p><p>是的，面对道途上那无情的嘲讽，面对步伐中那重复的摔跤，面对激流与硬石之间猛烈的碰撞，我们必须选择那富于阴雨，却最终见到彩虹的荆棘路。也许，经历了那暴风雨的洗礼，我们便会变得自信，幸福也随之而来。</p><p>司马迁屡遭羞辱，却依然在狱中撰写《史记》，作为一名史学家，不因王权而极度赞赏，也不因卑微而极度批判，然而他在坚持自己操守的同时，却依然要受统治阶级的阻碍，他似乎无权选择自己的本职。但是，他不顾于此，只是在面对道途的阻隔之时，他依然选择了走下去的信念。终于一部开山巨作《史记》诞生，为后人留下一份馈赠，也许在他完成毕生的杰作之时，他微微地笑了，没有什么比梦想实现更快乐的了......</p><p>	或许正如“长风破浪会有时，直挂云帆济沧海”一般，欣欣然地走向看似深渊的崎岖路，而在一番耕耘之后，便会发现这里另有一番天地。也许这就是困难与快乐的交融。</p><p>也许在形形色色的社会中，我们常能看到一份坚持，一份自信，但这里却还有一类人。这类人在暴风雨来临之际，只会闪躲，从未懂得这也是一种历炼，这何尝不是一份快乐。在阴暗的角落里，总是独自在哭，带着伤愁，看不到一点希望。</p><p>我们不能堕落于此，而要像海燕那般，在苍茫的大海上，高傲地飞翔，任何事物都无法阻挡，任何事都是幸福快乐的。</p>'),(1739333256324,'2026-01-12 04:07:35','1','111','upload/1739333251220.jpg','<p>11111</p>');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qingjia`
--

DROP TABLE IF EXISTS `qingjia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qingjia` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `biaoti` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '标题',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生学号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生姓名',
  `qingjia1` timestamp NULL DEFAULT NULL COMMENT '请假日期起',
  `qingjia2` timestamp NULL DEFAULT NULL COMMENT '请假日期止',
  `qingjiayuanyin` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '维修内容',
  `sfsh` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '审核回复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1777012867895 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qingjia`
--

LOCK TABLES `qingjia` WRITE;
/*!40000 ALTER TABLE `qingjia` DISABLE KEYS */;
INSERT INTO `qingjia` VALUES (1,'2026-01-02 01:35:53','回家参加婚礼','2023001','张一鸣','2026-01-16 00:00:00','2026-01-17 12:00:00','<p>家里有婚礼，需要请假两天回家。</p>','已通过','按时返校，注意路上安全'),(2,'2026-01-05 02:15:18','发烧就诊','2023002','李清雨','2026-01-18 01:00:00','2026-01-19 10:00:00','<p>持续发烧，需要去医院检查。</p>','已通过','身体恢复后记得销假'),(3,'2026-01-08 06:22:45','外出考试','2023003','王晨曦','2026-01-21 23:30:00','2026-01-22 13:30:00','<p>参加校外资格考试，当天往返。</p>','待审核',''),(4,'2026-01-10 08:08:12','家庭紧急事务','2023004','赵梓萱','2026-01-25 00:00:00','2026-01-26 14:00:00','<p>家中临时有事，需要回去处理。</p>','待审核',''),(5,'2026-01-12 01:35:40','社团活动外出','2023005','周浩然','2026-01-28 05:00:00','2026-01-28 10:00:00','<p>参加校级社团交流活动。</p>','未通过','活动证明材料不完整'),(6,'2026-01-13 03:26:30','牙科复诊','2023006','陈书瑶','2026-01-29 01:30:00','2026-01-29 08:30:00','<p>前往医院复诊，需要当天请假。</p>','已通过','请保留就诊记录'),(7,'2026-01-15 11:40:05','竞赛集训','2023007','孙嘉佑','2026-02-02 00:00:00','2026-02-03 14:00:00','<p>学院组织校外竞赛集训。</p>','待审核',''),(8,'2026-01-18 00:52:57','陪同家人看病','2023008','许梦琪','2026-02-04 23:00:00','2026-02-05 15:00:00','<p>需要陪同家人去医院检查。</p>','未通过','请上传家长说明后重新申请'),(1777000880288,'2026-04-24 03:21:19','111111','1','学生姓名1','2026-04-23 03:21:11','2026-04-30 03:21:11','<p>1111111</p>','待审核',''),(1777012867894,'2026-04-24 06:41:07','1','1','林泽宇','2026-04-22 06:40:58','2026-04-30 06:40:58','<p>111111</p>','待审核','');
/*!40000 ALTER TABLE `qingjia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shuidianfei`
--

DROP TABLE IF EXISTS `shuidianfei`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shuidianfei` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sushemingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍名称',
  `susheleixing` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍类型',
  `susheloudong` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍楼栋',
  `fangjianhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '房间号',
  `yuefen` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '月份',
  `shuifei` float DEFAULT NULL COMMENT '水费',
  `dianfei` float DEFAULT NULL COMMENT '电费',
  `zongjine` float DEFAULT NULL COMMENT '总金额',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生学号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生姓名',
  `dengjishijian` date DEFAULT NULL COMMENT '登记时间',
  `xiangqing` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '详情',
  `ispay` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '未支付' COMMENT '是否支付',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1777012498057 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='水电费';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shuidianfei`
--

LOCK TABLES `shuidianfei` WRITE;
/*!40000 ALTER TABLE `shuidianfei` DISABLE KEYS */;
INSERT INTO `shuidianfei` VALUES (41,'2025-09-08 01:35:53','博学苑1-201','四人间','1号楼','201','2025年9月',12.5,26.4,38.9,'2023001','张一鸣','2025-09-08','9 月宿舍基础用水用电','已支付'),(42,'2025-10-08 01:35:53','博学苑1-201','四人间','1号楼','201','2025年10月',14.2,29.8,44,'2023001','张一鸣','2025-10-08','10 月宿舍基础用水用电','已支付'),(43,'2025-11-08 01:35:53','博学苑1-201','四人间','1号楼','201','2025年11月',15.4,31.5,46.9,'2023001','张一鸣','2025-11-08','11 月宿舍基础用水用电','已支付'),(44,'2025-12-08 01:35:53','博学苑1-201','四人间','1号楼','201','2025年12月',18.6,34.7,53.3,'2023001','张一鸣','2025-12-08','12 月宿舍基础用水用电','未支付'),(45,'2026-01-08 01:35:53','博学苑1-201','四人间','1号楼','201','2026年1月',16.8,33.2,50,'2023001','张一鸣','2026-01-08','1 月宿舍基础用水用电','未支付'),(46,'2026-02-08 01:35:53','博学苑1-201','四人间','1号楼','201','2026年2月',13.9,28.4,42.3,'2023001','张一鸣','2026-02-08','2 月宿舍基础用水用电','已支付'),(47,'2026-03-08 01:35:53','博学苑2-305','六人间','2号楼','305','2026年3月',19.6,37.1,56.7,'2023002','李清雨','2026-03-08','3 月宿舍基础用水用电','未支付'),(48,'2026-04-08 01:35:53','博学苑2-305','六人间','2号楼','305','2026年4月',17.3,35.6,52.9,'2023002','李清雨','2026-04-08','4 月宿舍基础用水用电','已支付'),(49,'2026-05-08 01:35:53','博学苑3-402','四人间','3号楼','402','2026年5月',21.8,42.6,64.4,'2023003','王晨曦','2026-05-08','5 月宿舍基础用水用电','未支付'),(50,'2026-06-08 01:35:53','博学苑3-402','四人间','3号楼','402','2026年6月',24.5,48.8,73.3,'2023003','王晨曦','2026-06-08','6 月宿舍基础用水用电','未支付'),(51,'2026-07-08 01:35:53','博学苑4-508','六人间','4号楼','508','2026年7月',20.2,39.7,59.9,'2023004','赵梓萱','2026-07-08','7 月宿舍基础用水用电','已支付'),(52,'2026-08-08 01:35:53','博学苑4-508','六人间','4号楼','508','2026年8月',22.4,41.9,64.3,'2023004','赵梓萱','2026-08-08','8 月宿舍基础用水用电','未支付'),(1777012494368,'2026-04-24 06:34:54','博学苑1-201','男生','1号楼','201','2026-04',1000,100,1100,'2','周昊然','2026-04-24','<p>1111</p>','未支付'),(1777012494560,'2026-04-24 06:34:54','博学苑1-201','男生','1号楼','201','2026-04',1000,100,1100,'4','陈奕鸣','2026-04-24','<p>1111</p>','未支付'),(1777012494621,'2026-04-24 06:34:54','博学苑1-201','男生','1号楼','201','2026-04',1000,100,1100,'3','许嘉辰','2026-04-24','<p>1111</p>','未支付'),(1777012494652,'2026-04-24 06:34:54','博学苑1-201','男生','1号楼','201','2026-04',1000,100,1100,'1','林泽宇','2026-04-24','<p>1111</p>','未支付'),(1777012494740,'2026-04-24 06:34:54','博学苑1-202','男生','1号楼','202','2026-04',1000,100,1100,'学生学号2','赵一帆','2026-04-24','<p>1111</p>','未支付'),(1777012494913,'2026-04-24 06:34:54','博学苑1-202','男生','1号楼','202','2026-04',1000,100,1100,'学生学号3','孙承泽','2026-04-24','<p>1111</p>','未支付'),(1777012495023,'2026-04-24 06:34:54','博学苑1-301','男生','1号楼','301','2026-04',1000,100,1100,'20241025','秦墨言','2026-04-24','<p>1111</p>','未支付'),(1777012495202,'2026-04-24 06:34:54','博学苑1-301','男生','1号楼','301','2026-04',1000,100,1100,'学生学号7','高远航','2026-04-24','<p>1111</p>','未支付'),(1777012495276,'2026-04-24 06:34:54','博学苑2-305','女生','2号楼','305','2026-04',1000,100,1100,'20241001','沈知夏','2026-04-24','<p>1111</p>','未支付'),(1777012495279,'2026-04-24 06:34:54','博学苑1-301','男生','1号楼','301','2026-04',1000,100,1100,'123','方逸晨','2026-04-24','<p>1111</p>','未支付'),(1777012495343,'2026-04-24 06:34:55','博学苑2-306','女生','2号楼','306','2026-04',1000,100,1100,'20241007','裴书瑶','2026-04-24','<p>1111</p>','未支付'),(1777012495375,'2026-04-24 06:34:54','博学苑1-202','男生','1号楼','202','2026-04',1000,100,1100,'学生学号4','吴俊豪','2026-04-24','<p>1111</p>','未支付'),(1777012495387,'2026-04-24 06:34:54','博学苑1-301','男生','1号楼','301','2026-04',1000,100,1100,'学生学号8','谢子墨','2026-04-24','<p>1111</p>','未支付'),(1777012495432,'2026-04-24 06:34:54','博学苑1-301','男生','1号楼','301','2026-04',1000,100,1100,'学生学号6','何景曜','2026-04-24','<p>1111</p>','未支付'),(1777012495474,'2026-04-24 06:34:54','博学苑1-202','男生','1号楼','202','2026-04',1000,100,1100,'学生学号5','郑博文','2026-04-24','<p>1111</p>','未支付'),(1777012495597,'2026-04-24 06:34:55','博学苑2-305','女生','2号楼','305','2026-04',1000,100,1100,'20241006','唐婉宁','2026-04-24','<p>1111</p>','未支付'),(1777012495619,'2026-04-24 06:34:55','博学苑2-306','女生','2号楼','306','2026-04',1000,100,1100,'20241008','乔若涵','2026-04-24','<p>1111</p>','未支付'),(1777012495651,'2026-04-24 06:34:55','博学苑2-306','女生','2号楼','306','2026-04',1000,100,1100,'20241009','苏念安','2026-04-24','<p>1111</p>','未支付'),(1777012495756,'2026-04-24 06:34:55','博学苑2-306','女生','2号楼','306','2026-04',1000,100,1100,'20241010','陆星冉','2026-04-24','<p>1111</p>','未支付'),(1777012495817,'2026-04-24 06:34:54','博学苑2-305','女生','2号楼','305','2026-04',1000,100,1100,'20241002','顾清禾','2026-04-24','<p>1111</p>','未支付'),(1777012495841,'2026-04-24 06:34:55','博学苑3-402','男生','3号楼','402','2026-04',1000,100,1100,'20241029','许砚舟','2026-04-24','<p>1111</p>','未支付'),(1777012495900,'2026-04-24 06:34:54','博学苑2-305','女生','2号楼','305','2026-04',1000,100,1100,'20241005','许知意','2026-04-24','<p>1111</p>','未支付'),(1777012495919,'2026-04-24 06:34:54','博学苑2-305','女生','2号楼','305','2026-04',1000,100,1100,'20241004','姜晚晴','2026-04-24','<p>1111</p>','未支付'),(1777012495952,'2026-04-24 06:34:54','博学苑2-305','女生','2号楼','305','2026-04',1000,100,1100,'20241003','宋雨桐','2026-04-24','<p>1111</p>','未支付'),(1777012496156,'2026-04-24 06:34:55','博学苑2-401','女生','2号楼','401','2026-04',1000,100,1100,'20241012','温可欣','2026-04-24','<p>1111</p>','未支付'),(1777012496238,'2026-04-24 06:34:55','博学苑3-402','男生','3号楼','402','2026-04',1000,100,1100,'20241027','贺星洲','2026-04-24','<p>1111</p>','未支付'),(1777012496257,'2026-04-24 06:34:55','博学苑2-401','女生','2号楼','401','2026-04',1000,100,1100,'20241011','程语棠','2026-04-24','<p>1111</p>','未支付'),(1777012496361,'2026-04-24 06:34:55','博学苑3-403','男生','3号楼','403','2026-04',1000,100,1100,'20241032','傅景行','2026-04-24','<p>1111</p>','未支付'),(1777012496375,'2026-04-24 06:34:55','博学苑3-402','男生','3号楼','402','2026-04',1000,100,1100,'20241026','陆修远','2026-04-24','<p>1111</p>','未支付'),(1777012496412,'2026-04-24 06:34:56','博学苑4-509','女生','4号楼','509','2026-04',1000,100,1100,'20241021','顾念慈','2026-04-24','<p>1111</p>','未支付'),(1777012496493,'2026-04-24 06:34:56','博学苑4-508','女生','4号楼','508','2026-04',1000,100,1100,'20241018','季书宁','2026-04-24','<p>1111</p>','未支付'),(1777012496509,'2026-04-24 06:34:56','博学苑4-508','女生','4号楼','508','2026-04',1000,100,1100,'20241017','韩若溪','2026-04-24','<p>1111</p>','未支付'),(1777012496524,'2026-04-24 06:34:55','博学苑3-403','男生','3号楼','403','2026-04',1000,100,1100,'20241031','顾明川','2026-04-24','<p>1111</p>','未支付'),(1777012496580,'2026-04-24 06:34:55','博学苑3-402','男生','3号楼','402','2026-04',1000,100,1100,'20241028','裴景川','2026-04-24','<p>1111</p>','未支付'),(1777012496582,'2026-04-24 06:34:55','博学苑2-401','女生','2号楼','401','2026-04',1000,100,1100,'20241013','江予初','2026-04-24','<p>1111</p>','未支付'),(1777012496694,'2026-04-24 06:34:55','博学苑3-403','男生','3号楼','403','2026-04',1000,100,1100,'20241033','周慕白','2026-04-24','<p>1111</p>','未支付'),(1777012496774,'2026-04-24 06:34:55','博学苑4-508','女生','4号楼','508','2026-04',1000,100,1100,'20241015','叶知微','2026-04-24','<p>1111</p>','未支付'),(1777012496782,'2026-04-24 06:34:56','博学苑5-601','男生','5号楼','601','2026-04',1000,100,1100,'20241034','苏言澈','2026-04-24','<p>1111</p>','未支付'),(1777012496787,'2026-04-24 06:34:56','博学苑4-509','女生','4号楼','509','2026-04',1000,100,1100,'20241022','周书怡','2026-04-24','<p>1111</p>','未支付'),(1777012496898,'2026-04-24 06:34:56','博学苑5-601','男生','5号楼','601','2026-04',1000,100,1100,'20241036','林叙川','2026-04-24','<p>1111</p>','未支付'),(1777012496907,'2026-04-24 06:34:56','博学苑4-509','女生','4号楼','509','2026-04',1000,100,1100,'20241019','许安琪','2026-04-24','<p>1111</p>','未支付'),(1777012496931,'2026-04-24 06:34:55','博学苑3-403','男生','3号楼','403','2026-04',1000,100,1100,'20241030','梁叙白','2026-04-24','<p>1111</p>','未支付'),(1777012496940,'2026-04-24 06:34:55','博学苑4-508','女生','4号楼','508','2026-04',1000,100,1100,'20241014','林诗妍','2026-04-24','<p>1111</p>','未支付'),(1777012497054,'2026-04-24 06:34:57','博学苑6-206','女生','6号楼','206','2026-04',1000,100,1100,'20241045','夏知许','2026-04-24','<p>1111</p>','未支付'),(1777012497102,'2026-04-24 06:34:57','博学苑6-206','女生','6号楼','206','2026-04',1000,100,1100,'20241044','温书言','2026-04-24','<p>1111</p>','未支付'),(1777012497158,'2026-04-24 06:34:56','博学苑4-509','女生','4号楼','509','2026-04',1000,100,1100,'20241020','沈嘉月','2026-04-24','<p>1111</p>','未支付'),(1777012497161,'2026-04-24 06:34:56','博学苑4-509','女生','4号楼','509','2026-04',1000,100,1100,'20241023','陆晚秋','2026-04-24','<p>1111</p>','未支付'),(1777012497176,'2026-04-24 06:34:56','博学苑5-601','男生','5号楼','601','2026-04',1000,100,1100,'20241035','沈砚之','2026-04-24','<p>1111</p>','未支付'),(1777012497183,'2026-04-24 06:34:56','博学苑4-508','女生','4号楼','508','2026-04',1000,100,1100,'20241016','白沐瑶','2026-04-24','<p>1111</p>','未支付'),(1777012497189,'2026-04-24 06:34:57','博学苑5-601','男生','5号楼','601','2026-04',1000,100,1100,'20241037','江屿川','2026-04-24','<p>1111</p>','未支付'),(1777012497318,'2026-04-24 06:34:57','博学苑5-601','男生','5号楼','601','2026-04',1000,100,1100,'20241039','陆鸣谦','2026-04-24','<p>1111</p>','未支付'),(1777012497415,'2026-04-24 06:34:57','博学苑5-601','男生','5号楼','601','2026-04',1000,100,1100,'20241038','程知行','2026-04-24','<p>1111</p>','未支付'),(1777012497495,'2026-04-24 06:34:57','博学苑6-206','女生','6号楼','206','2026-04',1000,100,1100,'20241047','闻可岚','2026-04-24','<p>1111</p>','未支付'),(1777012497608,'2026-04-24 06:34:56','博学苑4-509','女生','4号楼','509','2026-04',1000,100,1100,'20241024','方知韵','2026-04-24','<p>1111</p>','未支付'),(1777012497810,'2026-04-24 06:34:57','博学苑6-206','女生','6号楼','206','2026-04',1000,100,1100,'20241043','纪南乔','2026-04-24','<p>1111</p>','未支付'),(1777012497827,'2026-04-24 06:34:57','博学苑6-206','女生','6号楼','206','2026-04',1000,100,1100,'20241046','苏清妍','2026-04-24','<p>1111</p>','未支付'),(1777012497908,'2026-04-24 06:34:57','博学苑6-206','女生','6号楼','206','2026-04',1000,100,1100,'20241048','顾芷晴','2026-04-24','<p>1111</p>','未支付'),(1777012498056,'2026-04-24 06:34:57','博学苑6-206','女生','6号楼','206','2026-04',1000,100,1100,'20241049','沈书宁','2026-04-24','<p>1111</p>','未支付');
/*!40000 ALTER TABLE `shuidianfei` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suguan`
--

DROP TABLE IF EXISTS `suguan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suguan` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zhanghao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '账号',
  `mima` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `suguanxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '宿管姓名',
  `xingbie` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '性别',
  `touxiang` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '头像',
  `dianhua` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1737478901990 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suguan`
--

LOCK TABLES `suguan` WRITE;
/*!40000 ALTER TABLE `suguan` DISABLE KEYS */;
INSERT INTO `suguan` VALUES (1,'2026-01-17 06:22:16','123','123','宿管1','男','upload/1737470614083.jpg','12312341234'),(1737478901989,'2026-01-21 17:01:41','1','1','111','男','','');
/*!40000 ALTER TABLE `suguan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sushefenpei`
--

DROP TABLE IF EXISTS `sushefenpei`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sushefenpei` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sushemingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍名称',
  `susheleixing` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍类型',
  `susheloudong` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍楼栋',
  `fangjianhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '房间号',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生学号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生姓名',
  `chuangweihao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '床位号',
  `fenpeiriqi` date DEFAULT NULL COMMENT '分配日期',
  `beizhu` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1776155266677 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='宿舍分配';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sushefenpei`
--

LOCK TABLES `sushefenpei` WRITE;
/*!40000 ALTER TABLE `sushefenpei` DISABLE KEYS */;
INSERT INTO `sushefenpei` VALUES (500001,'2026-04-24 03:51:20','博学苑1-201','男生','1号楼','201','1','林泽宇','1号床','2026-04-24','按宿舍信息同步'),(500002,'2026-04-24 03:51:20','博学苑1-201','男生','1号楼','201','2','周昊然','2号床','2026-04-24','按宿舍信息同步'),(500003,'2026-04-24 03:51:20','博学苑1-201','男生','1号楼','201','3','许嘉辰','3号床','2026-04-24','按宿舍信息同步'),(500004,'2026-04-24 03:51:20','博学苑1-201','男生','1号楼','201','4','陈奕鸣','4号床','2026-04-24','按宿舍信息同步'),(500005,'2026-04-24 03:51:20','博学苑1-202','男生','1号楼','202','学生学号2','赵一帆','1号床','2026-04-24','按宿舍信息同步'),(500006,'2026-04-24 03:51:20','博学苑1-202','男生','1号楼','202','学生学号3','孙承泽','2号床','2026-04-24','按宿舍信息同步'),(500007,'2026-04-24 03:51:20','博学苑1-202','男生','1号楼','202','学生学号4','吴俊豪','3号床','2026-04-24','按宿舍信息同步'),(500008,'2026-04-24 03:51:20','博学苑1-202','男生','1号楼','202','学生学号5','郑博文','4号床','2026-04-24','按宿舍信息同步'),(500009,'2026-04-24 03:51:20','博学苑1-301','男生','1号楼','301','学生学号6','何景曜','1号床','2026-04-24','按宿舍信息同步'),(500010,'2026-04-24 03:51:20','博学苑1-301','男生','1号楼','301','学生学号7','高远航','2号床','2026-04-24','按宿舍信息同步'),(500011,'2026-04-24 03:51:20','博学苑1-301','男生','1号楼','301','学生学号8','谢子墨','3号床','2026-04-24','按宿舍信息同步'),(500012,'2026-04-24 03:51:20','博学苑1-301','男生','1号楼','301','123','方逸晨','4号床','2026-04-24','按宿舍信息同步'),(500013,'2026-04-24 03:51:20','博学苑1-301','男生','1号楼','301','20241025','秦墨言','5号床','2026-04-24','按宿舍信息同步'),(500014,'2026-04-24 03:51:20','博学苑2-305','女生','2号楼','305','20241001','沈知夏','1号床','2026-04-24','按宿舍信息同步'),(500015,'2026-04-24 03:51:20','博学苑2-305','女生','2号楼','305','20241002','顾清禾','2号床','2026-04-24','按宿舍信息同步'),(500016,'2026-04-24 03:51:20','博学苑2-305','女生','2号楼','305','20241003','宋雨桐','3号床','2026-04-24','按宿舍信息同步'),(500017,'2026-04-24 03:51:20','博学苑2-305','女生','2号楼','305','20241004','姜晚晴','4号床','2026-04-24','按宿舍信息同步'),(500018,'2026-04-24 03:51:20','博学苑2-305','女生','2号楼','305','20241005','许知意','5号床','2026-04-24','按宿舍信息同步'),(500019,'2026-04-24 03:51:20','博学苑2-305','女生','2号楼','305','20241006','唐婉宁','6号床','2026-04-24','按宿舍信息同步'),(500020,'2026-04-24 03:51:20','博学苑2-306','女生','2号楼','306','20241007','裴书瑶','1号床','2026-04-24','按宿舍信息同步'),(500021,'2026-04-24 03:51:20','博学苑2-306','女生','2号楼','306','20241008','乔若涵','2号床','2026-04-24','按宿舍信息同步'),(500022,'2026-04-24 03:51:20','博学苑2-306','女生','2号楼','306','20241009','苏念安','3号床','2026-04-24','按宿舍信息同步'),(500023,'2026-04-24 03:51:20','博学苑2-306','女生','2号楼','306','20241010','陆星冉','4号床','2026-04-24','按宿舍信息同步'),(500024,'2026-04-24 03:51:20','博学苑2-401','女生','2号楼','401','20241011','程语棠','1号床','2026-04-24','按宿舍信息同步'),(500025,'2026-04-24 03:51:20','博学苑2-401','女生','2号楼','401','20241012','温可欣','2号床','2026-04-24','按宿舍信息同步'),(500026,'2026-04-24 03:51:20','博学苑2-401','女生','2号楼','401','20241013','江予初','3号床','2026-04-24','按宿舍信息同步'),(500027,'2026-04-24 03:51:20','博学苑3-402','男生','3号楼','402','20241026','陆修远','1号床','2026-04-24','按宿舍信息同步'),(500028,'2026-04-24 03:51:20','博学苑3-402','男生','3号楼','402','20241027','贺星洲','2号床','2026-04-24','按宿舍信息同步'),(500029,'2026-04-24 03:51:20','博学苑3-402','男生','3号楼','402','20241028','裴景川','3号床','2026-04-24','按宿舍信息同步'),(500030,'2026-04-24 03:51:20','博学苑3-402','男生','3号楼','402','20241029','许砚舟','4号床','2026-04-24','按宿舍信息同步'),(500031,'2026-04-24 03:51:20','博学苑3-403','男生','3号楼','403','20241030','梁叙白','1号床','2026-04-24','按宿舍信息同步'),(500032,'2026-04-24 03:51:20','博学苑3-403','男生','3号楼','403','20241031','顾明川','2号床','2026-04-24','按宿舍信息同步'),(500033,'2026-04-24 03:51:20','博学苑3-403','男生','3号楼','403','20241032','傅景行','3号床','2026-04-24','按宿舍信息同步'),(500034,'2026-04-24 03:51:20','博学苑3-403','男生','3号楼','403','20241033','周慕白','4号床','2026-04-24','按宿舍信息同步'),(500035,'2026-04-24 03:51:20','博学苑4-508','女生','4号楼','508','20241014','林诗妍','1号床','2026-04-24','按宿舍信息同步'),(500036,'2026-04-24 03:51:20','博学苑4-508','女生','4号楼','508','20241015','叶知微','2号床','2026-04-24','按宿舍信息同步'),(500037,'2026-04-24 03:51:20','博学苑4-508','女生','4号楼','508','20241016','白沐瑶','3号床','2026-04-24','按宿舍信息同步'),(500038,'2026-04-24 03:51:20','博学苑4-508','女生','4号楼','508','20241017','韩若溪','4号床','2026-04-24','按宿舍信息同步'),(500039,'2026-04-24 03:51:20','博学苑4-508','女生','4号楼','508','20241018','季书宁','5号床','2026-04-24','按宿舍信息同步'),(500040,'2026-04-24 03:51:20','博学苑4-509','女生','4号楼','509','20241019','许安琪','1号床','2026-04-24','按宿舍信息同步'),(500041,'2026-04-24 03:51:20','博学苑4-509','女生','4号楼','509','20241020','沈嘉月','2号床','2026-04-24','按宿舍信息同步'),(500042,'2026-04-24 03:51:20','博学苑4-509','女生','4号楼','509','20241021','顾念慈','3号床','2026-04-24','按宿舍信息同步'),(500043,'2026-04-24 03:51:20','博学苑4-509','女生','4号楼','509','20241022','周书怡','4号床','2026-04-24','按宿舍信息同步'),(500044,'2026-04-24 03:51:20','博学苑4-509','女生','4号楼','509','20241023','陆晚秋','5号床','2026-04-24','按宿舍信息同步'),(500045,'2026-04-24 03:51:20','博学苑4-509','女生','4号楼','509','20241024','方知韵','6号床','2026-04-24','按宿舍信息同步'),(500046,'2026-04-24 03:51:20','博学苑5-601','男生','5号楼','601','20241034','苏言澈','1号床','2026-04-24','按宿舍信息同步'),(500047,'2026-04-24 03:51:20','博学苑5-601','男生','5号楼','601','20241035','沈砚之','2号床','2026-04-24','按宿舍信息同步'),(500048,'2026-04-24 03:51:20','博学苑5-601','男生','5号楼','601','20241036','林叙川','3号床','2026-04-24','按宿舍信息同步'),(500049,'2026-04-24 03:51:20','博学苑5-601','男生','5号楼','601','20241037','江屿川','4号床','2026-04-24','按宿舍信息同步'),(500050,'2026-04-24 03:51:20','博学苑5-601','男生','5号楼','601','20241038','程知行','5号床','2026-04-24','按宿舍信息同步'),(500051,'2026-04-24 03:51:20','博学苑5-601','男生','5号楼','601','20241039','陆鸣谦','6号床','2026-04-24','按宿舍信息同步'),(500052,'2026-04-24 03:51:20','博学苑6-206','女生','6号楼','206','20241043','纪南乔','1号床','2026-04-24','按宿舍信息同步'),(500053,'2026-04-24 03:51:20','博学苑6-206','女生','6号楼','206','20241044','温书言','2号床','2026-04-24','按宿舍信息同步'),(500054,'2026-04-24 03:51:20','博学苑6-206','女生','6号楼','206','20241045','夏知许','3号床','2026-04-24','按宿舍信息同步'),(500055,'2026-04-24 03:51:20','博学苑6-206','女生','6号楼','206','20241046','苏清妍','4号床','2026-04-24','按宿舍信息同步'),(500056,'2026-04-24 03:51:20','博学苑6-206','女生','6号楼','206','20241047','闻可岚','5号床','2026-04-24','按宿舍信息同步'),(500057,'2026-04-24 03:51:20','博学苑6-206','女生','6号楼','206','20241048','顾芷晴','6号床','2026-04-24','按宿舍信息同步'),(500058,'2026-04-24 03:51:20','博学苑6-206','女生','6号楼','206','20241049','沈书宁','7号床','2026-04-24','按宿舍信息同步');
/*!40000 ALTER TABLE `sushefenpei` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sushexinxi`
--

DROP TABLE IF EXISTS `sushexinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sushexinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sushemingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍名称',
  `susheleixing` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍类型',
  `susheloudong` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍楼栋',
  `fangjianhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '房间号',
  `kezhurenshu` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '可住人数',
  `yizhurenshu` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '已住人数',
  `youchuangwei` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '有床位',
  `gengxinshijian` date DEFAULT NULL COMMENT '更新时间',
  `xiangqing` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1737030560890 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='宿舍信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sushexinxi`
--

LOCK TABLES `sushexinxi` WRITE;
/*!40000 ALTER TABLE `sushexinxi` DISABLE KEYS */;
INSERT INTO `sushexinxi` VALUES (21,'2026-01-08 01:35:53','博学苑1-201','男生','1号楼','201','4','4','否','2026-04-24','四人间，靠近洗衣房'),(22,'2026-01-08 01:35:53','博学苑1-202','男生','1号楼','202','4','4','否','2026-04-24','四人间，南向通风较好'),(23,'2026-01-08 01:35:53','博学苑1-301','男生','1号楼','301','6','5','是','2026-04-24','六人间，靠近楼梯口'),(24,'2026-01-08 01:35:53','博学苑2-305','女生','2号楼','305','6','6','否','2026-04-24','六人间，已满员'),(25,'2026-01-08 01:35:53','博学苑2-306','女生','2号楼','306','6','4','是','2026-04-24','六人间，临近开水房'),(26,'2026-01-08 01:35:53','博学苑2-401','女生','2号楼','401','4','3','是','2026-04-24','四人间，采光好'),(27,'2026-01-08 01:35:53','博学苑3-402','男生','3号楼','402','4','4','否','2026-04-24','四人间，靠近门禁'),(28,'2026-01-08 01:35:53','博学苑3-403','男生','3号楼','403','4','4','否','2026-04-24','四人间，临近公共休息区'),(29,'2026-01-08 01:35:53','博学苑4-508','女生','4号楼','508','6','5','是','2026-04-24','六人间，靠近电梯'),(30,'2026-01-08 01:35:53','博学苑4-509','女生','4号楼','509','6','6','否','2026-04-24','六人间，已满员'),(31,'2026-01-08 01:35:53','博学苑5-601','男生','5号楼','601','8','6','是','2026-04-24','八人间，新更换床架'),(32,'2026-01-08 01:35:53','博学苑6-206','女生','6号楼','206','8','7','是','2026-04-24','八人间，近门厅');
/*!40000 ALTER TABLE `sushexinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemintro`
--

DROP TABLE IF EXISTS `systemintro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `systemintro` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `subtitle` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '副标题',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `picture1` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '图片1',
  `picture2` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '图片2',
  `picture3` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '图片3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='关于我们';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemintro`
--

LOCK TABLES `systemintro` WRITE;
/*!40000 ALTER TABLE `systemintro` DISABLE KEYS */;
INSERT INTO `systemintro` VALUES (1,'2026-01-08 09:35:53','系统简介','SYSTEM INTRODUCTION','当遇到挫折或失败，你是看见失败还是看见机会?挫折是我们每个人成长的必经之路，它不是你想有就有，想没有就没有的。有句名言说的好，如果你想一生摆脱苦难，你就得是神或者是死尸。这句话形象地说明了挫折是伴随着人生的，是谁都逃不掉的。人生在世，从古到今，不分天子平民，机遇虽有不同，但总不免有身陷困境或遭遇难题之处，这时候唯有通权达变，才能使人转危为安，甚至反败为胜。大部分的人，一生当中，最痛苦的经验是失去所爱的人，其次是丢掉一份工作。其实，经得起考验的人，就算是被开除也不会惊慌，要学会面对。','upload/systemintro_picture1.jpg','upload/systemintro_picture2.jpg','upload/systemintro_picture3.jpg');
/*!40000 ALTER TABLE `systemintro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
  `tablename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '表名',
  `role` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '角色',
  `token` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,1,'admin','users','管理员','siod7wri2goeptcoxolu2lyyvgp2ck4m','2026-01-08 09:42:10','2026-04-24 07:40:32'),(2,123,'123','users','管理员','zyr7wykj867cnnkkh88nxbqbxd1oqsla','2026-01-15 10:39:41','2026-01-12 05:08:36'),(3,19,'123','xuesheng','学生','67v10wv8kzglundc31zmq90tacycc897','2026-01-16 05:14:12','2026-01-12 04:54:14'),(4,11,'1','xuesheng','学生','ui2871l270g7lhz8jrjb5hvhr5hhp6ax','2026-01-16 09:38:14','2026-04-24 07:40:54'),(5,1,'123','suguan','宿管','jihpnb6lckwevz3duvkf3iz5j4q9t9ky','2026-01-21 14:30:33','2026-04-14 08:17:38'),(6,1737478901989,'1','suguan','宿管','8qqr4httpsa6mxjoxdkrbl2fsmursbpk','2026-01-21 17:01:52','2026-04-24 07:38:22'),(7,12,'学生学号2','xuesheng','学生','nxybjc6zux6vu6mwepjit2bhedmd5b2d','2026-04-14 07:21:05','2026-04-24 04:13:06'),(8,200021,'20240021','xuesheng','学生','krqce4cuxo6omh9uz2y3fvi7vrg3mjwz','2026-04-24 04:01:27','2026-04-24 05:01:27'),(9,300009,'20241009','xuesheng','学生','7zky0shijnaidknhx9uadva2054l114r','2026-04-24 06:39:27','2026-04-24 07:39:27');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `role` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin','管理员','2026-01-08 09:35:53'),(123,'123','123','管理员','2026-01-15 10:39:34');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weishengxinxi`
--

DROP TABLE IF EXISTS `weishengxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weishengxinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sushemingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍名称',
  `susheleixing` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍类型',
  `susheloudong` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍楼栋',
  `fangjianhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '房间号',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生学号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生姓名',
  `weishengqingkuang` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '卫生情况',
  `dengjiriqi` date DEFAULT NULL COMMENT '登记日期',
  `xiangqing` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '详情',
  `sfsh` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '审核回复',
  `pingfen` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '评分',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='卫生信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weishengxinxi`
--

LOCK TABLES `weishengxinxi` WRITE;
/*!40000 ALTER TABLE `weishengxinxi` DISABLE KEYS */;
INSERT INTO `weishengxinxi` VALUES (81,'2026-01-08 09:35:53','宿舍名称1','宿舍类型1','宿舍楼栋1','房间号1','学生学号1','学生姓名1','已打扫','2026-01-08','详情1','是','','80'),(82,'2026-01-08 09:35:53','宿舍名称2','宿舍类型2','宿舍楼栋2','房间号2','学生学号2','学生姓名2','已打扫','2026-01-08','详情2','是','',NULL),(83,'2026-01-08 09:35:53','宿舍名称3','宿舍类型3','宿舍楼栋3','房间号3','学生学号3','学生姓名3','已打扫','2026-01-08','详情3','是','',NULL),(84,'2026-01-08 09:35:53','宿舍名称4','宿舍类型4','宿舍楼栋4','房间号4','学生学号4','学生姓名4','已打扫','2026-01-08','详情4','是','',NULL),(85,'2026-01-08 09:35:53','宿舍名称5','宿舍类型5','宿舍楼栋5','房间号5','学生学号5','学生姓名5','已打扫','2026-01-08','详情5','是','',NULL),(86,'2026-01-08 09:35:53','宿舍名称6','宿舍类型6','宿舍楼栋6','房间号6','学生学号6','学生姓名6','已打扫','2026-01-08','详情6','是','123','99'),(87,'2026-01-08 09:35:53','宿舍名称7','宿舍类型7','宿舍楼栋7','房间号7','学生学号7','学生姓名7','已打扫','2026-01-08','详情7','否','',NULL),(88,'2026-01-08 09:35:53','宿舍名称8','宿舍类型8','宿舍楼栋8','房间号8','学生学号8','学生姓名8','已打扫','2026-01-08','<p>详情8</p>','是','有好好做卫生','100');
/*!40000 ALTER TABLE `weishengxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weixiuxinxi`
--

DROP TABLE IF EXISTS `weixiuxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weixiuxinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `biaoti` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '标题',
  `sushemingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍名称',
  `susheleixing` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍类型',
  `susheloudong` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '宿舍楼栋',
  `fangjianhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '房间号',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生学号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生姓名',
  `weixiuriqi` date DEFAULT NULL COMMENT '维修日期',
  `weixiuneirong` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '维修内容',
  `sfsh` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '审核回复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1777001767393 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='维修信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weixiuxinxi`
--

LOCK TABLES `weixiuxinxi` WRITE;
/*!40000 ALTER TABLE `weixiuxinxi` DISABLE KEYS */;
INSERT INTO `weixiuxinxi` VALUES (71,'2026-01-08 09:35:53','标题1','宿舍名称1','宿舍类型1','宿舍楼栋1','房间号1','学生学号1','学生姓名1','2026-01-08','维修内容1','是',''),(72,'2026-01-08 09:35:53','标题2','宿舍名称2','宿舍类型2','宿舍楼栋2','房间号2','学生学号2','学生姓名2','2026-01-08','维修内容2','是',''),(73,'2026-01-08 09:35:53','标题3','宿舍名称3','宿舍类型3','宿舍楼栋3','房间号3','学生学号3','学生姓名3','2026-01-08','维修内容3','是',''),(74,'2026-01-08 09:35:53','标题4','宿舍名称4','宿舍类型4','宿舍楼栋4','房间号4','学生学号4','学生姓名4','2026-01-08','维修内容4','是',''),(75,'2026-01-08 09:35:53','标题5','宿舍名称5','宿舍类型5','宿舍楼栋5','房间号5','学生学号5','学生姓名5','2026-01-08','维修内容5','是',''),(76,'2026-01-08 09:35:53','标题6','宿舍名称6','宿舍类型6','宿舍楼栋6','房间号6','学生学号6','学生姓名6','2026-01-08','维修内容6','是',''),(77,'2026-01-08 09:35:53','标题7','宿舍名称7','宿舍类型7','宿舍楼栋7','房间号7','学生学号7','学生姓名7','2026-01-08','维修内容7','是',''),(78,'2026-01-08 09:35:53','标题8','宿舍名称8','宿舍类型2','宿舍楼栋8','房间号8','学生学号8','学生姓名8','2026-01-08','<p>维修内容8</p>','否',''),(1737097889527,'2026-01-08 09:35:53','灯泡坏了','101','男','1','101','123','123','2026-01-08','<p>灯泡坏了</p>','是',''),(1738494465723,'2026-01-02 11:07:45','空调坏了','1','1','1','1','123','123','2026-01-02','<p>空调坏了</p>','否',''),(1738916386546,'2026-01-07 08:19:46','洗衣机坏了','1','1','1','1','123','123','2026-01-07','<p>洗衣机坏了</p>','是','明天会来人修'),(1777001767392,'2026-04-24 03:36:06','1222','博学苑1-202','男生','1号楼','202','1','学生姓名1','2026-04-24','<p>1222</p>','待审核','');
/*!40000 ALTER TABLE `weixiuxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xuesheng`
--

DROP TABLE IF EXISTS `xuesheng`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xuesheng` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xueshengxuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '学生学号',
  `mima` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '学生姓名',
  `xingbie` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '性别',
  `touxiang` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '头像',
  `xueshengdianhua` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学生电话',
  `banji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '班级',
  `zhuanye` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '专业',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `xueshengxuehao` (`xueshengxuehao`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=300050 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='学生';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xuesheng`
--

LOCK TABLES `xuesheng` WRITE;
/*!40000 ALTER TABLE `xuesheng` DISABLE KEYS */;
INSERT INTO `xuesheng` VALUES (11,'2026-01-16 09:35:52','1','1','林泽宇','男','upload/1777009718970.jpg','13823888881','软件工程1班','软件工程'),(12,'2026-01-16 09:35:52','学生学号2','123456','赵一帆','男','upload/xuesheng_touxiang2.jpg','13823888882','软件工程2班','软件工程'),(13,'2026-01-16 09:35:52','学生学号3','123456','孙承泽','男','upload/xuesheng_touxiang3.jpg','13823888883','信息安全1班','信息安全'),(14,'2026-01-16 09:35:52','学生学号4','123456','吴俊豪','男','upload/xuesheng_touxiang4.jpg','13823888884','数据科学1班','数据科学与大数据技术'),(15,'2026-01-16 09:35:52','学生学号5','123456','郑博文','男','upload/xuesheng_touxiang5.jpg','13823888885','物联网1班','物联网工程'),(16,'2026-01-16 09:35:52','学生学号6','123456','何景曜','男','upload/xuesheng_touxiang6.jpg','13823888886','自动化1班','自动化'),(17,'2026-01-16 09:35:52','学生学号7','123456','高远航','男','upload/xuesheng_touxiang7.jpg','13823888887','电子信息1班','电子信息工程'),(18,'2026-01-16 09:35:52','学生学号8','123456','谢子墨','男','upload/xuesheng_touxiang8.jpg','13823888888','通信工程1班','通信工程'),(19,'2026-01-16 09:35:52','123','123','方逸晨','男','upload/xuesheng_touxiang8.jpg','11451419198','软件工程3班','软件工程'),(200011,'2026-04-14 08:09:52','2','123456','周昊然','男','','13800010002','计算机2班','计算机科学与技术'),(200012,'2026-04-14 08:09:52','3','123456','许嘉辰','男','','13800010003','人工智能1班','人工智能'),(200013,'2026-04-14 08:09:52','4','123456','陈奕鸣','男','','13800010004','网络工程1班','网络工程'),(200021,'2026-04-14 08:21:19','20240021','123456','宋知远','男','','13800020021','计算机1班','计算机科学与技术'),(200022,'2026-04-14 08:21:19','20240022','123456','林若宁','女','','13800020022','计算机1班','计算机科学与技术'),(200023,'2026-04-14 08:21:19','20240023','123456','顾明轩','男','','13800020023','软件工程2班','软件工程'),(200024,'2026-04-14 08:21:19','20240024','123456','许安然','女','','13800020024','软件工程2班','软件工程'),(300001,'2026-04-24 03:51:20','20241001','123456','沈知夏','女','','13810000001','英语1班','英语'),(300002,'2026-04-24 03:51:20','20241002','123456','顾清禾','女','','13810000002','法学2班','法学'),(300003,'2026-04-24 03:51:20','20241003','123456','宋雨桐','女','','13810000003','会计1班','会计学'),(300004,'2026-04-24 03:51:20','20241004','123456','姜晚晴','女','','13810000004','金融2班','金融学'),(300005,'2026-04-24 03:51:20','20241005','123456','许知意','女','','13810000005','汉语言1班','汉语言文学'),(300006,'2026-04-24 03:51:20','20241006','123456','唐婉宁','女','','13810000006','教育1班','教育学'),(300007,'2026-04-24 03:51:20','20241007','123456','裴书瑶','女','','13810000007','新闻2班','新闻学'),(300008,'2026-04-24 03:51:20','20241008','123456','乔若涵','女','','13810000008','数学1班','数学与应用数学'),(300009,'2026-04-24 03:51:20','20241009','123456','苏念安','女','','13810000009','统计1班','统计学'),(300010,'2026-04-24 03:51:20','20241010','123456','陆星冉','女','','13810000010','药学1班','药学'),(300011,'2026-04-24 03:51:20','20241011','123456','程语棠','女','','13810000011','护理2班','护理学'),(300012,'2026-04-24 03:51:20','20241012','123456','温可欣','女','','13810000012','设计1班','视觉传达设计'),(300013,'2026-04-24 03:51:20','20241013','123456','江予初','女','','13810000013','心理1班','应用心理学'),(300014,'2026-04-24 03:51:20','20241014','123456','林诗妍','女','','13810000014','工商2班','工商管理'),(300015,'2026-04-24 03:51:20','20241015','123456','叶知微','女','','13810000015','行政1班','行政管理'),(300016,'2026-04-24 03:51:20','20241016','123456','白沐瑶','女','','13810000016','外语2班','商务英语'),(300017,'2026-04-24 03:51:20','20241017','123456','韩若溪','女','','13810000017','历史1班','历史学'),(300018,'2026-04-24 03:51:20','20241018','123456','季书宁','女','','13810000018','生物1班','生物科学'),(300019,'2026-04-24 03:51:20','20241019','123456','许安琪','女','','13810000019','化学2班','化学'),(300020,'2026-04-24 03:51:20','20241020','123456','沈嘉月','女','','13810000020','管理1班','公共事业管理'),(300021,'2026-04-24 03:51:20','20241021','123456','顾念慈','女','','13810000021','旅游1班','旅游管理'),(300022,'2026-04-24 03:51:20','20241022','123456','周书怡','女','','13810000022','审计1班','审计学'),(300023,'2026-04-24 03:51:20','20241023','123456','陆晚秋','女','','13810000023','传媒1班','广播电视编导'),(300024,'2026-04-24 03:51:20','20241024','123456','方知韵','女','','13810000024','医技1班','医学检验技术'),(300025,'2026-04-24 03:51:20','20241025','123456','秦墨言','男','','13810000025','土木1班','土木工程'),(300026,'2026-04-24 03:51:20','20241026','123456','陆修远','男','','13810000026','机械2班','机械设计制造及其自动化'),(300027,'2026-04-24 03:51:20','20241027','123456','贺星洲','男','','13810000027','电气1班','电气工程及其自动化'),(300028,'2026-04-24 03:51:20','20241028','123456','裴景川','男','','13810000028','软件4班','软件工程'),(300029,'2026-04-24 03:51:20','20241029','123456','许砚舟','男','','13810000029','通信2班','通信工程'),(300030,'2026-04-24 03:51:20','20241030','123456','梁叙白','男','','13810000030','自动化2班','自动化'),(300031,'2026-04-24 03:51:20','20241031','123456','顾明川','男','','13810000031','网络2班','网络工程'),(300032,'2026-04-24 03:51:20','20241032','123456','傅景行','男','','13810000032','计科3班','计算机科学与技术'),(300033,'2026-04-24 03:51:20','20241033','123456','周慕白','男','','13810000033','大数据2班','数据科学与大数据技术'),(300034,'2026-04-24 03:51:20','20241034','123456','苏言澈','男','','13810000034','信息安全2班','信息安全'),(300035,'2026-04-24 03:51:20','20241035','123456','沈砚之','男','','13810000035','人工智能2班','人工智能'),(300036,'2026-04-24 03:51:20','20241036','123456','林叙川','男','','13810000036','电子2班','电子信息工程'),(300037,'2026-04-24 03:51:20','20241037','123456','江屿川','男','','13810000037','物联网2班','物联网工程'),(300038,'2026-04-24 03:51:20','20241038','123456','程知行','男','','13810000038','软件5班','软件工程'),(300039,'2026-04-24 03:51:20','20241039','123456','陆鸣谦','男','','13810000039','机械3班','机械设计制造及其自动化'),(300040,'2026-04-24 03:51:20','20241040','123456','谢临风','男','','13810000040','自动化3班','自动化'),(300041,'2026-04-24 03:51:20','20241041','123456','周砚庭','男','','13810000041','土木2班','土木工程'),(300042,'2026-04-24 03:51:20','20241042','123456','顾云舟','男','','13810000042','软件6班','软件工程'),(300043,'2026-04-24 03:51:20','20241043','123456','纪南乔','女','','13810000043','法学3班','法学'),(300044,'2026-04-24 03:51:20','20241044','123456','温书言','女','','13810000044','教育2班','教育学'),(300045,'2026-04-24 03:51:20','20241045','123456','夏知许','女','','13810000045','设计2班','环境设计'),(300046,'2026-04-24 03:51:20','20241046','123456','苏清妍','女','','13810000046','汉语言2班','汉语言文学'),(300047,'2026-04-24 03:52:00','20241047','123456','闻可岚','女','','13810000047','学前教育1班','学前教育'),(300048,'2026-04-24 03:52:00','20241048','123456','顾芷晴','女','','13810000048','护理3班','护理学'),(300049,'2026-04-24 03:52:00','20241049','123456','沈书宁','女','','13810000049','会计3班','会计学');
/*!40000 ALTER TABLE `xuesheng` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-24 14:44:07
