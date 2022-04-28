/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : shangyi

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 28/04/2022 21:57:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for g_stock
-- ----------------------------
DROP TABLE IF EXISTS `g_stock`;
CREATE TABLE `g_stock`  (
  `g_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `g_barCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品条形码',
  `g_shelfLife` int(0) NOT NULL COMMENT '保质期',
  `g_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品类型',
  `s_num` int(0) UNSIGNED NOT NULL COMMENT '库存数量',
  `g_nuit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '单位',
  `g_Isexpired` int(1) UNSIGNED ZEROFILL NOT NULL COMMENT '是否过期',
  PRIMARY KEY (`g_barCode`) USING BTREE,
  INDEX `s_g_nameKey`(`g_name`) USING BTREE,
  INDEX `s_g_typeKey`(`g_type`) USING BTREE,
  INDEX `s_g_unitKey`(`g_nuit`) USING BTREE,
  INDEX `s_g_shelfLifeKey`(`g_shelfLife`) USING BTREE,
  CONSTRAINT `s_g_barCodeKey` FOREIGN KEY (`g_barCode`) REFERENCES `p_details` (`g_barCode`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `s_g_nameKey` FOREIGN KEY (`g_name`) REFERENCES `p_details` (`g_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `s_g_shelfLifeKey` FOREIGN KEY (`g_shelfLife`) REFERENCES `p_details` (`g_shelfLife`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `s_g_typeKey` FOREIGN KEY (`g_type`) REFERENCES `p_details` (`g_type`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `s_g_unitKey` FOREIGN KEY (`g_nuit`) REFERENCES `p_details` (`g_unit`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for p_details
-- ----------------------------
DROP TABLE IF EXISTS `p_details`;
CREATE TABLE `p_details`  (
  `transactionNo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易单号',
  `suppler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '供货商',
  `transactionDate` date NOT NULL COMMENT '交易日期',
  `g_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `g_barCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品条形码',
  `g_manufactureDate` date NOT NULL COMMENT '生产日期',
  `g_num` int(0) NOT NULL COMMENT '数量',
  `g_specifications` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规格',
  `g_unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '单位',
  `g_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品类型',
  `g_shelfLife` int(0) NOT NULL COMMENT '保质期',
  PRIMARY KEY (`g_barCode`) USING BTREE,
  INDEX `supplerKey`(`suppler`) USING BTREE,
  INDEX `transactionDateKey`(`transactionDate`) USING BTREE,
  INDEX `transactionNoKey`(`transactionNo`) USING BTREE,
  INDEX `g_name`(`g_name`) USING BTREE,
  INDEX `g_unit`(`g_unit`) USING BTREE,
  INDEX `g_manufactureDate`(`g_manufactureDate`) USING BTREE,
  INDEX `g_specifications`(`g_specifications`) USING BTREE,
  INDEX `g_type`(`g_type`) USING BTREE,
  INDEX `g_shelfLife`(`g_shelfLife`) USING BTREE,
  CONSTRAINT `supplerKey` FOREIGN KEY (`suppler`) REFERENCES `supplier` (`s_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transactionDateKey` FOREIGN KEY (`transactionDate`) REFERENCES `p_registration` (`transactionDate`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transactionNoKey` FOREIGN KEY (`transactionNo`) REFERENCES `p_registration` (`transactionNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for p_registration
-- ----------------------------
DROP TABLE IF EXISTS `p_registration`;
CREATE TABLE `p_registration`  (
  `transactionNo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易单号',
  `supplier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '供应商名',
  `p_category` int(0) NOT NULL COMMENT '商品种类数目',
  `transactionDate` date NOT NULL COMMENT '交易日期',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`transactionNo`) USING BTREE,
  INDEX `transactionDate`(`transactionDate`) USING BTREE,
  INDEX `r_supplierKey`(`supplier`) USING BTREE,
  CONSTRAINT `r_supplierKey` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`s_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for refund
-- ----------------------------
DROP TABLE IF EXISTS `refund`;
CREATE TABLE `refund`  (
  `g_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `g_barCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品条形码',
  `g_specifications` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规格',
  `transactionNo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易单号',
  `g_manufactureDate` date NOT NULL COMMENT '生产日期',
  `r_num` int(0) NOT NULL COMMENT '退货数量',
  `g_unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '单位',
  `r_date` date NOT NULL COMMENT '退货日期',
  PRIMARY KEY (`g_barCode`) USING BTREE,
  INDEX `r_g_nameKey`(`g_name`) USING BTREE,
  INDEX `r_g_specificationsKey`(`g_specifications`) USING BTREE,
  INDEX `r_ntransactionNoKey`(`transactionNo`) USING BTREE,
  INDEX `r_g_manufactureDateKey`(`g_manufactureDate`) USING BTREE,
  INDEX `r_g_unitKey`(`g_unit`) USING BTREE,
  CONSTRAINT `r_g_barCodeKey` FOREIGN KEY (`g_barCode`) REFERENCES `p_details` (`g_barCode`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `r_g_manufactureDateKey` FOREIGN KEY (`g_manufactureDate`) REFERENCES `p_details` (`g_manufactureDate`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `r_g_nameKey` FOREIGN KEY (`g_name`) REFERENCES `p_details` (`g_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `r_g_specificationsKey` FOREIGN KEY (`g_specifications`) REFERENCES `p_details` (`g_specifications`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `r_g_unitKey` FOREIGN KEY (`g_unit`) REFERENCES `p_details` (`g_unit`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `r_ntransactionNoKey` FOREIGN KEY (`transactionNo`) REFERENCES `p_registration` (`transactionNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `creditCode` varchar(255) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL COMMENT '统一社会信用代码',
  `s_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '供应商姓名',
  `s_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '供应商状态',
  `s_liaisoner` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人',
  `liaisonPhone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`creditCode`) USING BTREE,
  INDEX `s_name`(`s_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `phoneNum` varchar(11) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `password` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `isAdmain` int(0) NOT NULL DEFAULT 0 COMMENT '是否是管理员',
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
