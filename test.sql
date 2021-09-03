-- Adminer 4.6.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `additional_field_values`;
CREATE TABLE `additional_field_values` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `additional_field_id` int unsigned NOT NULL,
  `name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `textile_filed_id` (`additional_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `additional_field_values` (`id`, `additional_field_id`, `name`, `is_deleted`, `modified_at`) VALUES
(1,	1,	'Red',	0,	'2020-11-30 15:41:07'),
(2,	1,	'Green',	0,	'2020-11-30 15:41:14'),
(3,	2,	'S',	0,	'2020-11-30 15:41:25'),
(4,	2,	'M',	0,	'2020-11-30 15:41:25'),
(5,	2,	'L',	0,	'2020-11-30 15:41:25');

DROP TABLE IF EXISTS `additional_fields`;
CREATE TABLE `additional_fields` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sort_no` int NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `additional_fields` (`id`, `name`, `sort_no`, `alias`, `is_deleted`, `modified_at`) VALUES
(1,	'Color',	1,	'color',	0,	'2020-11-30 15:40:26'),
(2,	'Size',	1,	'color',	0,	'2020-11-30 15:40:26');

DROP TABLE IF EXISTS `additional_goods_field_values`;
CREATE TABLE `additional_goods_field_values` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `good_id` int unsigned NOT NULL,
  `additional_field_id` int unsigned NOT NULL,
  `additional_field_value_id` int unsigned NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `good_id_2` (`good_id`,`additional_field_id`),
  KEY `good_id` (`good_id`),
  KEY `textile_filed_id` (`additional_field_id`),
  KEY `textile_filed_value_id` (`additional_field_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `additional_goods_field_values` (`id`, `good_id`, `additional_field_id`, `additional_field_value_id`, `is_deleted`, `modified_at`) VALUES
(1,	1,	1,	1,	0,	'2020-11-30 15:43:15'),
(2,	1,	2,	4,	0,	'2020-11-30 15:43:22'),
(3,	2,	1,	2,	0,	'2020-11-30 15:43:29'),
(4,	2,	2,	3,	0,	'2020-11-30 15:43:29');

DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `article` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double(12,2) NOT NULL,
  `ean` varchar(13) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `vat` float(5,2) unsigned NOT NULL DEFAULT '19.00',
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ean` (`ean`),
  KEY `article` (`article`),
  KEY `ean_mainsupplier` (`ean`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `goods` (`id`, `article`, `name`, `price`, `ean`, `vat`, `modified_at`) VALUES
(1,	'A123',	'test good 1',	45.00,	'4041388630126',	19.00,	'2020-11-27 09:11:19'),
(2,	'A124',	'test good 2',	45.00,	'9002859043062',	19.00,	'2020-11-27 09:11:19'),
(3,	'A125',	'test good 3',	5.50,	'4041388630126',	19.00,	'2020-11-27 09:11:19');

-- 2020-11-30 15:44:17
