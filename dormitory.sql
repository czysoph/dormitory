/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : dormitory

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 28/12/2021 23:46:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_building
-- ----------------------------
DROP TABLE IF EXISTS `tb_building`;
CREATE TABLE `tb_building`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `building_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '楼栋名',
  `floor_num` int(0) NOT NULL COMMENT '楼层数',
  `room_num` int(0) NOT NULL,
  `room_capacity` int(0) NOT NULL,
  `build_gender` int(0) NOT NULL COMMENT '此栋楼居住学生性别：女生=0；男生=1',
  `build_money` int(0) NULL DEFAULT NULL,
  `manager_id` int(0) NULL DEFAULT NULL COMMENT '管理员ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_building_tb_user_user_id_fk`(`manager_id`) USING BTREE,
  CONSTRAINT `tb_building_tb_user_user_id_fk` FOREIGN KEY (`manager_id`) REFERENCES `tb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_building
-- ----------------------------
INSERT INTO `tb_building` VALUES (1, '英华一', 13, 20, 4, 1, 1200, 11110008);
INSERT INTO `tb_building` VALUES (2, '英华二', 12, 20, 4, 0, 1200, 11110001);
INSERT INTO `tb_building` VALUES (3, '英华三', 10, 11, 4, 1, 1200, 11110007);
INSERT INTO `tb_building` VALUES (4, '英华四', 7, 10, 6, 0, 1000, 11110003);

-- ----------------------------
-- Table structure for tb_exchange
-- ----------------------------
DROP TABLE IF EXISTS `tb_exchange`;
CREATE TABLE `tb_exchange`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `stu_id` int(0) NOT NULL,
  `ex_reason` varchar(140) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ex_intention` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ex_date` datetime(0) NOT NULL,
  `ex_status` int(0) NOT NULL COMMENT '调换状态：审核中=0，通过=1，未通过=2',
  `app_type` int(0) NOT NULL COMMENT '申请类别：调换=0，退寝=1',
  `re_back` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核反馈',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ex_stu_FK`(`stu_id`) USING BTREE,
  CONSTRAINT `ex_stu_FK` FOREIGN KEY (`stu_id`) REFERENCES `tb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_exchange
-- ----------------------------
INSERT INTO `tb_exchange` VALUES (1, 20250101, '楼层太低，阳光被挡', '希望换到8楼以上', '2021-12-23 11:42:12', 0, 0, NULL);

-- ----------------------------
-- Table structure for tb_intention
-- ----------------------------
DROP TABLE IF EXISTS `tb_intention`;
CREATE TABLE `tb_intention`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `stu_id` int(0) NOT NULL COMMENT '学号',
  `room_id` int(0) NOT NULL COMMENT '自选宿舍号',
  `inte_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '自选意向',
  `inte_date` datetime(0) NOT NULL COMMENT '申请时间',
  `inte_status` int(0) NOT NULL COMMENT '申请状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '意向信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_intention
-- ----------------------------
INSERT INTO `tb_intention` VALUES (1, 20250101, 1517, '不吵', '2021-12-23 11:29:14', 1);
INSERT INTO `tb_intention` VALUES (3, 20250102, 2111, '想要一个喜欢看电影的舍友', '2021-12-28 18:26:28', 0);

-- ----------------------------
-- Table structure for tb_menu
-- ----------------------------
DROP TABLE IF EXISTS `tb_menu`;
CREATE TABLE `tb_menu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  `href` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '链接',
  `new_student` int(0) NULL DEFAULT NULL COMMENT '新生菜单：不是新生=0，是新生=1',
  `user_type` int(0) NULL DEFAULT NULL COMMENT '菜单类型：学生=0，宿管=1，后勤=2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1242 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '功能菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_menu
-- ----------------------------
INSERT INTO `tb_menu` VALUES (1011, '个人信息', NULL, 'student/info.html', 1, 0);
INSERT INTO `tb_menu` VALUES (1021, '通知公告', NULL, 'notificationstu/list.html', 0, 0);
INSERT INTO `tb_menu` VALUES (1031, '调换申请', NULL, 'exchangestu/list.html', 0, 0);
INSERT INTO `tb_menu` VALUES (1032, '维修申请', NULL, 'repairstu/list.html', 0, 0);
INSERT INTO `tb_menu` VALUES (1033, '自选宿舍', NULL, 'intentionstu/list.html', 1, 0);
INSERT INTO `tb_menu` VALUES (1111, '通知发布', NULL, 'notification/list.html', 0, 1);
INSERT INTO `tb_menu` VALUES (1121, '维修处理', NULL, 'repair/list.html', 0, 1);
INSERT INTO `tb_menu` VALUES (1211, '用户管理', NULL, 'user/list.html', 0, 2);
INSERT INTO `tb_menu` VALUES (1221, '楼宇管理', NULL, 'building/list.html', 0, 2);
INSERT INTO `tb_menu` VALUES (1222, '房间管理', NULL, 'room/list.html', 0, 2);
INSERT INTO `tb_menu` VALUES (1231, '调换审核', NULL, 'exchange/list.html', 0, 2);
INSERT INTO `tb_menu` VALUES (1241, '宿舍分配', NULL, 'intention/list.html', 0, 2);

-- ----------------------------
-- Table structure for tb_notification
-- ----------------------------
DROP TABLE IF EXISTS `tb_notification`;
CREATE TABLE `tb_notification`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL,
  `noti_head` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `noti_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `noti_range` int(0) NULL DEFAULT NULL,
  `noti_type` int(0) NULL DEFAULT NULL,
  `noti_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_notification
-- ----------------------------
INSERT INTO `tb_notification` VALUES (1, 10000008, '查寝', '12月25日下午三点到五点检查5楼到6楼的宿舍卫生情况', 1, 1, '2021-12-23 11:24:57');
INSERT INTO `tb_notification` VALUES (2, 10000008, '明天降雪', '明天记得多穿衣服', 1, 0, '2021-12-23 11:25:51');
INSERT INTO `tb_notification` VALUES (3, 10000003, '失物招领', '在宿舍楼门口遗失了一个蓝色水瓶', 2, 0, '2021-12-23 11:27:45');
INSERT INTO `tb_notification` VALUES (4, 10000003, '供暖', '从明天起开始供暖', 2, 1, '2021-12-23 11:28:23');

-- ----------------------------
-- Table structure for tb_repair
-- ----------------------------
DROP TABLE IF EXISTS `tb_repair`;
CREATE TABLE `tb_repair`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `stu_id` int(0) NULL DEFAULT NULL,
  `rep_item` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `rep_date` datetime(0) NULL DEFAULT NULL,
  `rep_status` int(0) NOT NULL COMMENT '维修状态',
  `rep_man` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_repair
-- ----------------------------
INSERT INTO `tb_repair` VALUES (1, 20250101, '衣柜柜门', '锁不上', '2021-12-23 11:38:04', 0, NULL);

-- ----------------------------
-- Table structure for tb_room
-- ----------------------------
DROP TABLE IF EXISTS `tb_room`;
CREATE TABLE `tb_room`  (
  `id` int(0) NOT NULL,
  `building_id` int(0) NULL DEFAULT NULL,
  `room_brand` int(0) NULL DEFAULT NULL,
  `room_floor` int(0) NULL DEFAULT NULL,
  `room_capacity` int(0) NULL DEFAULT NULL COMMENT '房间容量：无人间=0；一人间=1；二人间=2；四人间=4；六人间=6',
  `free_capacity` int(0) NULL DEFAULT NULL COMMENT '房间状态：空床位数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_room_tb_building_id_fk`(`building_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_room
-- ----------------------------
INSERT INTO `tb_room` VALUES (0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tb_room` VALUES (1101, 1, 101, 1, 4, 3);
INSERT INTO `tb_room` VALUES (1102, 1, 102, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1103, 1, 103, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1104, 1, 104, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1105, 1, 105, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1106, 1, 106, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1107, 1, 107, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1108, 1, 108, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1109, 1, 109, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1110, 1, 110, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1111, 1, 111, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1112, 1, 112, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1113, 1, 113, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1114, 1, 114, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1115, 1, 115, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1116, 1, 116, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1117, 1, 117, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1118, 1, 118, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1119, 1, 119, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1120, 1, 120, 1, 4, 4);
INSERT INTO `tb_room` VALUES (1201, 1, 201, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1202, 1, 202, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1203, 1, 203, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1204, 1, 204, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1205, 1, 205, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1206, 1, 206, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1207, 1, 207, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1208, 1, 208, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1209, 1, 209, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1210, 1, 210, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1211, 1, 211, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1212, 1, 212, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1213, 1, 213, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1214, 1, 214, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1215, 1, 215, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1216, 1, 216, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1217, 1, 217, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1218, 1, 218, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1219, 1, 219, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1220, 1, 220, 2, 4, 4);
INSERT INTO `tb_room` VALUES (1301, 1, 301, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1302, 1, 302, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1303, 1, 303, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1304, 1, 304, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1305, 1, 305, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1306, 1, 306, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1307, 1, 307, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1308, 1, 308, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1309, 1, 309, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1310, 1, 310, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1311, 1, 311, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1312, 1, 312, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1313, 1, 313, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1314, 1, 314, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1315, 1, 315, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1316, 1, 316, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1317, 1, 317, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1318, 1, 318, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1319, 1, 319, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1320, 1, 320, 3, 4, 4);
INSERT INTO `tb_room` VALUES (1401, 1, 401, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1402, 1, 402, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1403, 1, 403, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1404, 1, 404, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1405, 1, 405, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1406, 1, 406, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1407, 1, 407, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1408, 1, 408, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1409, 1, 409, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1410, 1, 410, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1411, 1, 411, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1412, 1, 412, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1413, 1, 413, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1414, 1, 414, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1415, 1, 415, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1416, 1, 416, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1417, 1, 417, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1418, 1, 418, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1419, 1, 419, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1420, 1, 420, 4, 4, 4);
INSERT INTO `tb_room` VALUES (1501, 1, 501, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1502, 1, 502, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1503, 1, 503, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1504, 1, 504, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1505, 1, 505, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1506, 1, 506, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1507, 1, 507, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1508, 1, 508, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1509, 1, 509, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1510, 1, 510, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1511, 1, 511, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1512, 1, 512, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1513, 1, 513, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1514, 1, 514, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1515, 1, 515, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1516, 1, 516, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1517, 1, 517, 5, 4, 3);
INSERT INTO `tb_room` VALUES (1518, 1, 518, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1519, 1, 519, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1520, 1, 520, 5, 4, 4);
INSERT INTO `tb_room` VALUES (1601, 1, 601, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1602, 1, 602, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1603, 1, 603, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1604, 1, 604, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1605, 1, 605, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1606, 1, 606, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1607, 1, 607, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1608, 1, 608, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1609, 1, 609, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1610, 1, 610, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1611, 1, 611, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1612, 1, 612, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1613, 1, 613, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1614, 1, 614, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1615, 1, 615, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1616, 1, 616, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1617, 1, 617, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1618, 1, 618, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1619, 1, 619, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1620, 1, 620, 6, 4, 4);
INSERT INTO `tb_room` VALUES (1701, 1, 701, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1702, 1, 702, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1703, 1, 703, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1704, 1, 704, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1705, 1, 705, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1706, 1, 706, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1707, 1, 707, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1708, 1, 708, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1709, 1, 709, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1710, 1, 710, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1711, 1, 711, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1712, 1, 712, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1713, 1, 713, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1714, 1, 714, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1715, 1, 715, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1716, 1, 716, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1717, 1, 717, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1718, 1, 718, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1719, 1, 719, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1720, 1, 720, 7, 4, 4);
INSERT INTO `tb_room` VALUES (1801, 1, 801, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1802, 1, 802, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1803, 1, 803, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1804, 1, 804, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1805, 1, 805, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1806, 1, 806, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1807, 1, 807, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1808, 1, 808, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1809, 1, 809, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1810, 1, 810, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1811, 1, 811, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1812, 1, 812, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1813, 1, 813, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1814, 1, 814, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1815, 1, 815, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1816, 1, 816, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1817, 1, 817, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1818, 1, 818, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1819, 1, 819, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1820, 1, 820, 8, 4, 4);
INSERT INTO `tb_room` VALUES (1901, 1, 901, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1902, 1, 902, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1903, 1, 903, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1904, 1, 904, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1905, 1, 905, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1906, 1, 906, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1907, 1, 907, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1908, 1, 908, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1909, 1, 909, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1910, 1, 910, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1911, 1, 911, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1912, 1, 912, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1913, 1, 913, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1914, 1, 914, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1915, 1, 915, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1916, 1, 916, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1917, 1, 917, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1918, 1, 918, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1919, 1, 919, 9, 4, 4);
INSERT INTO `tb_room` VALUES (1920, 1, 920, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2101, 2, 101, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2102, 2, 102, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2103, 2, 103, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2104, 2, 104, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2105, 2, 105, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2106, 2, 106, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2107, 2, 107, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2108, 2, 108, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2109, 2, 109, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2110, 2, 110, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2111, 2, 111, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2112, 2, 112, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2113, 2, 113, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2114, 2, 114, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2115, 2, 115, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2116, 2, 116, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2117, 2, 117, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2118, 2, 118, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2119, 2, 119, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2120, 2, 120, 1, 4, 4);
INSERT INTO `tb_room` VALUES (2201, 2, 201, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2202, 2, 202, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2203, 2, 203, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2204, 2, 204, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2205, 2, 205, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2206, 2, 206, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2207, 2, 207, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2208, 2, 208, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2209, 2, 209, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2210, 2, 210, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2211, 2, 211, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2212, 2, 212, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2213, 2, 213, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2214, 2, 214, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2215, 2, 215, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2216, 2, 216, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2217, 2, 217, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2218, 2, 218, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2219, 2, 219, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2220, 2, 220, 2, 4, 4);
INSERT INTO `tb_room` VALUES (2301, 2, 301, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2302, 2, 302, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2303, 2, 303, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2304, 2, 304, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2305, 2, 305, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2306, 2, 306, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2307, 2, 307, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2308, 2, 308, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2309, 2, 309, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2310, 2, 310, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2311, 2, 311, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2312, 2, 312, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2313, 2, 313, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2314, 2, 314, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2315, 2, 315, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2316, 2, 316, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2317, 2, 317, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2318, 2, 318, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2319, 2, 319, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2320, 2, 320, 3, 4, 4);
INSERT INTO `tb_room` VALUES (2401, 2, 401, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2402, 2, 402, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2403, 2, 403, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2404, 2, 404, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2405, 2, 405, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2406, 2, 406, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2407, 2, 407, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2408, 2, 408, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2409, 2, 409, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2410, 2, 410, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2411, 2, 411, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2412, 2, 412, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2413, 2, 413, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2414, 2, 414, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2415, 2, 415, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2416, 2, 416, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2417, 2, 417, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2418, 2, 418, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2419, 2, 419, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2420, 2, 420, 4, 4, 4);
INSERT INTO `tb_room` VALUES (2501, 2, 501, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2502, 2, 502, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2503, 2, 503, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2504, 2, 504, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2505, 2, 505, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2506, 2, 506, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2507, 2, 507, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2508, 2, 508, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2509, 2, 509, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2510, 2, 510, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2511, 2, 511, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2512, 2, 512, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2513, 2, 513, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2514, 2, 514, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2515, 2, 515, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2516, 2, 516, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2517, 2, 517, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2518, 2, 518, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2519, 2, 519, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2520, 2, 520, 5, 4, 4);
INSERT INTO `tb_room` VALUES (2601, 2, 601, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2602, 2, 602, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2603, 2, 603, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2604, 2, 604, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2605, 2, 605, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2606, 2, 606, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2607, 2, 607, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2608, 2, 608, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2609, 2, 609, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2610, 2, 610, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2611, 2, 611, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2612, 2, 612, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2613, 2, 613, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2614, 2, 614, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2615, 2, 615, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2616, 2, 616, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2617, 2, 617, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2618, 2, 618, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2619, 2, 619, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2620, 2, 620, 6, 4, 4);
INSERT INTO `tb_room` VALUES (2701, 2, 701, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2702, 2, 702, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2703, 2, 703, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2704, 2, 704, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2705, 2, 705, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2706, 2, 706, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2707, 2, 707, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2708, 2, 708, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2709, 2, 709, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2710, 2, 710, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2711, 2, 711, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2712, 2, 712, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2713, 2, 713, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2714, 2, 714, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2715, 2, 715, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2716, 2, 716, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2717, 2, 717, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2718, 2, 718, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2719, 2, 719, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2720, 2, 720, 7, 4, 4);
INSERT INTO `tb_room` VALUES (2801, 2, 801, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2802, 2, 802, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2803, 2, 803, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2804, 2, 804, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2805, 2, 805, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2806, 2, 806, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2807, 2, 807, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2808, 2, 808, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2809, 2, 809, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2810, 2, 810, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2811, 2, 811, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2812, 2, 812, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2813, 2, 813, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2814, 2, 814, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2815, 2, 815, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2816, 2, 816, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2817, 2, 817, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2818, 2, 818, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2819, 2, 819, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2820, 2, 820, 8, 4, 4);
INSERT INTO `tb_room` VALUES (2901, 2, 901, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2902, 2, 902, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2903, 2, 903, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2904, 2, 904, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2905, 2, 905, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2906, 2, 906, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2907, 2, 907, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2908, 2, 908, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2909, 2, 909, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2910, 2, 910, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2911, 2, 911, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2912, 2, 912, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2913, 2, 913, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2914, 2, 914, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2915, 2, 915, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2916, 2, 916, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2917, 2, 917, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2918, 2, 918, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2919, 2, 919, 9, 4, 4);
INSERT INTO `tb_room` VALUES (2920, 2, 920, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3101, 3, 101, 1, 4, 3);
INSERT INTO `tb_room` VALUES (3102, 3, 102, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3103, 3, 103, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3104, 3, 104, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3105, 3, 105, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3106, 3, 106, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3107, 3, 107, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3108, 3, 108, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3109, 3, 109, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3110, 3, 110, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3111, 3, 111, 1, 4, 4);
INSERT INTO `tb_room` VALUES (3201, 3, 201, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3202, 3, 202, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3203, 3, 203, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3204, 3, 204, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3205, 3, 205, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3206, 3, 206, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3207, 3, 207, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3208, 3, 208, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3209, 3, 209, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3210, 3, 210, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3211, 3, 211, 2, 4, 4);
INSERT INTO `tb_room` VALUES (3301, 3, 301, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3302, 3, 302, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3303, 3, 303, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3304, 3, 304, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3305, 3, 305, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3306, 3, 306, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3307, 3, 307, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3308, 3, 308, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3309, 3, 309, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3310, 3, 310, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3311, 3, 311, 3, 4, 4);
INSERT INTO `tb_room` VALUES (3401, 3, 401, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3402, 3, 402, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3403, 3, 403, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3404, 3, 404, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3405, 3, 405, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3406, 3, 406, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3407, 3, 407, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3408, 3, 408, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3409, 3, 409, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3410, 3, 410, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3411, 3, 411, 4, 4, 4);
INSERT INTO `tb_room` VALUES (3501, 3, 501, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3502, 3, 502, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3503, 3, 503, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3504, 3, 504, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3505, 3, 505, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3506, 3, 506, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3507, 3, 507, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3508, 3, 508, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3509, 3, 509, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3510, 3, 510, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3511, 3, 511, 5, 4, 4);
INSERT INTO `tb_room` VALUES (3601, 3, 601, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3602, 3, 602, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3603, 3, 603, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3604, 3, 604, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3605, 3, 605, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3606, 3, 606, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3607, 3, 607, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3608, 3, 608, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3609, 3, 609, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3610, 3, 610, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3611, 3, 611, 6, 4, 4);
INSERT INTO `tb_room` VALUES (3701, 3, 701, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3702, 3, 702, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3703, 3, 703, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3704, 3, 704, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3705, 3, 705, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3706, 3, 706, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3707, 3, 707, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3708, 3, 708, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3709, 3, 709, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3710, 3, 710, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3711, 3, 711, 7, 4, 4);
INSERT INTO `tb_room` VALUES (3801, 3, 801, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3802, 3, 802, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3803, 3, 803, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3804, 3, 804, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3805, 3, 805, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3806, 3, 806, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3807, 3, 807, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3808, 3, 808, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3809, 3, 809, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3810, 3, 810, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3811, 3, 811, 8, 4, 4);
INSERT INTO `tb_room` VALUES (3901, 3, 901, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3902, 3, 902, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3903, 3, 903, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3904, 3, 904, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3905, 3, 905, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3906, 3, 906, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3907, 3, 907, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3908, 3, 908, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3909, 3, 909, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3910, 3, 910, 9, 4, 4);
INSERT INTO `tb_room` VALUES (3911, 3, 911, 9, 4, 4);
INSERT INTO `tb_room` VALUES (4101, 4, 101, 1, 6, 5);
INSERT INTO `tb_room` VALUES (4102, 4, 102, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4103, 4, 103, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4104, 4, 104, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4105, 4, 105, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4106, 4, 106, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4107, 4, 107, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4108, 4, 108, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4109, 4, 109, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4110, 4, 110, 1, 6, 6);
INSERT INTO `tb_room` VALUES (4201, 4, 201, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4202, 4, 202, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4203, 4, 203, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4204, 4, 204, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4205, 4, 205, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4206, 4, 206, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4207, 4, 207, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4208, 4, 208, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4209, 4, 209, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4210, 4, 210, 2, 6, 6);
INSERT INTO `tb_room` VALUES (4301, 4, 301, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4302, 4, 302, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4303, 4, 303, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4304, 4, 304, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4305, 4, 305, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4306, 4, 306, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4307, 4, 307, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4308, 4, 308, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4309, 4, 309, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4310, 4, 310, 3, 6, 6);
INSERT INTO `tb_room` VALUES (4401, 4, 401, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4402, 4, 402, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4403, 4, 403, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4404, 4, 404, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4405, 4, 405, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4406, 4, 406, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4407, 4, 407, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4408, 4, 408, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4409, 4, 409, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4410, 4, 410, 4, 6, 6);
INSERT INTO `tb_room` VALUES (4501, 4, 501, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4502, 4, 502, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4503, 4, 503, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4504, 4, 504, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4505, 4, 505, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4506, 4, 506, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4507, 4, 507, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4508, 4, 508, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4509, 4, 509, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4510, 4, 510, 5, 6, 6);
INSERT INTO `tb_room` VALUES (4601, 4, 601, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4602, 4, 602, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4603, 4, 603, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4604, 4, 604, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4605, 4, 605, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4606, 4, 606, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4607, 4, 607, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4608, 4, 608, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4609, 4, 609, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4610, 4, 610, 6, 6, 6);
INSERT INTO `tb_room` VALUES (4701, 4, 701, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4702, 4, 702, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4703, 4, 703, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4704, 4, 704, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4705, 4, 705, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4706, 4, 706, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4707, 4, 707, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4708, 4, 708, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4709, 4, 709, 7, 6, 6);
INSERT INTO `tb_room` VALUES (4710, 4, 710, 7, 6, 6);
INSERT INTO `tb_room` VALUES (11001, 1, 1001, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11002, 1, 1002, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11003, 1, 1003, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11004, 1, 1004, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11005, 1, 1005, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11006, 1, 1006, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11007, 1, 1007, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11008, 1, 1008, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11009, 1, 1009, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11010, 1, 1010, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11011, 1, 1011, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11012, 1, 1012, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11013, 1, 1013, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11014, 1, 1014, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11015, 1, 1015, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11016, 1, 1016, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11017, 1, 1017, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11018, 1, 1018, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11019, 1, 1019, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11020, 1, 1020, 10, 4, 4);
INSERT INTO `tb_room` VALUES (11101, 1, 1101, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11102, 1, 1102, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11103, 1, 1103, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11104, 1, 1104, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11105, 1, 1105, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11106, 1, 1106, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11107, 1, 1107, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11108, 1, 1108, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11109, 1, 1109, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11110, 1, 1110, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11111, 1, 1111, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11112, 1, 1112, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11113, 1, 1113, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11114, 1, 1114, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11115, 1, 1115, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11116, 1, 1116, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11117, 1, 1117, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11118, 1, 1118, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11119, 1, 1119, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11120, 1, 1120, 11, 4, 4);
INSERT INTO `tb_room` VALUES (11201, 1, 1201, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11202, 1, 1202, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11203, 1, 1203, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11204, 1, 1204, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11205, 1, 1205, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11206, 1, 1206, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11207, 1, 1207, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11208, 1, 1208, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11209, 1, 1209, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11210, 1, 1210, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11211, 1, 1211, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11212, 1, 1212, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11213, 1, 1213, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11214, 1, 1214, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11215, 1, 1215, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11216, 1, 1216, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11217, 1, 1217, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11218, 1, 1218, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11219, 1, 1219, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11220, 1, 1220, 12, 4, 4);
INSERT INTO `tb_room` VALUES (11301, 1, 1301, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11302, 1, 1302, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11303, 1, 1303, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11304, 1, 1304, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11305, 1, 1305, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11306, 1, 1306, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11307, 1, 1307, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11308, 1, 1308, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11309, 1, 1309, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11310, 1, 1310, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11311, 1, 1311, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11312, 1, 1312, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11313, 1, 1313, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11314, 1, 1314, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11315, 1, 1315, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11316, 1, 1316, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11317, 1, 1317, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11318, 1, 1318, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11319, 1, 1319, 13, 4, 4);
INSERT INTO `tb_room` VALUES (11320, 1, 1320, 13, 4, 4);
INSERT INTO `tb_room` VALUES (21001, 2, 1001, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21002, 2, 1002, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21003, 2, 1003, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21004, 2, 1004, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21005, 2, 1005, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21006, 2, 1006, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21007, 2, 1007, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21008, 2, 1008, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21009, 2, 1009, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21010, 2, 1010, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21011, 2, 1011, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21012, 2, 1012, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21013, 2, 1013, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21014, 2, 1014, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21015, 2, 1015, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21016, 2, 1016, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21017, 2, 1017, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21018, 2, 1018, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21019, 2, 1019, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21020, 2, 1020, 10, 4, 4);
INSERT INTO `tb_room` VALUES (21101, 2, 1101, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21102, 2, 1102, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21103, 2, 1103, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21104, 2, 1104, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21105, 2, 1105, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21106, 2, 1106, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21107, 2, 1107, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21108, 2, 1108, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21109, 2, 1109, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21110, 2, 1110, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21111, 2, 1111, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21112, 2, 1112, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21113, 2, 1113, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21114, 2, 1114, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21115, 2, 1115, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21116, 2, 1116, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21117, 2, 1117, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21118, 2, 1118, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21119, 2, 1119, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21120, 2, 1120, 11, 4, 4);
INSERT INTO `tb_room` VALUES (21201, 2, 1201, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21202, 2, 1202, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21203, 2, 1203, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21204, 2, 1204, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21205, 2, 1205, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21206, 2, 1206, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21207, 2, 1207, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21208, 2, 1208, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21209, 2, 1209, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21210, 2, 1210, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21211, 2, 1211, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21212, 2, 1212, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21213, 2, 1213, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21214, 2, 1214, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21215, 2, 1215, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21216, 2, 1216, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21217, 2, 1217, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21218, 2, 1218, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21219, 2, 1219, 12, 4, 4);
INSERT INTO `tb_room` VALUES (21220, 2, 1220, 12, 4, 4);
INSERT INTO `tb_room` VALUES (31001, 3, 1001, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31002, 3, 1002, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31003, 3, 1003, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31004, 3, 1004, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31005, 3, 1005, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31006, 3, 1006, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31007, 3, 1007, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31008, 3, 1008, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31009, 3, 1009, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31010, 3, 1010, 10, 4, 4);
INSERT INTO `tb_room` VALUES (31011, 3, 1011, 10, 4, 4);

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_pwd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_gender` int(0) NOT NULL COMMENT '用户性别：女=0；男=1',
  `user_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `room_id` int(0) NULL DEFAULT NULL,
  `user_type` int(0) NOT NULL COMMENT '角色类型：学生=0；宿舍管理员=1；后勤中心=2',
  `verify_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '忘记密码的邮箱验证码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1100000002 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (10000000, 'Admin', '123456', 1, 'admin@dormitory.cn', NULL, 2, NULL);
INSERT INTO `tb_user` VALUES (11110001, '王阿姨', '123456', 0, 'wang2001@dlmu.com', 2101, 1, NULL);
INSERT INTO `tb_user` VALUES (11110003, '宋阿姨', '123456', 0, 'song2003@dorman.com', 4101, 1, NULL);
INSERT INTO `tb_user` VALUES (11110007, '张大爷', '123456', 1, 'silk@onedrive.com', 3101, 1, NULL);
INSERT INTO `tb_user` VALUES (11110008, '杨大爷', '123456', 1, 'yang2003@dorman.com', 1101, 1, NULL);
INSERT INTO `tb_user` VALUES (20250101, 'test', '123456', 1, '2701713137@qq.com', 1517, 0, '649006');
INSERT INTO `tb_user` VALUES (20250102, 'test2', '123456', 0, '1727049244@qq.com', NULL, 0, '897419');
INSERT INTO `tb_user` VALUES (20250103, 'test3', '123456', 1, NULL, NULL, 0, NULL);
INSERT INTO `tb_user` VALUES (20250104, 'test4', '123456', 0, NULL, NULL, 0, NULL);
INSERT INTO `tb_user` VALUES (33330001, '张维修', '123456', 1, 'xiaomingxxm@vip.qq.com', NULL, 3, NULL);

SET FOREIGN_KEY_CHECKS = 1;
