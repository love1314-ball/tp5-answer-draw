/*
Navicat MySQL Data Transfer

Source Server         : 本地MySQL数据库
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : tp5-answer-draw

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-04-24 16:52:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ob_activity
-- ----------------------------
DROP TABLE IF EXISTS `ob_activity`;
CREATE TABLE `ob_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(255) DEFAULT NULL COMMENT '（活动名字）',
  `begin_time` bigint(20) DEFAULT NULL COMMENT '活动开始时间',
  `finish_time` bigint(20) DEFAULT NULL COMMENT '活动结束时间',
  `activity_picture` varchar(255) DEFAULT NULL COMMENT '活动图片介绍',
  `activity_introduce` varchar(255) DEFAULT NULL COMMENT '活动文字介绍',
  `activity_status` varchar(255) DEFAULT '0' COMMENT '状态0为正常/1为过期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='活动表';

-- ----------------------------
-- Records of ob_activity
-- ----------------------------
INSERT INTO `ob_activity` VALUES ('3', '抽手机', '1587484800', '1587744000', '/static/activityimg/20200422/7762a54060caa9454facdcd13a586308.jpg', '苹果手机啊弟弟们', '0');
INSERT INTO `ob_activity` VALUES ('4', '抽电脑', '1587484800', '1587830400', '/static/activityimg/20200422/909f243f478759abf6489ca040dded35.jpg', '简介：计算机（computer）俗称电脑，是现代一种现代化智能电子设备。', '1');
INSERT INTO `ob_activity` VALUES ('5', '抽鞋子', '1587571200', '1588348800', '/static/activityimg/20200423/4679dc1e0c2e5d2ea03ad3401a94a87b.jpg', '答题即可抽鞋子了', '0');

-- ----------------------------
-- Table structure for ob_activity_draw
-- ----------------------------
DROP TABLE IF EXISTS `ob_activity_draw`;
CREATE TABLE `ob_activity_draw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `draw_number` int(11) DEFAULT '1' COMMENT '抽奖次数/默认为1，可抽奖了就插入1',
  `add_time` varchar(80) DEFAULT NULL COMMENT '增加时间，年月日',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动的id',
  `answer_uniqueness` bigint(50) DEFAULT NULL COMMENT '唯一表示（答题表中的）/可能用不到',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='抽奖人员的名单';

-- ----------------------------
-- Records of ob_activity_draw
-- ----------------------------

-- ----------------------------
-- Table structure for ob_activity_rule
-- ----------------------------
DROP TABLE IF EXISTS `ob_activity_rule`;
CREATE TABLE `ob_activity_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_number` int(11) DEFAULT NULL COMMENT '设置抽奖次数',
  `activity_probability` varchar(11) DEFAULT NULL COMMENT '抽奖次数对应的概率',
  `activity_id` int(11) DEFAULT NULL COMMENT '对应活动的id',
  `add_time` bigint(20) DEFAULT NULL COMMENT '增加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='活动抽奖规则表';

-- ----------------------------
-- Records of ob_activity_rule
-- ----------------------------
INSERT INTO `ob_activity_rule` VALUES ('34', '1', '0.5', '3', '1587539786');
INSERT INTO `ob_activity_rule` VALUES ('35', '2', '0.6', '3', '1587539786');
INSERT INTO `ob_activity_rule` VALUES ('36', '3', '0.8', '3', '1587539786');
INSERT INTO `ob_activity_rule` VALUES ('37', '4', '0.9', '3', '1587539786');
INSERT INTO `ob_activity_rule` VALUES ('38', '1', '0.5', '5', '1587709265');
INSERT INTO `ob_activity_rule` VALUES ('39', '2', '0.6', '5', '1587709265');
INSERT INTO `ob_activity_rule` VALUES ('40', '3', '0.8', '5', '1587709265');

-- ----------------------------
-- Table structure for ob_ad
-- ----------------------------
DROP TABLE IF EXISTS `ob_ad`;
CREATE TABLE `ob_ad` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(32) NOT NULL DEFAULT '0' COMMENT '分类',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `url` varchar(255) DEFAULT '' COMMENT '链接',
  `target` varchar(10) DEFAULT '' COMMENT '打开方式',
  `image` varchar(255) DEFAULT '' COMMENT '图片',
  `sort_order` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='广告';

-- ----------------------------
-- Records of ob_ad
-- ----------------------------

-- ----------------------------
-- Table structure for ob_admin
-- ----------------------------
DROP TABLE IF EXISTS `ob_admin`;
CREATE TABLE `ob_admin` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0禁用/1启动',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `last_login_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `login_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员';

-- ----------------------------
-- Records of ob_admin
-- ----------------------------
INSERT INTO `ob_admin` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '1587709211', '127.0.0.1', '29', '0', '1587709211');
INSERT INTO `ob_admin` VALUES ('2', 'demo', 'e10adc3949ba59abbe56e057f20f883e', '1', '1545449154', '127.0.0.1', '2', '1539076102', '1545449154');

-- ----------------------------
-- Table structure for ob_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `ob_admin_log`;
CREATE TABLE `ob_admin_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '管理员id',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `useragent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `ip` varchar(16) NOT NULL DEFAULT '' COMMENT 'ip地址',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '请求链接',
  `method` varchar(32) NOT NULL DEFAULT '' COMMENT '请求类型',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT '资源类型',
  `param` text NOT NULL COMMENT '请求参数',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员日志';

-- ----------------------------
-- Records of ob_admin_log
-- ----------------------------
INSERT INTO `ob_admin_log` VALUES ('1', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '127.0.0.1', 'http://www.openbms.com/admin/database/del/time/1552277088.html', 'POST', 'json', '{\"time\":\"1552277088\"}', '删除了数据', '1552277146');
INSERT INTO `ob_admin_log` VALUES ('2', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-test-ljh.com/admin/article/add.html', 'POST', 'json', '{\"image\":\"\\/upload\\/image\\/20200421\\/775b7de97a833bd79c700f0287b38bec.jpg\",\"cid\":\"1\",\"title\":\"45\",\"author\":\"45545\",\"summary\":\"45242542525425\",\"photo\":[\"\\/upload\\/image\\/20200421\\/d8d19d2b8bec49247e72ac4d77496e67.jpg\"],\"content\":\"<p>4252452454254254<\\/p>\",\"keywords\":\"4254245245245245\",\"description\":\"425425\"}', '添加了文章', '1587431845');
INSERT INTO `ob_admin_log` VALUES ('3', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-test-ljh.com/admin/user/add.html', 'POST', 'json', '{\"username\":\"12121212121212\",\"mobile\":\"15090472762\",\"password\":\"121212\"}', '添加了用户', '1587431872');
INSERT INTO `ob_admin_log` VALUES ('4', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-test-ljh.com/admin/user/add.html', 'POST', 'json', '{\"username\":\"1233456\",\"mobile\":\"15090472768\",\"password\":\"123456\"}', '添加了用户', '1587432876');
INSERT INTO `ob_admin_log` VALUES ('5', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin.html', 'POST', 'json', '{\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"4dkc\"}', '登录了后台系统', '1587448830');
INSERT INTO `ob_admin_log` VALUES ('6', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/config/setting.html', 'POST', 'json', '{\"lejRej\":\"\\/upload\\/image\\/20200421\\/6dee8990e381f7b4b5aa312276212a4c.png\",\"mbk5ez\":\"\\u7b54\\u9898\",\"nel5aK\":\"\\u7b54\\u9898\\u540e\\u53f0\\u7ba1\\u7406\\u7cfb\\u7edf\",\"vbmOeY\":\"\\u7b54\\u9898\\u62bd\\u5956\",\"penRe7\":\"\\u5b66\\u751f\\u4eec\\u8fdb\\u884c\\u7b54\\u9898\\uff0c\\u7b54\\u9898\\u540e\\u53ef\\u8fdb\\u884c\\u62bd\\u5956\",\"xbojag\":\"\",\"mep2bM\":\"\",\"zbq2dp\":\"\"}', '更新基本设置', '1587449008');
INSERT INTO `ob_admin_log` VALUES ('7', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/index/clear.html', 'POST', 'json', '[]', '清除了系统缓存', '1587449014');
INSERT INTO `ob_admin_log` VALUES ('8', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/index/clear.html', 'POST', 'json', '[]', '清除了系统缓存', '1587449103');
INSERT INTO `ob_admin_log` VALUES ('9', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=4', 'POST', 'json', '{\"id\":\"4\",\"name\":\"\\u8bbe\\u7f6e\",\"url\":\"\",\"icon\":\"fa fa-gear\",\"type\":\"auth\",\"index\":\"0\",\"sort_order\":\"5\",\"pid\":\"0\"}', '修改了权限规则', '1587449143');
INSERT INTO `ob_admin_log` VALUES ('10', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=16', 'POST', 'json', '{\"id\":\"16\",\"name\":\"\\u7ba1\\u7406\\u5458\",\"url\":\"admin\\/admin\\/index\",\"icon\":\"fa fa-user\",\"type\":\"auth\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"5\"}', '修改了权限规则', '1587449155');
INSERT INTO `ob_admin_log` VALUES ('11', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=17', 'POST', 'json', '{\"id\":\"17\",\"name\":\"\\u6743\\u9650\\u7ec4\",\"url\":\"admin\\/auth\\/group\",\"icon\":\"fa fa-users\",\"type\":\"auth\",\"index\":\"0\",\"sort_order\":\"1\",\"pid\":\"5\"}', '修改了权限规则', '1587449163');
INSERT INTO `ob_admin_log` VALUES ('12', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=18', 'POST', 'json', '{\"id\":\"18\",\"name\":\"\\u7ba1\\u7406\\u5458\\u65e5\\u5fd7\",\"url\":\"admin\\/admin\\/log\",\"icon\":\"fa fa-clock-o\",\"type\":\"auth\",\"index\":\"0\",\"sort_order\":\"5\",\"pid\":\"5\"}', '修改了权限规则', '1587449170');
INSERT INTO `ob_admin_log` VALUES ('13', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=3', 'POST', 'json', '{\"id\":\"3\",\"name\":\"\\u6269\\u5c55\",\"url\":\"\",\"icon\":\"fa fa-puzzle-piece\",\"type\":\"auth\",\"index\":\"0\",\"sort_order\":\"4\",\"pid\":\"0\"}', '修改了权限规则', '1587449181');
INSERT INTO `ob_admin_log` VALUES ('14', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/delrule.html?id=54', 'POST', 'json', '{\"id\":\"54\"}', '删除了权限规则', '1587451184');
INSERT INTO `ob_admin_log` VALUES ('15', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/delrule.html?id=10', 'POST', 'json', '{\"id\":\"10\"}', '删除了权限规则', '1587451189');
INSERT INTO `ob_admin_log` VALUES ('16', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=2', 'POST', 'json', '{\"id\":\"2\",\"name\":\"\\u7528\\u6237\",\"url\":\"\",\"icon\":\"fa fa-users\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"3\",\"pid\":\"0\"}', '修改了权限规则', '1587451216');
INSERT INTO `ob_admin_log` VALUES ('17', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=9', 'POST', 'json', '{\"id\":\"9\",\"name\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"url\":\"admin\\/user\\/index\",\"icon\":\"fa fa-users\",\"type\":\"nav\",\"index\":\"1\",\"sort_order\":\"0\",\"pid\":\"2\"}', '修改了权限规则', '1587451224');
INSERT INTO `ob_admin_log` VALUES ('18', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=0', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u9898\\u76ee\",\"url\":\"\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"0\"}', '添加了权限规则', '1587462503');
INSERT INTO `ob_admin_log` VALUES ('19', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=0', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u9898\\u76ee\",\"url\":\"admin\\/Topic\\/index\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"0\"}', '添加了权限规则', '1587462634');
INSERT INTO `ob_admin_log` VALUES ('20', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=57', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u589e\\u52a0\\u9898\\u76ee\",\"url\":\"admin\\/Topic\\/add\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"57\"}', '添加了权限规则', '1587465733');
INSERT INTO `ob_admin_log` VALUES ('21', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/article/edit/id/14.html', 'POST', 'json', '{\"sort_order\":\"100\",\"_verify\":\"0\",\"id\":\"14\"}', '修改了文章', '1587466429');
INSERT INTO `ob_admin_log` VALUES ('22', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/article/edit/id/13.html', 'POST', 'json', '{\"sort_order\":\"100\",\"_verify\":\"0\",\"id\":\"13\"}', '修改了文章', '1587466433');
INSERT INTO `ob_admin_log` VALUES ('23', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=58', 'POST', 'json', '{\"id\":\"58\",\"name\":\"\\u589e\\u52a0\\u9898\\u76ee\",\"url\":\"admin\\/Topic\\/edit\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"57\"}', '修改了权限规则', '1587466943');
INSERT INTO `ob_admin_log` VALUES ('24', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=57', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u9898\\u76ee\\u5217\\u8868 \",\"url\":\"admin\\/Topic\\/index\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"57\"}', '添加了权限规则', '1587476292');
INSERT INTO `ob_admin_log` VALUES ('25', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=58', 'POST', 'json', '{\"id\":\"58\",\"name\":\"\\u589e\\u52a0\\u9898\\u76ee\",\"url\":\"admin\\/Topic\\/edit\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"2\",\"pid\":\"57\"}', '修改了权限规则', '1587476315');
INSERT INTO `ob_admin_log` VALUES ('26', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin.html', 'POST', 'json', '{\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"ia6j\"}', '登录了后台系统', '1587515366');
INSERT INTO `ob_admin_log` VALUES ('27', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=57', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u5bfc\\u5165\\u6570\\u636e\",\"url\":\"admin\\/topic\\/lead\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"57\"}', '添加了权限规则', '1587516451');
INSERT INTO `ob_admin_log` VALUES ('28', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=0', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u589e\\u52a0\\u6d3b\\u52a8\",\"url\":\"admin\\/Activity\\/index\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"0\"}', '添加了权限规则', '1587522137');
INSERT INTO `ob_admin_log` VALUES ('29', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=57', 'POST', 'json', '{\"id\":\"57\",\"name\":\"\\u9898\\u76ee\",\"url\":\"admin\\/Topic\\/index\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"1\",\"pid\":\"0\"}', '修改了权限规则', '1587522157');
INSERT INTO `ob_admin_log` VALUES ('30', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=61', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u6d3b\\u52a8\\u7c7b\\u8868\",\"url\":\"admin\\/Activity\\/index\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"61\"}', '添加了权限规则', '1587522184');
INSERT INTO `ob_admin_log` VALUES ('31', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=62', 'POST', 'json', '{\"id\":\"62\",\"name\":\"\\u6d3b\\u52a8\\u5217\\u8868\",\"url\":\"admin\\/Activity\\/index\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"61\"}', '修改了权限规则', '1587522194');
INSERT INTO `ob_admin_log` VALUES ('32', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=61', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u589e\\u52a0\\u6d3b\\u52a8\",\"url\":\"admin\\/Activity\\/add\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"61\"}', '添加了权限规则', '1587522208');
INSERT INTO `ob_admin_log` VALUES ('33', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/editrule.html?id=63', 'POST', 'json', '{\"id\":\"63\",\"name\":\"\\u589e\\u52a0\\u6d3b\\u52a8\",\"url\":\"admin\\/Activity\\/edit\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"61\"}', '修改了权限规则', '1587522659');
INSERT INTO `ob_admin_log` VALUES ('34', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/index/clear.html', 'GET', 'xml', '[]', '清除了系统缓存', '1587526001');
INSERT INTO `ob_admin_log` VALUES ('35', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/index/clear.html', 'GET', 'xml', '[]', '清除了系统缓存', '1587534295');
INSERT INTO `ob_admin_log` VALUES ('36', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/index/logout.html', 'GET', 'xml', '[]', '退出了后台系统', '1587534323');
INSERT INTO `ob_admin_log` VALUES ('37', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin.html', 'POST', 'json', '{\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"78hy\"}', '登录了后台系统', '1587534341');
INSERT INTO `ob_admin_log` VALUES ('38', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/index/clear.html', 'GET', 'xml', '[]', '清除了系统缓存', '1587537382');
INSERT INTO `ob_admin_log` VALUES ('39', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin.html', 'POST', 'json', '{\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"ueur\"}', '登录了后台系统', '1587602891');
INSERT INTO `ob_admin_log` VALUES ('40', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin.html', 'POST', 'json', '{\"username\":\"admin\",\"password\":\"123456\",\"captcha\":\"fv7m\"}', '登录了后台系统', '1587709211');
INSERT INTO `ob_admin_log` VALUES ('41', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=0', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u7b54\\u9898\\u89c4\\u5219\",\"url\":\"admin\\/Answer\\/index\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"0\"}', '添加了权限规则', '1587709317');
INSERT INTO `ob_admin_log` VALUES ('42', '1', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36', '127.0.0.1', 'http://www.tp5-answer-draw.com/admin/auth/addrule.html?id=67', 'POST', 'json', '{\"id\":\"\",\"name\":\"\\u89c4\\u5219\\u5217\\u8868\",\"url\":\"admin\\/Answer\\/index\",\"icon\":\"\",\"type\":\"nav\",\"index\":\"0\",\"sort_order\":\"0\",\"pid\":\"67\"}', '添加了权限规则', '1587709340');

-- ----------------------------
-- Table structure for ob_answer
-- ----------------------------
DROP TABLE IF EXISTS `ob_answer`;
CREATE TABLE `ob_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名字',
  `topic_id` int(11) DEFAULT NULL COMMENT '题的id',
  `choose_id` int(11) DEFAULT NULL COMMENT '用户所选项的id',
  `user_correct` varchar(255) DEFAULT NULL COMMENT '如果正确我就写1，不正确为0或者空',
  `answer_status` int(5) DEFAULT '0' COMMENT '题的状态，看看是否答题了，0为没有/1为已答',
  `answer_whether` int(5) DEFAULT NULL COMMENT '答题是否正确/0为错误/1为正确',
  `add_time` varchar(255) DEFAULT NULL COMMENT '增加的时间',
  `answer_next` int(5) DEFAULT NULL COMMENT '当天-答题的次数',
  `activity_id` int(5) DEFAULT NULL COMMENT '活动的id',
  `answer_uniqueness` bigint(50) DEFAULT NULL COMMENT '生成唯一数方便我们看那次提交的（用于看是否能参加活动）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户答题表';

-- ----------------------------
-- Records of ob_answer
-- ----------------------------
INSERT INTO `ob_answer` VALUES ('1', '2021', 'admin', '121', '0', '0', '0', '0', '2020-04-24', '1', '3', '1587708404');

-- ----------------------------
-- Table structure for ob_answer_number
-- ----------------------------
DROP TABLE IF EXISTS `ob_answer_number`;
CREATE TABLE `ob_answer_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `answer_number` int(11) DEFAULT NULL COMMENT '答题次数',
  `add_time` varchar(50) DEFAULT NULL COMMENT '增加时间/年月日格式',
  `answer_id` int(11) DEFAULT NULL COMMENT '活动id',
  `set_add` int(4) DEFAULT '0' COMMENT '判断你是否给默认条数了/0代表没有/1代表已给',
  `share_add` int(4) DEFAULT '0' COMMENT '判断今天是否分享了/0代表没有/1代表已分享，不给答题机会了',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='每天用户答题记录表';

-- ----------------------------
-- Records of ob_answer_number
-- ----------------------------
INSERT INTO `ob_answer_number` VALUES ('13', '2021', 'admin', '0', '2020-04-24', '3', '1', '1');
INSERT INTO `ob_answer_number` VALUES ('14', '2021', 'admin', '0', '2020-04-24', '5', '1', '1');

-- ----------------------------
-- Table structure for ob_answer_set
-- ----------------------------
DROP TABLE IF EXISTS `ob_answer_set`;
CREATE TABLE `ob_answer_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_number` int(11) DEFAULT NULL COMMENT '设置每天答题的次数',
  `activity_id` int(11) DEFAULT NULL COMMENT '对应的活动ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='答题，规则';

-- ----------------------------
-- Records of ob_answer_set
-- ----------------------------
INSERT INTO `ob_answer_set` VALUES ('1', '1', '0');

-- ----------------------------
-- Table structure for ob_answer_temporary
-- ----------------------------
DROP TABLE IF EXISTS `ob_answer_temporary`;
CREATE TABLE `ob_answer_temporary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ob_answer_temporary
-- ----------------------------

-- ----------------------------
-- Table structure for ob_article
-- ----------------------------
DROP TABLE IF EXISTS `ob_article`;
CREATE TABLE `ob_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `image` varchar(255) DEFAULT '' COMMENT '图片',
  `author` varchar(255) DEFAULT '' COMMENT '作者',
  `summary` text COMMENT '简介',
  `photo` text COMMENT '相册',
  `content` longtext COMMENT '内容',
  `view` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点击量',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否置顶',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `sort_order` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  `keywords` varchar(255) DEFAULT '' COMMENT '关键字',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文章';

-- ----------------------------
-- Records of ob_article
-- ----------------------------
INSERT INTO `ob_article` VALUES ('1', '1', '初识模块化开发工具', '', '', '初识模块化开发工具：git 是分布式代码管理工具，管理代码的npm 是包管理工具，管理插件、工具啊，是个转换器，他是哪来的了，他是伴随node下载下来的，版本也是伴随node变化；node 是个后台的环境；首先安装node，然后用命令安装browserify：npm install -g brows ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840580', '1541840580');
INSERT INTO `ob_article` VALUES ('2', '1', 'window.open方法被浏览器拦截的处理方式', '', '', '问题现象 当我们在一个 ajax 回调中执行 window.open 方法时，新页面会被浏览器拦截。 原因 在 Chrome 的安全机制里，非用户直接触发的 window.open 方法，是会被拦截的。 处理 $(\'#jump-btn\').on(\'click\', function () { // 打 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840601', '1541840601');
INSERT INTO `ob_article` VALUES ('3', '1', '理解JavaScript中的柯里化', '', '', '函数式编程是一种编程风格，这种编程风格就是试图将传递函数作为参数（即将作为回调函数）和返回一个函数，但没有函数副作用（函数副作用即会改变程序的状态）。 有很多语言采用这种编程风格，其中包括JavaScript、Haskell、Clojure、Erlang和Scala等一些很流行的编程语言。 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840625', '1541840625');
INSERT INTO `ob_article` VALUES ('4', '1', '小程序开发框架', '', '', '小程序开发框架，支持百度小程序、微信小程序、支付宝小程序 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840645', '1541840645');
INSERT INTO `ob_article` VALUES ('5', '1', 'JavaScript异步、事件循环与消息队列、微任务与宏任务', '', '', '关于JavaScript异步、事件循环与消息队、微任务与宏任务的总结 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840663', '1541840663');
INSERT INTO `ob_article` VALUES ('6', '1', '关于Array中的srot()方法和compare()方法', '', '', 'Array中的srot()方法 sort()方法是用来重排序的方法。在默认情况下，sort()方法按升序排列数组项 即最小的值位于最前面，最大的值排在最后面。 我们看看官方是怎么说的： arrayObj.srot(sortFunction) 参数 arrayObj 必选项。任意Array对象 sor ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840681', '1541840681');
INSERT INTO `ob_article` VALUES ('7', '1', '使用Arcgis进行画面(线)并计算大小(长度)', '', '', '在使用Arcgis API for JavaScript进行做地图开发的过程中，在地图进行画线、画面是经常使用的功能。本文主要介绍这一功能。 本文适用Arcgis API版本：Arcgis API for JS 4.x以上。 方案分析： 方案分析： 首先要初始化&nbsp;map&nbsp;和&nbsp;mapView（2D m ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840700', '1541840700');
INSERT INTO `ob_article` VALUES ('8', '1', 'sass使用中出现的问题', '', '', '问题一：ruby按照官方文档安装后更换gem源时，报错Error fetching https://gems.ruby-china.org/: bad response Not Found 404 (https://gems.ruby-china.org/specs.4.8.gz)；不知就里，在网上 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840718', '1541840718');
INSERT INTO `ob_article` VALUES ('9', '1', 'xss 跨站脚本攻击', '', '', '攻击原理 XSS（cross-site scripting跨域脚本攻击）攻击是最常见的Web攻击，它允许恶意web用户将代码植入到提供给其它用户使用的页面中。 xss 与其他的攻击方式相比缺点明显，如下： 1、耗时间 2、有一定几率不成功 3、没有相应的软件来完成自动化攻击 4、前期需要基本的htm ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840736', '1541840736');
INSERT INTO `ob_article` VALUES ('10', '2', 'JSON解析', '', '', '以下为网络上搜集的关于JSON的资料，整合为随笔记录，供以后回顾。 百度：https://baike.baidu.com/item/JSON/2462549?fr=aladdin 一. 数据格式 1.数组方式： [ {\"key1\": \"value1\"}, {\"key2\": \"value2\"} ] 2 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840756', '1541840756');
INSERT INTO `ob_article` VALUES ('11', '1', 'visual studio2017 创建Vue项目', '', '', '1:打开Visual studio 2017后 按图片操作新建项目 也可以使用快捷键Ctrl+Shift+N 进入创建项目页面 2:选择JavaScript 里的Node.js创建对应的Vue项目 如果没有javaScript对应的node.js选项 打开最下面的visual studio安装程序  ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840778', '1541840778');
INSERT INTO `ob_article` VALUES ('12', '1', 'javascript  数组 常用方法', '', '', '前言 学学忘忘 闲来做个笔记 整理下数组常用方法。 Array 数组常用方法 创建数组的基本方式有两种 1.第一种是使用Array构造函数， var arr = new Array(); 使用构造函数方式的话&nbsp;var arr = new Array(20),则表示创建了一个lenght值为20的数组 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840793', '1541840793');
INSERT INTO `ob_article` VALUES ('13', '1', '学了两天 react，乱讲一下学习思路，顺便弄了一个脚手架', '', '', '之前一直用 vue 做一些小项目，最近接触了一个项目是用 react 做前端，虽然本身是做后端开发的，但是前端还是要了解一点的。 现在的项目基本上都是前后端分离的，后端就先不提了。前端的框架也是层出不穷，使用最多的就是 angular、vue、react 。angular 是前几年用的比较多，最近好 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840808', '1587466433');
INSERT INTO `ob_article` VALUES ('14', '2', 'PHP 中的CURL 模拟表单的post提交', '', '', '废话不多说啦，直接上代码： 这里需要注意的是： 要想以 x-www-form-urlencoded 方式发送，最关键是发送的数据格式。 方式from-data试发送的数据用的是array格式，而方式为 x-www-form-urlencoded 时需要用key=value&key=value的格式发 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840846', '1587466429');
INSERT INTO `ob_article` VALUES ('15', '2', ' PHP解决跨域问题', '', '', '在做项目的过程中经常需要跨域访问。这里主要介绍一下 PHP 中怎么解决跨域问题。 1、允许所有域名访问 2、允许单个域名访问 3、允许多个域名访问 在实际项目中最好指定能跨域访问的域名，增加安全性。可以写在一个公共类里面，封装一个方法调用。 ...', '', '', '0', '0', '0', '1', '100', '', '', '1541840863', '1541840863');
INSERT INTO `ob_article` VALUES ('16', '1', '接口技术的实现:规范用户类的成员与类型', '', '', '', '', '', '0', '0', '0', '1', '100', '', '', '1541840882', '1546139921');
INSERT INTO `ob_article` VALUES ('17', '1', '45', '/upload/image/20200421/775b7de97a833bd79c700f0287b38bec.jpg', '45545', '45242542525425', 'a:1:{i:0;s:59:\"/upload/image/20200421/d8d19d2b8bec49247e72ac4d77496e67.jpg\";}', '<p>4252452454254254</p>', '0', '0', '0', '1', '100', '4254245245245245', '425425', '1587431845', '1587431845');

-- ----------------------------
-- Table structure for ob_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `ob_auth_group`;
CREATE TABLE `ob_auth_group` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='权限组';

-- ----------------------------
-- Records of ob_auth_group
-- ----------------------------
INSERT INTO `ob_auth_group` VALUES ('1', '超级管理员', '', '1', '1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,55,57,58,59,60,61,62,63');

-- ----------------------------
-- Table structure for ob_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `ob_auth_group_access`;
CREATE TABLE `ob_auth_group_access` (
  `uid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限授权';

-- ----------------------------
-- Records of ob_auth_group_access
-- ----------------------------
INSERT INTO `ob_auth_group_access` VALUES ('1', '1');
INSERT INTO `ob_auth_group_access` VALUES ('2', '1');

-- ----------------------------
-- Table structure for ob_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `ob_auth_rule`;
CREATE TABLE `ob_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `icon` varchar(64) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `type` char(4) NOT NULL DEFAULT '' COMMENT 'nav,auth',
  `index` tinyint(1) NOT NULL DEFAULT '0' COMMENT '快捷导航',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='权限规则';

-- ----------------------------
-- Records of ob_auth_rule
-- ----------------------------
INSERT INTO `ob_auth_rule` VALUES ('1', '0', '文章', '', '', '2', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('2', '0', '用户', '', '', '3', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('3', '0', '扩展', '', '', '4', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('4', '0', '设置', '', '', '5', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('5', '0', '权限', '', '', '6', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('6', '0', '控制台', 'admin/index/index', '', '1', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('7', '1', '分类管理', 'admin/category/index', '', '2', 'nav', '1', '1');
INSERT INTO `ob_auth_rule` VALUES ('8', '1', '文章管理', 'admin/article/index', '', '1', 'nav', '1', '1');
INSERT INTO `ob_auth_rule` VALUES ('9', '2', '用户管理', 'admin/user/index', '', '0', 'nav', '1', '1');
INSERT INTO `ob_auth_rule` VALUES ('11', '3', '广告管理', 'admin/ad/index', '', '1', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('12', '4', '基本设置', 'admin/config/setting', '', '1', 'nav', '1', '1');
INSERT INTO `ob_auth_rule` VALUES ('13', '4', '系统设置', 'admin/config/system', '', '3', 'nav', '1', '1');
INSERT INTO `ob_auth_rule` VALUES ('14', '4', '设置管理', 'admin/config/index', '', '2', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('15', '5', '权限规则', 'admin/auth/rule', '', '3', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('16', '5', '管理员', 'admin/admin/index', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('17', '5', '权限组', 'admin/auth/group', '', '1', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('18', '5', '管理员日志', 'admin/admin/log', '', '5', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('19', '14', '添加', 'admin/config/add', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('20', '14', '编辑', 'admin/config/edit', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('21', '14', '删除', 'admin/config/del', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('22', '15', '添加', 'admin/auth/addRule', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('23', '15', '编辑', 'admin/auth/editRule', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('24', '15', '删除', 'admin/auth/delRule', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('25', '11', '添加', 'admin/ad/add', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('26', '11', '编辑', 'admin/ad/edit', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('27', '11', '删除', 'admin/ad/del', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('28', '9', '添加', 'admin/user/add', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('29', '9', '编辑', 'admin/user/edit', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('30', '9', '删除', 'admin/user/del', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('31', '7', '添加', 'admin/category/add', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('32', '7', '编辑', 'admin/category/edit', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('33', '7', '删除', 'admin/category/del', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('34', '8', '添加', 'admin/article/add', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('35', '8', '编辑', 'admin/article/edit', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('36', '8', '删除', 'admin/article/del', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('37', '16', '添加', 'admin/admin/add', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('38', '16', '编辑', 'admin/admin/edit', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('39', '16', '删除', 'admin/admin/del', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('40', '17', '添加', 'admin/auth/addGroup', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('41', '17', '编辑', 'admin/auth/editGroup', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('42', '17', '删除', 'admin/auth/delGroup', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('43', '6', '修改密码', 'admin/index/editPassword', '', '2', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('44', '6', '清除缓存', 'admin/index/clear', '', '1', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('45', '4', '上传设置', 'admin/config/upload', '', '4', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('46', '3', '数据管理', 'admin/database/index', '', '4', 'nav', '1', '1');
INSERT INTO `ob_auth_rule` VALUES ('47', '46', '还原', 'admin/database/import', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('48', '46', '备份', 'admin/database/backup', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('49', '46', '优化', 'admin/database/optimize', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('50', '46', '修复', 'admin/database/repair', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('51', '46', '下载', 'admin/database/download', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('52', '46', '删除', 'admin/database/del', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('53', '18', '一键清空', 'admin/admin/truncate', '', '0', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('55', '4', '邮件设置', 'admin/config/email', '', '5', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('57', '0', '题目', 'admin/Topic/index', '', '1', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('58', '57', '增加题目', 'admin/Topic/edit', '', '2', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('59', '57', '题目列表 ', 'admin/Topic/index', '', '0', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('60', '57', '导入数据', 'admin/topic/lead', '', '0', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('61', '0', '增加活动', 'admin/Activity/index', '', '0', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('62', '61', '活动列表', 'admin/Activity/index', '', '0', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('63', '61', '增加活动', 'admin/Activity/edit', '', '0', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('64', '61', '规则列表', 'admin/Activity/activity_rule', '', '0', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('65', '61', '规则增加', 'admin/Activity/activity_rule_add', '', '0', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('66', '61', '规则更改', 'admin/Activity/edit_rule', '', '1', 'auth', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('67', '0', '答题规则', 'admin/Answer/index', '', '0', 'nav', '0', '1');
INSERT INTO `ob_auth_rule` VALUES ('68', '67', '规则列表', 'admin/Answer/index', '', '0', 'nav', '0', '1');

-- ----------------------------
-- Table structure for ob_award
-- ----------------------------
DROP TABLE IF EXISTS `ob_award`;
CREATE TABLE `ob_award` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名字',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `add_time` varchar(255) DEFAULT NULL COMMENT '插入时间/年月日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='抽奖用户记录表';

-- ----------------------------
-- Records of ob_award
-- ----------------------------

-- ----------------------------
-- Table structure for ob_category
-- ----------------------------
DROP TABLE IF EXISTS `ob_category`;
CREATE TABLE `ob_category` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `category_name` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `sort_order` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  `keywords` varchar(255) DEFAULT '' COMMENT '关键字',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分类';

-- ----------------------------
-- Records of ob_category
-- ----------------------------
INSERT INTO `ob_category` VALUES ('1', '0', '前端开发', '100', '', '');
INSERT INTO `ob_category` VALUES ('2', '0', '后端开发', '100', '', '');
INSERT INTO `ob_category` VALUES ('3', '0', '移动互联', '100', '', '');
INSERT INTO `ob_category` VALUES ('4', '0', '人工智能', '100', '', '');

-- ----------------------------
-- Table structure for ob_choose
-- ----------------------------
DROP TABLE IF EXISTS `ob_choose`;
CREATE TABLE `ob_choose` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) DEFAULT NULL COMMENT '题的id/可能用不上',
  `choose_name` varchar(255) DEFAULT NULL COMMENT '选项的名字',
  `add_time` bigint(20) DEFAULT NULL COMMENT '增加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=611 DEFAULT CHARSET=utf8 COMMENT='选项表';

-- ----------------------------
-- Records of ob_choose
-- ----------------------------
INSERT INTO `ob_choose` VALUES ('29', '1', '李', '1587472418');
INSERT INTO `ob_choose` VALUES ('30', '1', '刘', '1587472418');
INSERT INTO `ob_choose` VALUES ('31', '1', '元', '1587472418');
INSERT INTO `ob_choose` VALUES ('32', '1', '大', '1587472418');
INSERT INTO `ob_choose` VALUES ('37', '2', '我是哈', '1587476479');
INSERT INTO `ob_choose` VALUES ('38', '2', '我是黑', '1587476479');
INSERT INTO `ob_choose` VALUES ('39', '2', '我是你', '1587476479');
INSERT INTO `ob_choose` VALUES ('40', '2', '我是刘', '1587476479');
INSERT INTO `ob_choose` VALUES ('41', '2', '我是好', '1587476479');
INSERT INTO `ob_choose` VALUES ('42', '3', '1', '1587476659');
INSERT INTO `ob_choose` VALUES ('43', '3', '2', '1587476659');
INSERT INTO `ob_choose` VALUES ('44', '3', '3', '1587476659');
INSERT INTO `ob_choose` VALUES ('45', '4', '1', '1587476684');
INSERT INTO `ob_choose` VALUES ('46', '4', '2', '1587476684');
INSERT INTO `ob_choose` VALUES ('47', '4', '3', '1587476684');
INSERT INTO `ob_choose` VALUES ('48', '5', '1', '1587476704');
INSERT INTO `ob_choose` VALUES ('49', '5', '5', '1587476704');
INSERT INTO `ob_choose` VALUES ('50', '5', '4', '1587476704');
INSERT INTO `ob_choose` VALUES ('51', '6', '1', '1587476727');
INSERT INTO `ob_choose` VALUES ('52', '6', '6', '1587476727');
INSERT INTO `ob_choose` VALUES ('53', '6', '5', '1587476727');
INSERT INTO `ob_choose` VALUES ('54', '6', '9', '1587476727');
INSERT INTO `ob_choose` VALUES ('63', '8', '9', '1587476924');
INSERT INTO `ob_choose` VALUES ('64', '8', '5', '1587476924');
INSERT INTO `ob_choose` VALUES ('65', '8', '8', '1587476924');
INSERT INTO `ob_choose` VALUES ('66', '9', '16', '1587476946');
INSERT INTO `ob_choose` VALUES ('67', '9', '25', '1587476946');
INSERT INTO `ob_choose` VALUES ('68', '9', '10', '1587476946');
INSERT INTO `ob_choose` VALUES ('69', '10', '1', '1587476966');
INSERT INTO `ob_choose` VALUES ('70', '10', '2', '1587476966');
INSERT INTO `ob_choose` VALUES ('71', '10', '3', '1587476966');
INSERT INTO `ob_choose` VALUES ('72', '11', '1', '1587476986');
INSERT INTO `ob_choose` VALUES ('73', '11', '2', '1587476986');
INSERT INTO `ob_choose` VALUES ('74', '11', '3', '1587476986');
INSERT INTO `ob_choose` VALUES ('75', '12', '4', '1587477003');
INSERT INTO `ob_choose` VALUES ('76', '12', '5', '1587477003');
INSERT INTO `ob_choose` VALUES ('77', '12', '3', '1587477003');
INSERT INTO `ob_choose` VALUES ('99', '7', '7', '1587477192');
INSERT INTO `ob_choose` VALUES ('100', '7', '56', '1587477192');
INSERT INTO `ob_choose` VALUES ('101', '7', '6', '1587477192');
INSERT INTO `ob_choose` VALUES ('102', '7', '89', '1587477192');
INSERT INTO `ob_choose` VALUES ('103', '7', '200', '1587477192');
INSERT INTO `ob_choose` VALUES ('104', '7', '10', '1587477192');
INSERT INTO `ob_choose` VALUES ('105', '18', '1', '1587520720');
INSERT INTO `ob_choose` VALUES ('106', '18', '5', '1587520720');
INSERT INTO `ob_choose` VALUES ('107', '18', '2', '1587520720');
INSERT INTO `ob_choose` VALUES ('108', '18', '3', '1587520720');
INSERT INTO `ob_choose` VALUES ('109', '18', '4', '1587520720');
INSERT INTO `ob_choose` VALUES ('110', '18', '6', '1587520720');
INSERT INTO `ob_choose` VALUES ('111', '19', '2', '1587520720');
INSERT INTO `ob_choose` VALUES ('112', '19', '3', '1587520720');
INSERT INTO `ob_choose` VALUES ('113', '19', '4', '1587520720');
INSERT INTO `ob_choose` VALUES ('114', '19', '5', '1587520720');
INSERT INTO `ob_choose` VALUES ('115', '19', '6', '1587520720');
INSERT INTO `ob_choose` VALUES ('116', '20', '1', '1587520720');
INSERT INTO `ob_choose` VALUES ('117', '20', '4', '1587520720');
INSERT INTO `ob_choose` VALUES ('118', '20', '7', '1587520720');
INSERT INTO `ob_choose` VALUES ('119', '20', '5', '1587520721');
INSERT INTO `ob_choose` VALUES ('120', '20', '6', '1587520721');
INSERT INTO `ob_choose` VALUES ('121', '21', '1', '1587520721');
INSERT INTO `ob_choose` VALUES ('122', '21', '7', '1587520721');
INSERT INTO `ob_choose` VALUES ('123', '21', '5', '1587520721');
INSERT INTO `ob_choose` VALUES ('124', '22', '8', '1587520721');
INSERT INTO `ob_choose` VALUES ('125', '22', '2', '1587520721');
INSERT INTO `ob_choose` VALUES ('126', '23', '5', '1587520721');
INSERT INTO `ob_choose` VALUES ('127', '23', '9', '1587520721');
INSERT INTO `ob_choose` VALUES ('128', '24', '10', '1587520721');
INSERT INTO `ob_choose` VALUES ('129', '24', '9', '1587520721');
INSERT INTO `ob_choose` VALUES ('130', '24', '5', '1587520721');
INSERT INTO `ob_choose` VALUES ('131', '26', '2', '1587543692');
INSERT INTO `ob_choose` VALUES ('132', '26', '5', '1587543692');
INSERT INTO `ob_choose` VALUES ('133', '26', '2', '1587543692');
INSERT INTO `ob_choose` VALUES ('134', '26', '3', '1587543692');
INSERT INTO `ob_choose` VALUES ('135', '26', '4', '1587543692');
INSERT INTO `ob_choose` VALUES ('136', '26', '6', '1587543692');
INSERT INTO `ob_choose` VALUES ('137', '27', '4', '1587543693');
INSERT INTO `ob_choose` VALUES ('138', '27', '3', '1587543693');
INSERT INTO `ob_choose` VALUES ('139', '27', '4', '1587543693');
INSERT INTO `ob_choose` VALUES ('140', '27', '5', '1587543693');
INSERT INTO `ob_choose` VALUES ('141', '27', '6', '1587543693');
INSERT INTO `ob_choose` VALUES ('142', '28', '6', '1587543693');
INSERT INTO `ob_choose` VALUES ('143', '28', '4', '1587543693');
INSERT INTO `ob_choose` VALUES ('144', '28', '7', '1587543693');
INSERT INTO `ob_choose` VALUES ('145', '28', '5', '1587543693');
INSERT INTO `ob_choose` VALUES ('146', '28', '6', '1587543693');
INSERT INTO `ob_choose` VALUES ('147', '29', '8', '1587543693');
INSERT INTO `ob_choose` VALUES ('148', '29', '7', '1587543693');
INSERT INTO `ob_choose` VALUES ('149', '29', '5', '1587543693');
INSERT INTO `ob_choose` VALUES ('150', '29', '8', '1587543693');
INSERT INTO `ob_choose` VALUES ('151', '30', '10', '1587543693');
INSERT INTO `ob_choose` VALUES ('152', '30', '10', '1587543693');
INSERT INTO `ob_choose` VALUES ('153', '30', '15', '1587543693');
INSERT INTO `ob_choose` VALUES ('154', '30', '16', '1587543694');
INSERT INTO `ob_choose` VALUES ('155', '31', '12', '1587543694');
INSERT INTO `ob_choose` VALUES ('156', '31', '12', '1587543694');
INSERT INTO `ob_choose` VALUES ('157', '31', '14', '1587543694');
INSERT INTO `ob_choose` VALUES ('158', '31', '16', '1587543694');
INSERT INTO `ob_choose` VALUES ('159', '31', '19', '1587543694');
INSERT INTO `ob_choose` VALUES ('160', '32', '14', '1587543694');
INSERT INTO `ob_choose` VALUES ('161', '32', '9', '1587543694');
INSERT INTO `ob_choose` VALUES ('162', '32', '5', '1587543694');
INSERT INTO `ob_choose` VALUES ('163', '32', '15', '1587543694');
INSERT INTO `ob_choose` VALUES ('164', '32', '41', '1587543694');
INSERT INTO `ob_choose` VALUES ('165', '32', '14', '1587543694');
INSERT INTO `ob_choose` VALUES ('166', '33', '16', '1587543694');
INSERT INTO `ob_choose` VALUES ('167', '33', '16', '1587543694');
INSERT INTO `ob_choose` VALUES ('168', '33', '78', '1587543694');
INSERT INTO `ob_choose` VALUES ('169', '33', '45', '1587543694');
INSERT INTO `ob_choose` VALUES ('170', '33', '152', '1587543694');
INSERT INTO `ob_choose` VALUES ('171', '34', '18', '1587543694');
INSERT INTO `ob_choose` VALUES ('172', '34', '11', '1587543694');
INSERT INTO `ob_choose` VALUES ('173', '34', '166', '1587543694');
INSERT INTO `ob_choose` VALUES ('174', '34', '84', '1587543694');
INSERT INTO `ob_choose` VALUES ('175', '34', '18', '1587543694');
INSERT INTO `ob_choose` VALUES ('176', '35', '20', '1587543695');
INSERT INTO `ob_choose` VALUES ('177', '35', '25', '1587543695');
INSERT INTO `ob_choose` VALUES ('178', '35', '26', '1587543695');
INSERT INTO `ob_choose` VALUES ('179', '35', '24', '1587543695');
INSERT INTO `ob_choose` VALUES ('180', '35', '20', '1587543695');
INSERT INTO `ob_choose` VALUES ('181', '36', '22', '1587543695');
INSERT INTO `ob_choose` VALUES ('182', '36', '65', '1587543695');
INSERT INTO `ob_choose` VALUES ('183', '36', '22', '1587543695');
INSERT INTO `ob_choose` VALUES ('184', '36', '44', '1587543695');
INSERT INTO `ob_choose` VALUES ('185', '36', '99', '1587543695');
INSERT INTO `ob_choose` VALUES ('186', '37', '3', '1587543695');
INSERT INTO `ob_choose` VALUES ('187', '37', '3', '1587543695');
INSERT INTO `ob_choose` VALUES ('188', '37', '44', '1587543695');
INSERT INTO `ob_choose` VALUES ('189', '37', '84', '1587543695');
INSERT INTO `ob_choose` VALUES ('190', '37', '45', '1587543695');
INSERT INTO `ob_choose` VALUES ('191', '37', '488', '1587543695');
INSERT INTO `ob_choose` VALUES ('192', '38', '6', '1587543695');
INSERT INTO `ob_choose` VALUES ('193', '38', '15', '1587543695');
INSERT INTO `ob_choose` VALUES ('194', '38', '45', '1587543695');
INSERT INTO `ob_choose` VALUES ('195', '38', '78', '1587543695');
INSERT INTO `ob_choose` VALUES ('196', '38', '6', '1587543695');
INSERT INTO `ob_choose` VALUES ('197', '38', '112', '1587543695');
INSERT INTO `ob_choose` VALUES ('198', '39', '9', '1587543696');
INSERT INTO `ob_choose` VALUES ('199', '39', '12', '1587543696');
INSERT INTO `ob_choose` VALUES ('200', '39', '45', '1587543696');
INSERT INTO `ob_choose` VALUES ('201', '39', '78', '1587543696');
INSERT INTO `ob_choose` VALUES ('202', '39', '9', '1587543696');
INSERT INTO `ob_choose` VALUES ('203', '40', '12', '1587543696');
INSERT INTO `ob_choose` VALUES ('204', '40', '2', '1587543696');
INSERT INTO `ob_choose` VALUES ('205', '40', '3', '1587543696');
INSERT INTO `ob_choose` VALUES ('206', '40', '4', '1587543696');
INSERT INTO `ob_choose` VALUES ('207', '40', '12', '1587543696');
INSERT INTO `ob_choose` VALUES ('208', '41', '2', '1587543783');
INSERT INTO `ob_choose` VALUES ('209', '41', '5', '1587543783');
INSERT INTO `ob_choose` VALUES ('210', '41', '2', '1587543784');
INSERT INTO `ob_choose` VALUES ('211', '41', '3', '1587543784');
INSERT INTO `ob_choose` VALUES ('212', '41', '4', '1587543784');
INSERT INTO `ob_choose` VALUES ('213', '41', '6', '1587543784');
INSERT INTO `ob_choose` VALUES ('214', '42', '4', '1587543784');
INSERT INTO `ob_choose` VALUES ('215', '42', '3', '1587543784');
INSERT INTO `ob_choose` VALUES ('216', '42', '4', '1587543784');
INSERT INTO `ob_choose` VALUES ('217', '42', '5', '1587543784');
INSERT INTO `ob_choose` VALUES ('218', '42', '6', '1587543784');
INSERT INTO `ob_choose` VALUES ('219', '43', '6', '1587543784');
INSERT INTO `ob_choose` VALUES ('220', '43', '4', '1587543784');
INSERT INTO `ob_choose` VALUES ('221', '43', '7', '1587543784');
INSERT INTO `ob_choose` VALUES ('222', '43', '5', '1587543784');
INSERT INTO `ob_choose` VALUES ('223', '43', '6', '1587543784');
INSERT INTO `ob_choose` VALUES ('224', '44', '654', '1587543784');
INSERT INTO `ob_choose` VALUES ('225', '44', '7', '1587543784');
INSERT INTO `ob_choose` VALUES ('226', '44', '5', '1587543784');
INSERT INTO `ob_choose` VALUES ('227', '44', '8', '1587543784');
INSERT INTO `ob_choose` VALUES ('228', '45', '19', '1587543785');
INSERT INTO `ob_choose` VALUES ('229', '45', '10', '1587543785');
INSERT INTO `ob_choose` VALUES ('230', '45', '15', '1587543785');
INSERT INTO `ob_choose` VALUES ('231', '45', '16', '1587543785');
INSERT INTO `ob_choose` VALUES ('232', '46', '12', '1587543785');
INSERT INTO `ob_choose` VALUES ('233', '46', '12', '1587543785');
INSERT INTO `ob_choose` VALUES ('234', '46', '14', '1587543785');
INSERT INTO `ob_choose` VALUES ('235', '46', '16', '1587543785');
INSERT INTO `ob_choose` VALUES ('236', '46', '19', '1587543785');
INSERT INTO `ob_choose` VALUES ('237', '47', '14', '1587543785');
INSERT INTO `ob_choose` VALUES ('238', '47', '9', '1587543785');
INSERT INTO `ob_choose` VALUES ('239', '47', '5', '1587543785');
INSERT INTO `ob_choose` VALUES ('240', '47', '15', '1587543785');
INSERT INTO `ob_choose` VALUES ('241', '47', '41', '1587543785');
INSERT INTO `ob_choose` VALUES ('242', '47', '156', '1587543785');
INSERT INTO `ob_choose` VALUES ('243', '48', '16', '1587543785');
INSERT INTO `ob_choose` VALUES ('244', '48', '16', '1587543785');
INSERT INTO `ob_choose` VALUES ('245', '48', '78', '1587543786');
INSERT INTO `ob_choose` VALUES ('246', '48', '45', '1587543786');
INSERT INTO `ob_choose` VALUES ('247', '48', '152', '1587543786');
INSERT INTO `ob_choose` VALUES ('248', '49', '18', '1587543786');
INSERT INTO `ob_choose` VALUES ('249', '49', '11', '1587543786');
INSERT INTO `ob_choose` VALUES ('250', '49', '166', '1587543786');
INSERT INTO `ob_choose` VALUES ('251', '49', '84', '1587543786');
INSERT INTO `ob_choose` VALUES ('252', '49', '18', '1587543786');
INSERT INTO `ob_choose` VALUES ('253', '50', '10', '1587543786');
INSERT INTO `ob_choose` VALUES ('254', '50', '25', '1587543786');
INSERT INTO `ob_choose` VALUES ('255', '50', '26', '1587543786');
INSERT INTO `ob_choose` VALUES ('256', '50', '24', '1587543786');
INSERT INTO `ob_choose` VALUES ('257', '50', '20', '1587543786');
INSERT INTO `ob_choose` VALUES ('258', '51', '22', '1587543786');
INSERT INTO `ob_choose` VALUES ('259', '51', '65', '1587543786');
INSERT INTO `ob_choose` VALUES ('260', '51', '22', '1587543786');
INSERT INTO `ob_choose` VALUES ('261', '51', '44', '1587543786');
INSERT INTO `ob_choose` VALUES ('262', '51', '99', '1587543786');
INSERT INTO `ob_choose` VALUES ('263', '52', '3', '1587543786');
INSERT INTO `ob_choose` VALUES ('264', '52', '954', '1587543786');
INSERT INTO `ob_choose` VALUES ('265', '52', '44', '1587543786');
INSERT INTO `ob_choose` VALUES ('266', '52', '84', '1587543786');
INSERT INTO `ob_choose` VALUES ('267', '52', '45', '1587543786');
INSERT INTO `ob_choose` VALUES ('268', '52', '488', '1587543786');
INSERT INTO `ob_choose` VALUES ('269', '53', '6', '1587543787');
INSERT INTO `ob_choose` VALUES ('270', '53', '15', '1587543787');
INSERT INTO `ob_choose` VALUES ('271', '53', '45', '1587543787');
INSERT INTO `ob_choose` VALUES ('272', '53', '78', '1587543787');
INSERT INTO `ob_choose` VALUES ('273', '53', '6', '1587543787');
INSERT INTO `ob_choose` VALUES ('274', '53', '112', '1587543787');
INSERT INTO `ob_choose` VALUES ('275', '54', '9', '1587543787');
INSERT INTO `ob_choose` VALUES ('276', '54', '12', '1587543787');
INSERT INTO `ob_choose` VALUES ('277', '54', '45', '1587543787');
INSERT INTO `ob_choose` VALUES ('278', '54', '78', '1587543787');
INSERT INTO `ob_choose` VALUES ('279', '54', '9', '1587543787');
INSERT INTO `ob_choose` VALUES ('280', '55', '12', '1587543787');
INSERT INTO `ob_choose` VALUES ('281', '55', '2', '1587543787');
INSERT INTO `ob_choose` VALUES ('282', '55', '3', '1587543787');
INSERT INTO `ob_choose` VALUES ('283', '55', '4', '1587543787');
INSERT INTO `ob_choose` VALUES ('284', '55', '12', '1587543787');
INSERT INTO `ob_choose` VALUES ('285', '56', '2', '1587543829');
INSERT INTO `ob_choose` VALUES ('286', '56', '5', '1587543829');
INSERT INTO `ob_choose` VALUES ('287', '56', '2', '1587543829');
INSERT INTO `ob_choose` VALUES ('288', '56', '3', '1587543829');
INSERT INTO `ob_choose` VALUES ('289', '56', '4', '1587543829');
INSERT INTO `ob_choose` VALUES ('290', '56', '6', '1587543829');
INSERT INTO `ob_choose` VALUES ('291', '57', '4', '1587543829');
INSERT INTO `ob_choose` VALUES ('292', '57', '3', '1587543829');
INSERT INTO `ob_choose` VALUES ('293', '57', '4', '1587543829');
INSERT INTO `ob_choose` VALUES ('294', '57', '5', '1587543829');
INSERT INTO `ob_choose` VALUES ('295', '57', '6', '1587543829');
INSERT INTO `ob_choose` VALUES ('296', '58', '6', '1587543829');
INSERT INTO `ob_choose` VALUES ('297', '58', '4', '1587543829');
INSERT INTO `ob_choose` VALUES ('298', '58', '7', '1587543830');
INSERT INTO `ob_choose` VALUES ('299', '58', '5', '1587543830');
INSERT INTO `ob_choose` VALUES ('300', '58', '484', '1587543830');
INSERT INTO `ob_choose` VALUES ('301', '59', '8', '1587543830');
INSERT INTO `ob_choose` VALUES ('302', '59', '7', '1587543830');
INSERT INTO `ob_choose` VALUES ('303', '59', '5', '1587543830');
INSERT INTO `ob_choose` VALUES ('304', '59', '8', '1587543830');
INSERT INTO `ob_choose` VALUES ('305', '60', '10', '1587543830');
INSERT INTO `ob_choose` VALUES ('306', '60', '10', '1587543830');
INSERT INTO `ob_choose` VALUES ('307', '60', '15', '1587543830');
INSERT INTO `ob_choose` VALUES ('308', '60', '16', '1587543830');
INSERT INTO `ob_choose` VALUES ('309', '61', '12', '1587543830');
INSERT INTO `ob_choose` VALUES ('310', '61', '95', '1587543830');
INSERT INTO `ob_choose` VALUES ('311', '61', '14', '1587543830');
INSERT INTO `ob_choose` VALUES ('312', '61', '16', '1587543830');
INSERT INTO `ob_choose` VALUES ('313', '61', '19', '1587543830');
INSERT INTO `ob_choose` VALUES ('314', '62', '14', '1587543830');
INSERT INTO `ob_choose` VALUES ('315', '62', '9', '1587543830');
INSERT INTO `ob_choose` VALUES ('316', '62', '5', '1587543831');
INSERT INTO `ob_choose` VALUES ('317', '62', '15', '1587543831');
INSERT INTO `ob_choose` VALUES ('318', '62', '41', '1587543831');
INSERT INTO `ob_choose` VALUES ('319', '62', '14', '1587543831');
INSERT INTO `ob_choose` VALUES ('320', '63', '16', '1587543831');
INSERT INTO `ob_choose` VALUES ('321', '63', '16', '1587543831');
INSERT INTO `ob_choose` VALUES ('322', '63', '78', '1587543831');
INSERT INTO `ob_choose` VALUES ('323', '63', '45', '1587543831');
INSERT INTO `ob_choose` VALUES ('324', '63', '152', '1587543831');
INSERT INTO `ob_choose` VALUES ('325', '64', '18', '1587543832');
INSERT INTO `ob_choose` VALUES ('326', '64', '11', '1587543832');
INSERT INTO `ob_choose` VALUES ('327', '64', '166', '1587543832');
INSERT INTO `ob_choose` VALUES ('328', '64', '84', '1587543832');
INSERT INTO `ob_choose` VALUES ('329', '64', '18', '1587543832');
INSERT INTO `ob_choose` VALUES ('330', '65', '20', '1587543832');
INSERT INTO `ob_choose` VALUES ('331', '65', '25', '1587543832');
INSERT INTO `ob_choose` VALUES ('332', '65', '26', '1587543832');
INSERT INTO `ob_choose` VALUES ('333', '65', '24', '1587543832');
INSERT INTO `ob_choose` VALUES ('334', '65', '20', '1587543832');
INSERT INTO `ob_choose` VALUES ('335', '66', '22', '1587543832');
INSERT INTO `ob_choose` VALUES ('336', '66', '65', '1587543832');
INSERT INTO `ob_choose` VALUES ('337', '66', '22', '1587543832');
INSERT INTO `ob_choose` VALUES ('338', '66', '44', '1587543832');
INSERT INTO `ob_choose` VALUES ('339', '66', '99', '1587543832');
INSERT INTO `ob_choose` VALUES ('340', '67', '3', '1587543832');
INSERT INTO `ob_choose` VALUES ('341', '67', '3', '1587543832');
INSERT INTO `ob_choose` VALUES ('342', '67', '44', '1587543832');
INSERT INTO `ob_choose` VALUES ('343', '67', '84', '1587543832');
INSERT INTO `ob_choose` VALUES ('344', '67', '45', '1587543832');
INSERT INTO `ob_choose` VALUES ('345', '67', '488', '1587543832');
INSERT INTO `ob_choose` VALUES ('346', '68', '6', '1587543833');
INSERT INTO `ob_choose` VALUES ('347', '68', '15', '1587543833');
INSERT INTO `ob_choose` VALUES ('348', '68', '45', '1587543833');
INSERT INTO `ob_choose` VALUES ('349', '68', '78', '1587543833');
INSERT INTO `ob_choose` VALUES ('350', '68', '6', '1587543833');
INSERT INTO `ob_choose` VALUES ('351', '68', '112', '1587543833');
INSERT INTO `ob_choose` VALUES ('352', '69', '9', '1587543833');
INSERT INTO `ob_choose` VALUES ('353', '69', '12', '1587543833');
INSERT INTO `ob_choose` VALUES ('354', '69', '45', '1587543833');
INSERT INTO `ob_choose` VALUES ('355', '69', '78', '1587543833');
INSERT INTO `ob_choose` VALUES ('356', '69', '9', '1587543833');
INSERT INTO `ob_choose` VALUES ('357', '70', '12', '1587543833');
INSERT INTO `ob_choose` VALUES ('358', '70', '2', '1587543833');
INSERT INTO `ob_choose` VALUES ('359', '70', '3', '1587543833');
INSERT INTO `ob_choose` VALUES ('360', '70', '4', '1587543833');
INSERT INTO `ob_choose` VALUES ('361', '70', '12', '1587543833');
INSERT INTO `ob_choose` VALUES ('362', '71', '2', '1587543901');
INSERT INTO `ob_choose` VALUES ('363', '71', '5', '1587543901');
INSERT INTO `ob_choose` VALUES ('364', '71', '2', '1587543901');
INSERT INTO `ob_choose` VALUES ('365', '71', '3', '1587543901');
INSERT INTO `ob_choose` VALUES ('366', '71', '4', '1587543901');
INSERT INTO `ob_choose` VALUES ('367', '71', '6', '1587543901');
INSERT INTO `ob_choose` VALUES ('368', '72', '4', '1587543901');
INSERT INTO `ob_choose` VALUES ('369', '72', '3', '1587543901');
INSERT INTO `ob_choose` VALUES ('370', '72', '4', '1587543902');
INSERT INTO `ob_choose` VALUES ('371', '72', '5', '1587543902');
INSERT INTO `ob_choose` VALUES ('372', '72', '6', '1587543902');
INSERT INTO `ob_choose` VALUES ('373', '73', '6', '1587543902');
INSERT INTO `ob_choose` VALUES ('374', '73', '4', '1587543902');
INSERT INTO `ob_choose` VALUES ('375', '73', '7', '1587543902');
INSERT INTO `ob_choose` VALUES ('376', '73', '5', '1587543902');
INSERT INTO `ob_choose` VALUES ('377', '73', '6', '1587543902');
INSERT INTO `ob_choose` VALUES ('378', '74', '8', '1587543902');
INSERT INTO `ob_choose` VALUES ('379', '74', '7', '1587543902');
INSERT INTO `ob_choose` VALUES ('380', '74', '5', '1587543902');
INSERT INTO `ob_choose` VALUES ('381', '74', '8', '1587543902');
INSERT INTO `ob_choose` VALUES ('382', '75', '10', '1587543902');
INSERT INTO `ob_choose` VALUES ('383', '75', '10', '1587543902');
INSERT INTO `ob_choose` VALUES ('384', '75', '15', '1587543902');
INSERT INTO `ob_choose` VALUES ('385', '75', '16', '1587543902');
INSERT INTO `ob_choose` VALUES ('386', '76', '12', '1587543902');
INSERT INTO `ob_choose` VALUES ('387', '76', '12', '1587543902');
INSERT INTO `ob_choose` VALUES ('388', '76', '14', '1587543902');
INSERT INTO `ob_choose` VALUES ('389', '76', '16', '1587543902');
INSERT INTO `ob_choose` VALUES ('390', '76', '19', '1587543903');
INSERT INTO `ob_choose` VALUES ('391', '77', '14', '1587543903');
INSERT INTO `ob_choose` VALUES ('392', '77', '9', '1587543903');
INSERT INTO `ob_choose` VALUES ('393', '77', '5', '1587543903');
INSERT INTO `ob_choose` VALUES ('394', '77', '15', '1587543903');
INSERT INTO `ob_choose` VALUES ('395', '77', '41', '1587543903');
INSERT INTO `ob_choose` VALUES ('396', '77', '14', '1587543903');
INSERT INTO `ob_choose` VALUES ('397', '78', '16', '1587543903');
INSERT INTO `ob_choose` VALUES ('398', '78', '16', '1587543903');
INSERT INTO `ob_choose` VALUES ('399', '78', '78', '1587543903');
INSERT INTO `ob_choose` VALUES ('400', '78', '45', '1587543903');
INSERT INTO `ob_choose` VALUES ('401', '78', '152', '1587543903');
INSERT INTO `ob_choose` VALUES ('402', '79', '18', '1587543903');
INSERT INTO `ob_choose` VALUES ('403', '79', '11', '1587543903');
INSERT INTO `ob_choose` VALUES ('404', '79', '166', '1587543903');
INSERT INTO `ob_choose` VALUES ('405', '79', '84', '1587543903');
INSERT INTO `ob_choose` VALUES ('406', '79', '18', '1587543904');
INSERT INTO `ob_choose` VALUES ('407', '80', '20', '1587543904');
INSERT INTO `ob_choose` VALUES ('408', '80', '25', '1587543904');
INSERT INTO `ob_choose` VALUES ('409', '80', '26', '1587543904');
INSERT INTO `ob_choose` VALUES ('410', '80', '24', '1587543904');
INSERT INTO `ob_choose` VALUES ('411', '80', '20', '1587543904');
INSERT INTO `ob_choose` VALUES ('412', '81', '22', '1587543904');
INSERT INTO `ob_choose` VALUES ('413', '81', '65', '1587543904');
INSERT INTO `ob_choose` VALUES ('414', '81', '22', '1587543904');
INSERT INTO `ob_choose` VALUES ('415', '81', '44', '1587543904');
INSERT INTO `ob_choose` VALUES ('416', '81', '99', '1587543904');
INSERT INTO `ob_choose` VALUES ('417', '82', '3', '1587543904');
INSERT INTO `ob_choose` VALUES ('418', '82', '3', '1587543904');
INSERT INTO `ob_choose` VALUES ('419', '82', '44', '1587543904');
INSERT INTO `ob_choose` VALUES ('420', '82', '84', '1587543904');
INSERT INTO `ob_choose` VALUES ('421', '82', '45', '1587543904');
INSERT INTO `ob_choose` VALUES ('422', '82', '488', '1587543904');
INSERT INTO `ob_choose` VALUES ('423', '83', '6', '1587543904');
INSERT INTO `ob_choose` VALUES ('424', '83', '15', '1587543904');
INSERT INTO `ob_choose` VALUES ('425', '83', '45', '1587543904');
INSERT INTO `ob_choose` VALUES ('426', '83', '78', '1587543904');
INSERT INTO `ob_choose` VALUES ('427', '83', '6', '1587543904');
INSERT INTO `ob_choose` VALUES ('428', '83', '112', '1587543905');
INSERT INTO `ob_choose` VALUES ('429', '84', '9', '1587543905');
INSERT INTO `ob_choose` VALUES ('430', '84', '12', '1587543905');
INSERT INTO `ob_choose` VALUES ('431', '84', '45', '1587543905');
INSERT INTO `ob_choose` VALUES ('432', '84', '78', '1587543905');
INSERT INTO `ob_choose` VALUES ('433', '84', '9', '1587543905');
INSERT INTO `ob_choose` VALUES ('434', '85', '12', '1587543905');
INSERT INTO `ob_choose` VALUES ('435', '85', '2', '1587543905');
INSERT INTO `ob_choose` VALUES ('436', '85', '3', '1587543905');
INSERT INTO `ob_choose` VALUES ('437', '85', '4', '1587543905');
INSERT INTO `ob_choose` VALUES ('438', '85', '12', '1587543905');
INSERT INTO `ob_choose` VALUES ('439', '86', '1', '1587544192');
INSERT INTO `ob_choose` VALUES ('440', '86', '5', '1587544192');
INSERT INTO `ob_choose` VALUES ('441', '86', '2', '1587544192');
INSERT INTO `ob_choose` VALUES ('442', '86', '3', '1587544192');
INSERT INTO `ob_choose` VALUES ('443', '86', '4', '1587544192');
INSERT INTO `ob_choose` VALUES ('444', '86', '6', '1587544192');
INSERT INTO `ob_choose` VALUES ('445', '87', '4', '1587544192');
INSERT INTO `ob_choose` VALUES ('446', '87', '2', '1587544192');
INSERT INTO `ob_choose` VALUES ('447', '87', '4', '1587544192');
INSERT INTO `ob_choose` VALUES ('448', '87', '5', '1587544192');
INSERT INTO `ob_choose` VALUES ('449', '87', '6', '1587544192');
INSERT INTO `ob_choose` VALUES ('450', '88', '6', '1587544192');
INSERT INTO `ob_choose` VALUES ('451', '88', '3', '1587544192');
INSERT INTO `ob_choose` VALUES ('452', '88', '7', '1587544192');
INSERT INTO `ob_choose` VALUES ('453', '88', '5', '1587544192');
INSERT INTO `ob_choose` VALUES ('454', '88', '6', '1587544192');
INSERT INTO `ob_choose` VALUES ('455', '89', '8', '1587544193');
INSERT INTO `ob_choose` VALUES ('456', '89', '4', '1587544193');
INSERT INTO `ob_choose` VALUES ('457', '89', '5', '1587544193');
INSERT INTO `ob_choose` VALUES ('458', '89', '8', '1587544193');
INSERT INTO `ob_choose` VALUES ('459', '90', '10', '1587544193');
INSERT INTO `ob_choose` VALUES ('460', '90', '10', '1587544193');
INSERT INTO `ob_choose` VALUES ('461', '90', '5', '1587544193');
INSERT INTO `ob_choose` VALUES ('462', '90', '16', '1587544193');
INSERT INTO `ob_choose` VALUES ('463', '91', '12', '1587544193');
INSERT INTO `ob_choose` VALUES ('464', '91', '12', '1587544193');
INSERT INTO `ob_choose` VALUES ('465', '91', '14', '1587544193');
INSERT INTO `ob_choose` VALUES ('466', '91', '6', '1587544193');
INSERT INTO `ob_choose` VALUES ('467', '91', '19', '1587544193');
INSERT INTO `ob_choose` VALUES ('468', '92', '14', '1587544193');
INSERT INTO `ob_choose` VALUES ('469', '92', '9', '1587544193');
INSERT INTO `ob_choose` VALUES ('470', '92', '5', '1587544193');
INSERT INTO `ob_choose` VALUES ('471', '92', '15', '1587544193');
INSERT INTO `ob_choose` VALUES ('472', '92', '7', '1587544193');
INSERT INTO `ob_choose` VALUES ('473', '92', '14', '1587544193');
INSERT INTO `ob_choose` VALUES ('474', '93', '16', '1587544194');
INSERT INTO `ob_choose` VALUES ('475', '93', '16', '1587544194');
INSERT INTO `ob_choose` VALUES ('476', '93', '78', '1587544194');
INSERT INTO `ob_choose` VALUES ('477', '93', '8', '1587544194');
INSERT INTO `ob_choose` VALUES ('478', '93', '152', '1587544194');
INSERT INTO `ob_choose` VALUES ('479', '94', '18', '1587544194');
INSERT INTO `ob_choose` VALUES ('480', '94', '11', '1587544194');
INSERT INTO `ob_choose` VALUES ('481', '94', '166', '1587544194');
INSERT INTO `ob_choose` VALUES ('482', '94', '9', '1587544194');
INSERT INTO `ob_choose` VALUES ('483', '94', '18', '1587544194');
INSERT INTO `ob_choose` VALUES ('484', '95', '20', '1587544194');
INSERT INTO `ob_choose` VALUES ('485', '95', '25', '1587544194');
INSERT INTO `ob_choose` VALUES ('486', '95', '26', '1587544194');
INSERT INTO `ob_choose` VALUES ('487', '95', '10', '1587544194');
INSERT INTO `ob_choose` VALUES ('488', '95', '20', '1587544194');
INSERT INTO `ob_choose` VALUES ('489', '96', '22', '1587544194');
INSERT INTO `ob_choose` VALUES ('490', '96', '65', '1587544194');
INSERT INTO `ob_choose` VALUES ('491', '96', '11', '1587544195');
INSERT INTO `ob_choose` VALUES ('492', '96', '44', '1587544195');
INSERT INTO `ob_choose` VALUES ('493', '96', '99', '1587544195');
INSERT INTO `ob_choose` VALUES ('494', '97', '3', '1587544195');
INSERT INTO `ob_choose` VALUES ('495', '97', '3', '1587544195');
INSERT INTO `ob_choose` VALUES ('496', '97', '12', '1587544195');
INSERT INTO `ob_choose` VALUES ('497', '97', '84', '1587544195');
INSERT INTO `ob_choose` VALUES ('498', '97', '45', '1587544195');
INSERT INTO `ob_choose` VALUES ('499', '97', '488', '1587544195');
INSERT INTO `ob_choose` VALUES ('500', '98', '6', '1587544195');
INSERT INTO `ob_choose` VALUES ('501', '98', '15', '1587544195');
INSERT INTO `ob_choose` VALUES ('502', '98', '45', '1587544195');
INSERT INTO `ob_choose` VALUES ('503', '98', '13', '1587544195');
INSERT INTO `ob_choose` VALUES ('504', '98', '6', '1587544195');
INSERT INTO `ob_choose` VALUES ('505', '98', '112', '1587544195');
INSERT INTO `ob_choose` VALUES ('506', '99', '9', '1587544195');
INSERT INTO `ob_choose` VALUES ('507', '99', '12', '1587544195');
INSERT INTO `ob_choose` VALUES ('508', '99', '45', '1587544195');
INSERT INTO `ob_choose` VALUES ('509', '99', '14', '1587544195');
INSERT INTO `ob_choose` VALUES ('510', '99', '9', '1587544195');
INSERT INTO `ob_choose` VALUES ('511', '100', '12', '1587544196');
INSERT INTO `ob_choose` VALUES ('512', '100', '2', '1587544196');
INSERT INTO `ob_choose` VALUES ('513', '100', '3', '1587544196');
INSERT INTO `ob_choose` VALUES ('514', '100', '157', '1587544196');
INSERT INTO `ob_choose` VALUES ('515', '100', '15', '1587544196');
INSERT INTO `ob_choose` VALUES ('516', '101', '13', '1587544196');
INSERT INTO `ob_choose` VALUES ('517', '101', '3', '1587544196');
INSERT INTO `ob_choose` VALUES ('518', '101', '4', '1587544196');
INSERT INTO `ob_choose` VALUES ('519', '101', '158', '1587544196');
INSERT INTO `ob_choose` VALUES ('520', '101', '16', '1587544196');
INSERT INTO `ob_choose` VALUES ('521', '101', '112', '1587544196');
INSERT INTO `ob_choose` VALUES ('522', '102', '14', '1587544196');
INSERT INTO `ob_choose` VALUES ('523', '102', '4', '1587544196');
INSERT INTO `ob_choose` VALUES ('524', '102', '5', '1587544196');
INSERT INTO `ob_choose` VALUES ('525', '102', '159', '1587544196');
INSERT INTO `ob_choose` VALUES ('526', '102', '17', '1587544196');
INSERT INTO `ob_choose` VALUES ('527', '102', '113', '1587544196');
INSERT INTO `ob_choose` VALUES ('528', '103', '15', '1587544196');
INSERT INTO `ob_choose` VALUES ('529', '103', '5', '1587544196');
INSERT INTO `ob_choose` VALUES ('530', '103', '6', '1587544196');
INSERT INTO `ob_choose` VALUES ('531', '103', '160', '1587544196');
INSERT INTO `ob_choose` VALUES ('532', '103', '18', '1587544196');
INSERT INTO `ob_choose` VALUES ('533', '103', '114', '1587544196');
INSERT INTO `ob_choose` VALUES ('534', '104', '16', '1587544197');
INSERT INTO `ob_choose` VALUES ('535', '104', '6', '1587544197');
INSERT INTO `ob_choose` VALUES ('536', '104', '7', '1587544197');
INSERT INTO `ob_choose` VALUES ('537', '104', '161', '1587544197');
INSERT INTO `ob_choose` VALUES ('538', '104', '19', '1587544197');
INSERT INTO `ob_choose` VALUES ('539', '104', '115', '1587544197');
INSERT INTO `ob_choose` VALUES ('540', '105', '17', '1587544197');
INSERT INTO `ob_choose` VALUES ('541', '105', '7', '1587544197');
INSERT INTO `ob_choose` VALUES ('542', '105', '8', '1587544197');
INSERT INTO `ob_choose` VALUES ('543', '105', '162', '1587544197');
INSERT INTO `ob_choose` VALUES ('544', '105', '20', '1587544197');
INSERT INTO `ob_choose` VALUES ('545', '105', '116', '1587544197');
INSERT INTO `ob_choose` VALUES ('546', '106', '18', '1587544197');
INSERT INTO `ob_choose` VALUES ('547', '106', '8', '1587544197');
INSERT INTO `ob_choose` VALUES ('548', '106', '9', '1587544197');
INSERT INTO `ob_choose` VALUES ('549', '106', '163', '1587544197');
INSERT INTO `ob_choose` VALUES ('550', '106', '21', '1587544197');
INSERT INTO `ob_choose` VALUES ('551', '107', '19', '1587544197');
INSERT INTO `ob_choose` VALUES ('552', '107', '9', '1587544197');
INSERT INTO `ob_choose` VALUES ('553', '107', '10', '1587544198');
INSERT INTO `ob_choose` VALUES ('554', '108', '19', '1587544224');
INSERT INTO `ob_choose` VALUES ('555', '108', '9', '1587544224');
INSERT INTO `ob_choose` VALUES ('556', '108', '10', '1587544225');
INSERT INTO `ob_choose` VALUES ('557', '109', '20', '1587544312');
INSERT INTO `ob_choose` VALUES ('558', '109', '10', '1587544312');
INSERT INTO `ob_choose` VALUES ('559', '109', '11', '1587544312');
INSERT INTO `ob_choose` VALUES ('560', '109', '23', '1587544312');
INSERT INTO `ob_choose` VALUES ('561', '110', '21', '1587544312');
INSERT INTO `ob_choose` VALUES ('562', '110', '11', '1587544313');
INSERT INTO `ob_choose` VALUES ('563', '110', '12', '1587544313');
INSERT INTO `ob_choose` VALUES ('564', '110', '24', '1587544313');
INSERT INTO `ob_choose` VALUES ('565', '111', '22', '1587544313');
INSERT INTO `ob_choose` VALUES ('566', '111', '12', '1587544313');
INSERT INTO `ob_choose` VALUES ('567', '111', '13', '1587544313');
INSERT INTO `ob_choose` VALUES ('568', '111', '25', '1587544313');
INSERT INTO `ob_choose` VALUES ('569', '112', '23', '1587544313');
INSERT INTO `ob_choose` VALUES ('570', '112', '13', '1587544313');
INSERT INTO `ob_choose` VALUES ('571', '112', '14', '1587544313');
INSERT INTO `ob_choose` VALUES ('572', '112', '26', '1587544313');
INSERT INTO `ob_choose` VALUES ('573', '113', '24', '1587544313');
INSERT INTO `ob_choose` VALUES ('574', '113', '14', '1587544313');
INSERT INTO `ob_choose` VALUES ('575', '113', '15', '1587544313');
INSERT INTO `ob_choose` VALUES ('576', '113', '27', '1587544313');
INSERT INTO `ob_choose` VALUES ('577', '114', '25', '1587544313');
INSERT INTO `ob_choose` VALUES ('578', '114', '15', '1587544313');
INSERT INTO `ob_choose` VALUES ('579', '114', '16', '1587544313');
INSERT INTO `ob_choose` VALUES ('580', '114', '28', '1587544313');
INSERT INTO `ob_choose` VALUES ('581', '115', '26', '1587544314');
INSERT INTO `ob_choose` VALUES ('582', '115', '16', '1587544314');
INSERT INTO `ob_choose` VALUES ('583', '115', '17', '1587544314');
INSERT INTO `ob_choose` VALUES ('584', '115', '29', '1587544314');
INSERT INTO `ob_choose` VALUES ('585', '117', '1', '1587544431');
INSERT INTO `ob_choose` VALUES ('586', '117', '5', '1587544431');
INSERT INTO `ob_choose` VALUES ('587', '117', '2', '1587544431');
INSERT INTO `ob_choose` VALUES ('588', '117', '3', '1587544431');
INSERT INTO `ob_choose` VALUES ('589', '117', '4', '1587544431');
INSERT INTO `ob_choose` VALUES ('590', '117', '6', '1587544431');
INSERT INTO `ob_choose` VALUES ('591', '118', '2', '1587544431');
INSERT INTO `ob_choose` VALUES ('592', '118', '3', '1587544431');
INSERT INTO `ob_choose` VALUES ('593', '118', '4', '1587544431');
INSERT INTO `ob_choose` VALUES ('594', '118', '5', '1587544431');
INSERT INTO `ob_choose` VALUES ('595', '118', '6', '1587544431');
INSERT INTO `ob_choose` VALUES ('596', '119', '1', '1587544431');
INSERT INTO `ob_choose` VALUES ('597', '119', '4', '1587544432');
INSERT INTO `ob_choose` VALUES ('598', '119', '7', '1587544432');
INSERT INTO `ob_choose` VALUES ('599', '119', '5', '1587544432');
INSERT INTO `ob_choose` VALUES ('600', '119', '6', '1587544432');
INSERT INTO `ob_choose` VALUES ('601', '120', '1', '1587544432');
INSERT INTO `ob_choose` VALUES ('602', '120', '7', '1587544432');
INSERT INTO `ob_choose` VALUES ('603', '120', '5', '1587544432');
INSERT INTO `ob_choose` VALUES ('604', '121', '8', '1587544432');
INSERT INTO `ob_choose` VALUES ('605', '121', '2', '1587544432');
INSERT INTO `ob_choose` VALUES ('606', '122', '5', '1587544432');
INSERT INTO `ob_choose` VALUES ('607', '122', '9', '1587544432');
INSERT INTO `ob_choose` VALUES ('608', '123', '10', '1587544432');
INSERT INTO `ob_choose` VALUES ('609', '123', '9', '1587544432');
INSERT INTO `ob_choose` VALUES ('610', '123', '5', '1587544432');

-- ----------------------------
-- Table structure for ob_config
-- ----------------------------
DROP TABLE IF EXISTS `ob_config`;
CREATE TABLE `ob_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(32) NOT NULL DEFAULT '' COMMENT '配置分组',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '配置标题',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '配置标识',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT '配置类型',
  `value` text NOT NULL COMMENT '默认值',
  `options` text COMMENT '选项值',
  `sort_order` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='配置';

-- ----------------------------
-- Records of ob_config
-- ----------------------------
INSERT INTO `ob_config` VALUES ('1', 'website', '网站logo', 'logo', 'image', '/upload/image/20200421/6dee8990e381f7b4b5aa312276212a4c.png', '', '100', '1');
INSERT INTO `ob_config` VALUES ('2', 'website', '网站名称', 'site_name', 'input', '答题', '', '100', '1');
INSERT INTO `ob_config` VALUES ('3', 'website', '网站标题', 'site_title', 'input', '答题后台管理系统', '', '100', '1');
INSERT INTO `ob_config` VALUES ('4', 'website', '网站关键字', 'site_keywords', 'input', '答题抽奖', '', '100', '1');
INSERT INTO `ob_config` VALUES ('5', 'website', '网站描述', 'site_description', 'textarea', '学生们进行答题，答题后可进行抽奖', '', '100', '1');
INSERT INTO `ob_config` VALUES ('6', 'website', '版权信息', 'site_copyright', 'input', '', '', '100', '1');
INSERT INTO `ob_config` VALUES ('7', 'website', 'ICP备案号', 'site_icp', 'input', '', '', '100', '1');
INSERT INTO `ob_config` VALUES ('8', 'website', '统计代码', 'site_code', 'textarea', '', '', '100', '1');
INSERT INTO `ob_config` VALUES ('9', 'contact', '公司名称', 'company', 'input', '', '', '100', '1');
INSERT INTO `ob_config` VALUES ('10', 'contact', '公司地址', 'address', 'input', '', '', '100', '1');
INSERT INTO `ob_config` VALUES ('11', 'contact', '联系电话', 'tel', 'input', '', '', '100', '1');
INSERT INTO `ob_config` VALUES ('12', 'contact', '联系邮箱', 'email', 'input', '', '', '100', '1');

-- ----------------------------
-- Table structure for ob_system
-- ----------------------------
DROP TABLE IF EXISTS `ob_system`;
CREATE TABLE `ob_system` (
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统配置';

-- ----------------------------
-- Records of ob_system
-- ----------------------------
INSERT INTO `ob_system` VALUES ('administrator', 'admin');
INSERT INTO `ob_system` VALUES ('colse_explain', '');
INSERT INTO `ob_system` VALUES ('default_editor', 'ueditor');
INSERT INTO `ob_system` VALUES ('email_server', 'a:7:{s:4:\"host\";s:0:\"\";s:6:\"secure\";s:3:\"tls\";s:4:\"port\";s:0:\"\";s:8:\"username\";s:0:\"\";s:8:\"password\";s:0:\"\";s:8:\"fromname\";s:0:\"\";s:5:\"email\";s:0:\"\";}');
INSERT INTO `ob_system` VALUES ('page_number', '10');
INSERT INTO `ob_system` VALUES ('upload_image', 'a:15:{s:8:\"is_thumb\";s:1:\"1\";s:9:\"max_width\";s:4:\"1200\";s:10:\"max_height\";s:4:\"3600\";s:8:\"is_water\";s:1:\"0\";s:12:\"water_source\";s:0:\"\";s:12:\"water_locate\";s:1:\"1\";s:11:\"water_alpha\";s:0:\"\";s:7:\"is_text\";s:1:\"0\";s:4:\"text\";s:0:\"\";s:9:\"text_font\";s:0:\"\";s:11:\"text_locate\";s:1:\"1\";s:9:\"text_size\";s:0:\"\";s:10:\"text_color\";s:0:\"\";s:11:\"text_offset\";s:0:\"\";s:10:\"text_angle\";s:0:\"\";}');
INSERT INTO `ob_system` VALUES ('website_status', '1');

-- ----------------------------
-- Table structure for ob_topic
-- ----------------------------
DROP TABLE IF EXISTS `ob_topic`;
CREATE TABLE `ob_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_name` text COMMENT '题目名字',
  `choose_id` varchar(50) DEFAULT NULL COMMENT '选项表的id',
  `topic_correct` varchar(255) DEFAULT NULL COMMENT '选项正确答案（内容）',
  `add_time` bigint(20) DEFAULT NULL COMMENT '增加时间',
  `choose_correct_id` int(11) DEFAULT NULL COMMENT '正确选项（id？）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 COMMENT='题表';

-- ----------------------------
-- Records of ob_topic
-- ----------------------------
INSERT INTO `ob_topic` VALUES ('1', '你叫什么', '29,30,31,32', '刘', '1587472368', '30');
INSERT INTO `ob_topic` VALUES ('2', '你是谁', '37,38,39,40,41', '我是刘', '1587476464', '40');
INSERT INTO `ob_topic` VALUES ('3', '1+1 = ?', '42,43,44', '2', '1587476659', '43');
INSERT INTO `ob_topic` VALUES ('4', '1+2 = ?', '45,46,47', '3', '1587476684', '47');
INSERT INTO `ob_topic` VALUES ('5', '1+3 = ?', '48,49,50', '4', '1587476703', '50');
INSERT INTO `ob_topic` VALUES ('6', '1+4 = ?', '51,52,53,54', '5', '1587476727', '53');
INSERT INTO `ob_topic` VALUES ('7', '1+5 = ？', '99,100,101,102,103,104', '6', '1587476884', '101');
INSERT INTO `ob_topic` VALUES ('8', '1+7 = ?', '63,64,65', '8', '1587476924', '65');
INSERT INTO `ob_topic` VALUES ('9', '1+9 = ?', '66,67,68', '10', '1587476946', '68');
INSERT INTO `ob_topic` VALUES ('10', '1*1 = ?', '69,70,71', '1', '1587476966', '69');
INSERT INTO `ob_topic` VALUES ('11', '1*2 = ?', '72,73,74', '2', '1587476986', '73');
INSERT INTO `ob_topic` VALUES ('12', '1*3 = ?', '75,76,77', '3', '1587477003', '77');
INSERT INTO `ob_topic` VALUES ('18', '1*4 = ？', '105,106,107,108,109,110', '4', '1587520720', '109');
INSERT INTO `ob_topic` VALUES ('19', '1*5 = ?', '111,112,113,114,115', '5', '1587520720', '114');
INSERT INTO `ob_topic` VALUES ('20', '1*6 = ？', '116,117,118,119,120', '6', '1587520720', '120');
INSERT INTO `ob_topic` VALUES ('21', '1*7 = ？', '121,122,123', '7', '1587520721', '122');
INSERT INTO `ob_topic` VALUES ('22', '1*8 = ？', '124,125', '8', '1587520721', '124');
INSERT INTO `ob_topic` VALUES ('23', '1*9 = ？', '126,127', '9', '1587520721', '127');
INSERT INTO `ob_topic` VALUES ('24', '1*10 = ？', '128,129,130', '10', '1587520721', '128');
INSERT INTO `ob_topic` VALUES ('26', '2*1', '131,132,133,134,135,136', '2', '1587543692', '131');
INSERT INTO `ob_topic` VALUES ('27', '2*2', '137,138,139,140,141', '4', '1587543693', '137');
INSERT INTO `ob_topic` VALUES ('28', '2*3', '142,143,144,145,146', '6', '1587543693', '142');
INSERT INTO `ob_topic` VALUES ('29', '2*4', '147,148,149,150', '8', '1587543693', '147');
INSERT INTO `ob_topic` VALUES ('30', '2*5', '151,152,153,154', '10', '1587543693', '151');
INSERT INTO `ob_topic` VALUES ('31', '2*6', '155,156,157,158,159', '12', '1587543694', '155');
INSERT INTO `ob_topic` VALUES ('32', '2*7', '160,161,162,163,164,165', '14', '1587543694', '160');
INSERT INTO `ob_topic` VALUES ('33', '2*8', '166,167,168,169,170', '16', '1587543694', '166');
INSERT INTO `ob_topic` VALUES ('34', '2*9', '171,172,173,174,175', '18', '1587543694', '171');
INSERT INTO `ob_topic` VALUES ('35', '2*10', '176,177,178,179,180', '20', '1587543695', '176');
INSERT INTO `ob_topic` VALUES ('36', '2*11', '181,182,183,184,185', '22', '1587543695', '181');
INSERT INTO `ob_topic` VALUES ('37', '3*1', '186,187,188,189,190,191', '3', '1587543695', '186');
INSERT INTO `ob_topic` VALUES ('38', '3*2', '192,193,194,195,196,197', '6', '1587543695', '192');
INSERT INTO `ob_topic` VALUES ('39', '3*3', '198,199,200,201,202', '9', '1587543695', '198');
INSERT INTO `ob_topic` VALUES ('40', '3*4', '203,204,205,206,207', '12', '1587543696', '203');
INSERT INTO `ob_topic` VALUES ('41', '2*1 =', '208,209,210,211,212,213', '2', '1587543783', '208');
INSERT INTO `ob_topic` VALUES ('42', '2*2 =', '214,215,216,217,218', '4', '1587543784', '214');
INSERT INTO `ob_topic` VALUES ('43', '2*3 =', '219,220,221,222,223', '6', '1587543784', '219');
INSERT INTO `ob_topic` VALUES ('44', '2*4  =', '224,225,226,227', '8', '1587543784', '224');
INSERT INTO `ob_topic` VALUES ('45', '2*5 =', '228,229,230,231', '10', '1587543785', '228');
INSERT INTO `ob_topic` VALUES ('46', '2*6 =', '232,233,234,235,236', '12', '1587543785', '232');
INSERT INTO `ob_topic` VALUES ('47', '2*7 =', '237,238,239,240,241,242', '14', '1587543785', '237');
INSERT INTO `ob_topic` VALUES ('48', '2*8 =', '243,244,245,246,247', '16', '1587543785', '243');
INSERT INTO `ob_topic` VALUES ('49', '2*9 =', '248,249,250,251,252', '18', '1587543786', '248');
INSERT INTO `ob_topic` VALUES ('50', '2*10 =', '253,254,255,256,257', '20', '1587543786', '253');
INSERT INTO `ob_topic` VALUES ('51', '2*11 =', '258,259,260,261,262', '22', '1587543786', '258');
INSERT INTO `ob_topic` VALUES ('52', '3*1 = ', '263,264,265,266,267,268', '3', '1587543786', '263');
INSERT INTO `ob_topic` VALUES ('53', '3*2 =', '269,270,271,272,273,274', '6', '1587543787', '269');
INSERT INTO `ob_topic` VALUES ('54', '3*3 =', '275,276,277,278,279', '9', '1587543787', '275');
INSERT INTO `ob_topic` VALUES ('55', '3*4 =', '280,281,282,283,284', '12', '1587543787', '280');
INSERT INTO `ob_topic` VALUES ('56', '2*1= ？', '285,286,287,288,289,290', '2', '1587543829', '285');
INSERT INTO `ob_topic` VALUES ('57', '2*2= ？', '291,292,293,294,295', '4', '1587543829', '291');
INSERT INTO `ob_topic` VALUES ('58', '2*3= ？', '296,297,298,299,300', '6', '1587543829', '296');
INSERT INTO `ob_topic` VALUES ('59', '2*4 = ？', '301,302,303,304', '8', '1587543830', '301');
INSERT INTO `ob_topic` VALUES ('60', '2*5= ？', '305,306,307,308', '10', '1587543830', '305');
INSERT INTO `ob_topic` VALUES ('61', '2*6= ？', '309,310,311,312,313', '12', '1587543830', '309');
INSERT INTO `ob_topic` VALUES ('62', '2*7= ？', '314,315,316,317,318,319', '14', '1587543830', '314');
INSERT INTO `ob_topic` VALUES ('63', '2*8= ？', '320,321,322,323,324', '16', '1587543831', '320');
INSERT INTO `ob_topic` VALUES ('64', '2*9= ？', '325,326,327,328,329', '18', '1587543832', '325');
INSERT INTO `ob_topic` VALUES ('65', '2*10= ？', '330,331,332,333,334', '20', '1587543832', '330');
INSERT INTO `ob_topic` VALUES ('66', '2*11= ？', '335,336,337,338,339', '22', '1587543832', '335');
INSERT INTO `ob_topic` VALUES ('67', '3*1= ？ ', '340,341,342,343,344,345', '3', '1587543832', '340');
INSERT INTO `ob_topic` VALUES ('68', '3*2= ？', '346,347,348,349,350,351', '6', '1587543833', '346');
INSERT INTO `ob_topic` VALUES ('69', '3*3= ？', '352,353,354,355,356', '9', '1587543833', '352');
INSERT INTO `ob_topic` VALUES ('70', '3*4= ？', '357,358,359,360,361', '12', '1587543833', '357');
INSERT INTO `ob_topic` VALUES ('71', '2*1= ？？', '362,363,364,365,366,367', '2', '1587543901', '362');
INSERT INTO `ob_topic` VALUES ('72', '2*2= ？？', '368,369,370,371,372', '4', '1587543901', '368');
INSERT INTO `ob_topic` VALUES ('73', '2*3= ？？', '373,374,375,376,377', '6', '1587543902', '373');
INSERT INTO `ob_topic` VALUES ('74', '2*4 = ？？', '378,379,380,381', '8', '1587543902', '378');
INSERT INTO `ob_topic` VALUES ('75', '2*5= ？？', '382,383,384,385', '10', '1587543902', '382');
INSERT INTO `ob_topic` VALUES ('76', '2*6= ？？', '386,387,388,389,390', '12', '1587543902', '386');
INSERT INTO `ob_topic` VALUES ('77', '2*7= ？？', '391,392,393,394,395,396', '14', '1587543903', '391');
INSERT INTO `ob_topic` VALUES ('78', '2*8= ？？', '397,398,399,400,401', '16', '1587543903', '397');
INSERT INTO `ob_topic` VALUES ('79', '2*9= ？？', '402,403,404,405,406', '18', '1587543903', '402');
INSERT INTO `ob_topic` VALUES ('80', '2*10= ？？', '407,408,409,410,411', '20', '1587543904', '407');
INSERT INTO `ob_topic` VALUES ('81', '2*11= ？？', '412,413,414,415,416', '22', '1587543904', '412');
INSERT INTO `ob_topic` VALUES ('82', '3*1= ？ ？', '417,418,419,420,421,422', '3', '1587543904', '417');
INSERT INTO `ob_topic` VALUES ('83', '3*2= ？？', '423,424,425,426,427,428', '6', '1587543904', '423');
INSERT INTO `ob_topic` VALUES ('84', '3*3= ？？', '429,430,431,432,433', '9', '1587543905', '429');
INSERT INTO `ob_topic` VALUES ('85', '3*4= ？？', '434,435,436,437,438', '12', '1587543905', '434');
INSERT INTO `ob_topic` VALUES ('86', '1', '439,440,441,442,443,444', '1', '1587544192', '439');
INSERT INTO `ob_topic` VALUES ('87', '2', '445,446,447,448,449', '2', '1587544192', '446');
INSERT INTO `ob_topic` VALUES ('88', '3', '450,451,452,453,454', '3', '1587544192', '451');
INSERT INTO `ob_topic` VALUES ('89', '4', '455,456,457,458', '4', '1587544193', '456');
INSERT INTO `ob_topic` VALUES ('90', '5', '459,460,461,462', '5', '1587544193', '461');
INSERT INTO `ob_topic` VALUES ('91', '6', '463,464,465,466,467', '6', '1587544193', '466');
INSERT INTO `ob_topic` VALUES ('92', '7', '468,469,470,471,472,473', '7', '1587544193', '472');
INSERT INTO `ob_topic` VALUES ('93', '8', '474,475,476,477,478', '8', '1587544194', '477');
INSERT INTO `ob_topic` VALUES ('94', '9', '479,480,481,482,483', '9', '1587544194', '482');
INSERT INTO `ob_topic` VALUES ('95', '10', '484,485,486,487,488', '10', '1587544194', '487');
INSERT INTO `ob_topic` VALUES ('96', '11', '489,490,491,492,493', '11', '1587544194', '491');
INSERT INTO `ob_topic` VALUES ('97', '12', '494,495,496,497,498,499', '12', '1587544195', '496');
INSERT INTO `ob_topic` VALUES ('98', '13', '500,501,502,503,504,505', '13', '1587544195', '503');
INSERT INTO `ob_topic` VALUES ('99', '14', '506,507,508,509,510', '14', '1587544195', '509');
INSERT INTO `ob_topic` VALUES ('100', '15', '511,512,513,514,515', '15', '1587544196', '515');
INSERT INTO `ob_topic` VALUES ('101', '16', '516,517,518,519,520,521', '16', '1587544196', '520');
INSERT INTO `ob_topic` VALUES ('102', '17', '522,523,524,525,526,527', '17', '1587544196', '526');
INSERT INTO `ob_topic` VALUES ('103', '18', '528,529,530,531,532,533', '18', '1587544196', '532');
INSERT INTO `ob_topic` VALUES ('104', '19', '534,535,536,537,538,539', '19', '1587544197', '538');
INSERT INTO `ob_topic` VALUES ('105', '20', '540,541,542,543,544,545', '20', '1587544197', '544');
INSERT INTO `ob_topic` VALUES ('106', '21', '546,547,548,549,550', '21', '1587544197', '550');
INSERT INTO `ob_topic` VALUES ('109', '23', '557,558,559,560', '23', '1587544312', '560');
INSERT INTO `ob_topic` VALUES ('110', '24', '561,562,563,564', '24', '1587544312', '564');
INSERT INTO `ob_topic` VALUES ('111', '25', '565,566,567,568', '25', '1587544313', '568');
INSERT INTO `ob_topic` VALUES ('112', '26', '569,570,571,572', '26', '1587544313', '572');
INSERT INTO `ob_topic` VALUES ('113', '27', '573,574,575,576', '27', '1587544313', '576');
INSERT INTO `ob_topic` VALUES ('114', '28', '577,578,579,580', '28', '1587544313', '580');
INSERT INTO `ob_topic` VALUES ('115', '29', '581,582,583,584', '29', '1587544313', '584');
INSERT INTO `ob_topic` VALUES ('117', '1*4 =', '585,586,587,588,589,590', '4', '1587544431', '589');
INSERT INTO `ob_topic` VALUES ('118', '1*5 =', '591,592,593,594,595', '5', '1587544431', '594');
INSERT INTO `ob_topic` VALUES ('119', '1*6 =', '596,597,598,599,600', '6', '1587544431', '600');
INSERT INTO `ob_topic` VALUES ('120', '1*7 =', '601,602,603', '7', '1587544432', '602');
INSERT INTO `ob_topic` VALUES ('121', '1*8 =', '604,605', '8', '1587544432', '604');
INSERT INTO `ob_topic` VALUES ('122', '1*9 =', '606,607', '9', '1587544432', '607');
INSERT INTO `ob_topic` VALUES ('123', '1*10 =', '608,609,610', '10', '1587544432', '608');

-- ----------------------------
-- Table structure for ob_user
-- ----------------------------
DROP TABLE IF EXISTS `ob_user`;
CREATE TABLE `ob_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0禁用/1启动(暂时用不到一直为1即可)',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数/暂时用不到',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `phone` int(11) DEFAULT NULL COMMENT '电话号',
  `gender` int(4) DEFAULT '0' COMMENT '性别/0男/1女',
  `topic_id` int(11) DEFAULT NULL COMMENT '答题id/暂时用不到',
  `award_id` int(11) DEFAULT NULL COMMENT '抽奖id/暂时用不到',
  `share` varchar(255) DEFAULT NULL COMMENT '分享次数/暂时用不到',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2022 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员';

-- ----------------------------
-- Records of ob_user
-- ----------------------------
INSERT INTO `ob_user` VALUES ('2021', 'admin', '123456', '1', '0', '1587648927', '1509047762', '0', null, null, null);
