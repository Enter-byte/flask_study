/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : study11

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 25/04/2020 09:28:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for imd_book
-- ----------------------------
DROP TABLE IF EXISTS `imd_book`;
CREATE TABLE `imd_book`  (
  `isbn` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `publish_date` datetime NULL DEFAULT NULL,
  `author` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `publisher` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `book_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '图书编号',
  PRIMARY KEY (`book_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 132 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of imd_book
-- ----------------------------
INSERT INTO `imd_book` VALUES ('123XXX123', '2006-03-02 00:00:00', '桂学文', '科学出版社', '信息经济学', 1);
INSERT INTO `imd_book` VALUES ('122XXX122', '2006-02-03 00:00:00', '李四', '科学出版社', 'python从基础到精通', 2);
INSERT INTO `imd_book` VALUES ('133XXX133', '2006-04-03 00:00:00', '张三', '科学出版社', 'python网络爬虫实战', 3);
INSERT INTO `imd_book` VALUES ('144XXX144', '2006-03-01 00:00:00', '王五', '科学出版社', 'C语言', 4);
INSERT INTO `imd_book` VALUES ('124XXX124', '2006-01-02 00:00:00', '赵六', '科学出版社', 'Java', 5);
INSERT INTO `imd_book` VALUES ('124XXX125', '2006-02-01 00:00:00', '王七', '电力出版社', 'flask', 6);
INSERT INTO `imd_book` VALUES ('124XXX126', '2006-05-02 00:00:00', '三七', '科学出版社', '数据结构', 7);
INSERT INTO `imd_book` VALUES ('124XXX127', '2006-05-02 00:00:00', '灭霸', '电力出版社', 'react', 8);
INSERT INTO `imd_book` VALUES ('124XXX128', '2006-06-05 00:00:00', '托纳斯', '科学出版社', 'CSS', 9);
INSERT INTO `imd_book` VALUES ('124XXX129', '2006-06-05 00:00:00', '荷兰弟', '科学出版社', '大国大城', 10);
INSERT INTO `imd_book` VALUES ('123455', '2001-03-02 00:00:00', '王八', '科学出版社', 'shadowsocks', 11);
INSERT INTO `imd_book` VALUES ('1234552', '2000-03-02 00:00:00', '汪洋', '科学出版社', '明解C语言', 12);
INSERT INTO `imd_book` VALUES ('12345522', '2000-03-21 00:00:00', '汪洋', '电力出版社', 'keras', 13);
INSERT INTO `imd_book` VALUES ('123455223', '2001-03-23 00:00:00', '汪洋', '电力出版社', '明解C语言2', 14);

-- ----------------------------
-- Table structure for imd_comment
-- ----------------------------
DROP TABLE IF EXISTS `imd_comment`;
CREATE TABLE `imd_comment`  (
  `is_show` char(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `comment_date` datetime NULL DEFAULT NULL,
  `content` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `comment_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `copy_id` varchar(11) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `score` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of imd_comment
-- ----------------------------
INSERT INTO `imd_comment` VALUES ('显示', '2019-07-02 00:00:00', '好', 111, 1, 'a1', '99');
INSERT INTO `imd_comment` VALUES ('显示', '2019-07-03 00:00:00', '好', 112, 2, 'a2', '98');
INSERT INTO `imd_comment` VALUES ('显示', '2019-07-04 00:00:00', '好', 113, 3, 'a3', '88');
INSERT INTO `imd_comment` VALUES ('显示', '2019-07-05 00:00:00', '还行', 114, 4, 'b2', '90');
INSERT INTO `imd_comment` VALUES ('不显示', '2019-07-06 00:00:00', '不好', 115, 5, 'b3', '78');
INSERT INTO `imd_comment` VALUES ('显示', '2019-07-07 00:00:00', '还行', 116, 6, 'c3', '88');
INSERT INTO `imd_comment` VALUES ('显示', '2019-07-08 00:00:00', '好', 117, 7, 'd4', '89');
INSERT INTO `imd_comment` VALUES ('不显示', '2019-07-09 00:00:00', '不好', 118, 8, 'e3', '88');
INSERT INTO `imd_comment` VALUES ('显示', '2019-07-10 00:00:00', '好', 119, 9, 'f3', '99');
INSERT INTO `imd_comment` VALUES ('显示', '2019-07-11 00:00:00', '还行', 120, 10, 'g2', '90');

-- ----------------------------
-- Table structure for imd_copybook
-- ----------------------------
DROP TABLE IF EXISTS `imd_copybook`;
CREATE TABLE `imd_copybook`  (
  `place` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `status` int(20) NULL DEFAULT NULL,
  `is_borrow` int(20) NULL DEFAULT NULL,
  `book_id` int(20) NULL DEFAULT NULL,
  `copybookid` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`copybookid`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of imd_copybook
-- ----------------------------
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 1, 'a2');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 1, 1, 1, 'a3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 1, 'a4');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 1, 1, 1, 'a5');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 0, 1, 'a6');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 1, 0, 1, 'a7');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 1, 'a8');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 1, 1, 2, 'b1');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 0, 0, 2, 'b12');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 1, 1, 2, 'b3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 2, 'b4');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 1, 1, 2, 'b2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 2, 'b6');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 3, 'c1');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 3, 'c2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 3, 'c3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 3, 'c4');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 3, 'c5');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 3, 'c6');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 3, 'c7');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 4, 'd1');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 4, 'd2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 4, 'd3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 4, 'd4');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 4, 'd5');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 4, 'd6');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 4, 'd7');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 4, 'd8');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 4, 'd9');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 4, 'd10');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 5, 'e1');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 5, 'e2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 5, 'e3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 5, 'e4');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 5, 'e5');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 5, 'e6');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 6, 'f1');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 6, 'f2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 6, 'f3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 6, 'f4');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 6, 'f5');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 6, 'f6');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 7, 'g1');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 7, 'g2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 7, 'g3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 8, 'h1');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 8, 'h2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 8, 'h3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 8, 'h4');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 8, 'h5');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 9, 'i1');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 9, 'i2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 9, 'i3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 9, 'i4');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 1, 10, 'j1');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 10, 'j2');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 10, 'j3');
INSERT INTO `imd_copybook` VALUES ('图书馆', 0, 0, 10, 'j4');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 2, 'b9');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 0, 0, 2, 'b10');
INSERT INTO `imd_copybook` VALUES ('信管资料室', 1, 0, 2, 'b5');
INSERT INTO `imd_copybook` VALUES ('图书馆', 1, 1, 2, 'b20');

-- ----------------------------
-- Table structure for imd_record
-- ----------------------------
DROP TABLE IF EXISTS `imd_record`;
CREATE TABLE `imd_record`  (
  `copy_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `record_time` datetime NULL DEFAULT NULL,
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `backdate` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of imd_record
-- ----------------------------
INSERT INTO `imd_record` VALUES ('a1', '2019-06-03 00:00:00', 11, 1, '2019-06-03 00:00:00');
INSERT INTO `imd_record` VALUES ('b2', '2019-06-04 00:00:00', 12, 2, '2019-06-04 00:00:00');
INSERT INTO `imd_record` VALUES ('a3', '2019-06-05 00:00:00', 13, 3, '2019-06-05 00:00:00');
INSERT INTO `imd_record` VALUES ('d4', '2019-06-06 00:00:00', 14, 4, '2019-06-06 00:00:00');
INSERT INTO `imd_record` VALUES ('f4', '2019-06-07 00:00:00', 15, 5, '2019-06-07 00:00:00');
INSERT INTO `imd_record` VALUES ('g3', '2019-06-08 00:00:00', 16, 6, '2019-06-08 00:00:00');
INSERT INTO `imd_record` VALUES ('d2', '2019-06-09 00:00:00', 17, 7, '2019-06-09 00:00:00');
INSERT INTO `imd_record` VALUES ('a8', '2019-06-10 00:00:00', 18, 8, '2019-06-10 00:00:00');
INSERT INTO `imd_record` VALUES ('c3', '2019-06-11 00:00:00', 19, 9, '2019-06-11 00:00:00');
INSERT INTO `imd_record` VALUES ('b4', '2019-06-12 00:00:00', 20, 10, '2019-06-12 00:00:00');

-- ----------------------------
-- Table structure for imd_user
-- ----------------------------
DROP TABLE IF EXISTS `imd_user`;
CREATE TABLE `imd_user`  (
  `date` datetime NULL DEFAULT NULL,
  `status` char(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_key` varchar(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_password` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of imd_user
-- ----------------------------
INSERT INTO `imd_user` VALUES ('2018-12-03 00:00:00', '可用', 'XXX', '123456', '张三', 1);
INSERT INTO `imd_user` VALUES ('2018-12-04 00:00:00', '可用', 'XXX', '123457', '王柳', 2);
INSERT INTO `imd_user` VALUES ('2018-12-05 00:00:00', '不可用', 'XXX', '135677', '赵金', 3);
INSERT INTO `imd_user` VALUES ('2018-12-06 00:00:00', '可用', 'XXX', '223454', '王八', 4);
INSERT INTO `imd_user` VALUES ('2018-12-07 00:00:00', '不可用', 'XXX', '253654', '托马斯', 5);
INSERT INTO `imd_user` VALUES ('2018-12-08 00:00:00', '不可用', 'XXX', '454665', '玛卡巴卡', 6);
INSERT INTO `imd_user` VALUES ('2018-12-09 00:00:00', '可用', 'XXX', '432424', '路西迪西', 7);
INSERT INTO `imd_user` VALUES ('2018-12-10 00:00:00', '可用', 'XXX', '442353', '史塔克', 8);
INSERT INTO `imd_user` VALUES ('2018-12-11 00:00:00', '不可用', 'XXX', '546654', '马李建', 9);
INSERT INTO `imd_user` VALUES ('2018-12-12 00:00:00', '可用', 'XXX', '676775', '娜塔莎', 10);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `Sno` int(10) NOT NULL,
  `Sname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Sno`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
