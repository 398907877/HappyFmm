/*
Navicat MySQL Data Transfer

Source Server         : wujiajun
Source Server Version : 50532
Source Host           : 10.10.10.15:3306
Source Database       : jeesite

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2017-05-13 22:49:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_user_new
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_new`;
CREATE TABLE `sys_user_new` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `company_id` varchar(64) NOT NULL COMMENT '归属公司',
  `office_id` varchar(64) NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) NOT NULL COMMENT '登录名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `no` varchar(100) DEFAULT NULL COMMENT '工号',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机',
  `user_type` char(1) DEFAULT NULL COMMENT '用户类型',
  `photo` varchar(1000) DEFAULT NULL COMMENT '用户头像',
  `login_ip` varchar(100) DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `login_flag` varchar(64) DEFAULT NULL COMMENT '是否可登录',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `level` varchar(255) DEFAULT NULL COMMENT '等级（1级  2级 什么农 ）',
  `wkf` varchar(255) DEFAULT NULL COMMENT '挖矿分=奖金分',
  `jhf` varchar(255) DEFAULT NULL COMMENT '激活分',
  `qzf` varchar(255) DEFAULT NULL COMMENT '权证分',
  `zyy` varchar(255) DEFAULT NULL COMMENT '滋养液',
  `gwf` varchar(255) DEFAULT NULL COMMENT '购物分',
  `yxf` varchar(255) DEFAULT NULL COMMENT '游戏分',
  `happyfood` varchar(255) DEFAULT NULL COMMENT '实际开心果',
  `happyfoodsum` varchar(255) DEFAULT NULL COMMENT '开心果总量',
  `recommender` varchar(255) DEFAULT NULL COMMENT '推荐人（如果是当前用户就是自己，也可以输入任意系统中的id）',
  `linkperson` varchar(255) DEFAULT NULL COMMENT '接点人（就是树的上级id）',
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表-  to use  this  project ';
