-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2023 at 09:53 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ims`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `name_id` int(11) NOT NULL,
  `contents` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `name_id`, `contents`) VALUES
(1, 12, 'i requested material but still didn\'t get aproved message '),
(2, 12, 'hello peter'),
(3, 12, 'hello peter'),
(4, 13, 'you are dead'),
(5, 12, 'nonese mwambonera zingahe?'),
(6, 12, 'nonese mwambonera zingahe?');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(244) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `item_serial_number` varchar(255) NOT NULL,
  `item_quantity` varchar(255) NOT NULL,
  `item_category` varchar(255) NOT NULL,
  `item_status` varchar(255) NOT NULL,
  `availablity` varchar(22) NOT NULL DEFAULT 'available',
  `item_location` varchar(255) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `borrowed_to` varchar(255) NOT NULL DEFAULT 'not borrowed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `item_name`, `item_code`, `item_serial_number`, `item_quantity`, `item_category`, `item_status`, `availablity`, `item_location`, `date_registered`, `borrowed_to`) VALUES
(1, 'PRINTER', 'PU4343ACSGF', 'HGFSHAF5W6Q', '123PCS', 'non-consumables', 'work but has some defects', 'not available', 'netlab', '2023-04-26 10:44:09', 'jimmy'),
(2, 'positivo', 'tp209156', 'wewfef2', '23', 'non-consumables', 'work well', 'not available', 'lab6', '2023-04-26 10:36:39', 'not borrowed'),
(3, 'laptop', 'cu108', '3626fag', '12', 'non-consumables', 'work well', 'available', 'lab6', '2023-04-24 22:12:14', 'not borrowed'),
(6, 'desktop', 'Cu008', 'wewfef2', '1', 'non-consumables', 'not functioning', 'available', 'lab7', '2023-04-17 14:20:31', 'not borrowed'),
(8, 'cable', 'tp209156', 'wewfef2', '1200', 'consumables', '', 'available', 'netlab', '2023-04-24 22:09:33', 'not borrowed'),
(9, 'monitor', 'cu105', 'se12452v', '1', 'non-consumables', 'work well', 'not available', 'lab7', '2023-04-26 14:00:15', 'vainqueur'),
(11, 'switch 2960', 'sw009', 'zadbiw', '', 'non-consumables', 'functioning well', 'available', 'server_room_1', '2023-04-18 19:34:03', 'not borrowed'),
(13, 'data sockect', '', '', '1246', 'consumables', '', 'available', 'netlab', '2023-04-19 10:57:37', 'not borrowed'),
(14, 'data sockect', '', '', '846', 'consumables', '', 'available', 'Stock', '2023-04-19 10:56:37', 'not borrowed'),
(15, 'data sockect', '', '', '100', 'consumables', '', 'available', 'Lab1', '2023-04-19 10:58:43', 'not borrowed'),
(17, 'plugs', '', '', '1100', 'consumables', '', 'available', 'netlab', '2023-04-26 12:49:47', 'not borrowed'),
(18, 'plugs', '', '', '300', 'consumables', '', 'available', 'Stock', '2023-04-26 08:41:37', 'not borrowed'),
(19, '', '', '', '', '', '', 'available', '', '0000-00-00 00:00:00', 'not borrowed'),
(20, '', '', '3CB02223LW', '', '', '', 'available', '', '0000-00-00 00:00:00', 'not borrowed'),
(21, 'HP', 'CZC1236KJN3', 'TRF1320F8R', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(22, 'HP', 'TRF4250LL1', '4CE109077V', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(23, 'HP', 'TRF2360CYC', '3CB02379W', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(24, 'HP', 'password', '4CE10907PY', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(25, 'HP ', 'CZC72187DW', 'SGH208TQF4', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(26, 'HP', 'CZC71784PX', 'TRF4100VT9', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(27, 'COMPAQ', 'CZC71784GV', '3CB93225LC', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(28, 'COMPAQ', 'CZC7218DK8', 'CZC7119CPP', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(29, 'HP', 'CZC7218HTV', '25LQJBX', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(30, 'HP', 'CZC71784NC', 'CZC04500FB', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(31, 'COMPAQ', 'CZC7218HXJ', 'FZC0NN1', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(32, 'HP', 'CZC71784P8', '3CB93226XY', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(33, 'DELL', 'CZC7218J96', '3LG5Q1S', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(34, 'HP', 'CZC7218J3S', 'TRF20409FM', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(35, 'DELL', 'CZC72187GM', 'TRF2060M56', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(36, 'COMPAQ', 'CZC71784PQ', '3CB02620ZZ', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(37, 'DELL', 'CZC71784PY', 'TRF1320CMX', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(38, 'HP', 'CZC7218J8V', '3CB02225SH', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(39, 'HP', 'CZC71784PN', 'TRF1320CG5', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(40, 'HP', 'CZC71784VR', '3CB03127J1', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(41, 'HP', 'CZC721874R', 'SGH208GQ6B', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(42, 'HP', 'CZC71784PW', 'SGH208TQD7', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(43, 'HP', 'CZC72187MQ', 'TRF4140BQK', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(44, 'HP', 'CZC72180Q0', 'TRF2320CTW', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(45, 'HP', 'CZC71784FT', 'TRF233012Z', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(46, 'HP', 'CZC7218HXL', 'TRF4100VTR', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(47, 'HP', 'CZC717849W', 'TRF3240FXZ', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(48, 'HP', 'CZC7218JH2', 'TRF33503CK', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(49, 'HP', 'CZC71784NN', 'TRF2200VNF', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(50, 'HP', 'CZC71784F1', '2102313200107A000013', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(51, 'HP', 'CZC72187FZ', '2102313200107A000102', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(52, 'HP', 'CZC71784PL', '2102313200107A000054', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(53, 'HP', 'CZC72187FR', '2102313200107A000007', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(54, 'HUAWEI', 'CZC72187FS', '2102313200107A000015', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(55, 'HUAWEI', 'CZC72187FM', '2102313200107A000081', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(56, 'HUAWEI', 'CZC71784PJ', '2102313200107A000034', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(57, 'HUAWEI', 'CZC7218DK6', '2102313200107A000011', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(58, 'HUAWEI', 'CZC72183DF', '2102313200107A000075', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(59, 'HUAWEI', 'CZC72187CJ', '2102313200107A000017', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(60, 'HUAWEI', 'CZC71784YD', '2102313200107A000077', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(61, 'HUAWEI', 'CZC7218DLF', '2102313200107A000017', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(62, 'HUAWEI', 'CZC71784XM', '2102313200107A000109', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(63, 'HUAWEI', 'CZC7218DMC', '2102313200107A000028', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(64, 'HUAWEI', 'CZC7218G9C', '2102313200107A000073', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(65, 'HUAWEI', 'CZC7178478', '2102313200107A000002', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(66, 'HUAWEI', 'CZC71784P5', '2102313200107A000001', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(67, 'HUAWEI', 'CZC71784Q1', '2102313200107A000021', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(68, 'HUAWEI', 'CZC71784LS', '2102313200107A000094', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(69, 'HUAWEI', 'CZC7218JBQ', '2102313200107A000014', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(70, 'HUAWEI', '3CQ614042H', '2102313200107A000058', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(71, 'HUAWEI', '3CQ6101D27', '2102313200107A000003', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(72, 'HUAWEI', '3CQ614044B', '2102313200107A000012', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(73, 'HUAWEI', '3CQ6100ZYW', '2102313200107A000019', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(74, 'HUAWEI', '3CQ6101CBX', '2102313200107A000055', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(75, 'HUAWEI', '3CQ6101DOS', '2102313200107A000039', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(76, 'HUAWEI', '3CQ614043P', '2102313200107A000075', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(77, 'HUAWEI', '3CQ6100ZYL', '2102313200107A000020', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(78, 'HUAWEI', '3CQ6101C8N', '2102313200107A000082', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(79, 'HUAWEI', '3CQ6100ZYZ', '2102313200107A000029', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(80, 'HUAWEI', '3CQ6101D18', '2102313200107A000036', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(81, 'HUAWEI', '3CQ6101D2W', '2102313200107A000071', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(82, 'HUAWEI', '3CQ6101D2C', '2102313200107A000033', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(83, 'HUAWEI', '3CQ6101D17', '2102313200107A000043', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(84, 'HUAWEI', '3CQ6100ZXN', '2102313200107A000050', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(85, 'HUAWEI', '3CQ6071BOM', '2102313200107A000047', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(86, 'HUAWEI', '3CQ6100ZZ3', '2102313200107A000083', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(87, 'HUAWEI', '3CQ6101CZS', '2102313200107A000080', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(88, 'HUAWEI', '3CQ6071B1L', '7004952829', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(89, 'HUAWEI', '3CQ6101D10', 'C100B000319', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(90, 'HUAWEI', '3CQ6071CFF', '5078032', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(91, 'HUAWEI', '3CQ61007Y2', 'LQ19FC800018', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(92, 'SONY', '3CQ614042L', 'LMMAA32', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(93, 'BCS', '3CQ6101C9M', 'TRF612081C', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(94, 'SONY', '3CQ6101D14', '3CB0312762', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(95, 'ZTE', 'CU 051', '3CB0312719', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(96, 'LENOVO', 'CU 049', 'TRF2220DH4', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(97, 'HP', 'CZC72187DW', '3CB0312792', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(98, 'HP', 'CZC71784PX', 'TRF612081G', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(99, 'HP', 'CZC71784GV', '3CB031223Z', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(100, 'HP', 'CZC7218DK8', '3CB0312832', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(101, 'HP', 'CZC7218HTV', '3CB03127YQ', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(102, 'HP', 'CZC71784NC', '3CB0312767', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(103, 'HP', 'CZC7218HXJ', '210253729', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(104, 'HP', 'CZC71784P8', 'RW800001114', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(105, 'HP', 'CZC7218J96', 'LMLRY94', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(106, 'HP', 'CZC7218J3S', 'FZ40NN1', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(107, 'AVOCENT', 'CZC72187GM', 'L86180B6JVQ29L', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(108, 'INFORMAK', 'CZC71784PQ', '43458407228', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(109, 'LENOVO', 'CZC71784PY', 'HUB403054L', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(110, 'DELL', 'CZC7218J8V', '9QB0TC1', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(111, 'HP', 'CZC71784PN', 'LMLRZ27', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(112, 'HP', 'CZC71784VR', 'LMWWRV0', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(113, 'HP', 'CZC721874R', 'LMLRY61', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(114, 'HP', 'CZC71784PW', 'LMLRZ42', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(115, 'LENOVO', 'CZC72187MQ', 'LMBAPZ1', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(116, 'LENOVO', 'CZC72180Q0', '3CB02225RY', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(117, 'LENOVO', 'CZC71784FT', '4CE412065C', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(118, 'LENOVO', 'CZC7218HXL', '3CB03127ZV', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(119, 'LENOVO', 'CZC717849W', 'TRF1320CHZ', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(120, 'HP', 'CZC7218JH2', 'TRF1320CLW', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(121, 'HP', 'CZC71784NN', 'TRF4250LFR', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(122, 'HP', 'CZC71784F1', 'TRF4250LBO', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(123, 'HP', 'CZC72187FZ', 'TRF41010JF', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(124, 'HP', 'CZC71784PL', '3CB908211J', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(125, 'HP', 'CZC72187FR', 'TRF612085X', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(126, 'HP', 'CZC72187FS', 'Q91D1F5000019', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(127, 'HP', 'CZC72187FM', 'Q91D1F5000392', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(128, 'HP', '3CQ614042H', '', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(129, 'HP', '3CQ6101D27', '', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(130, 'D-LINK', '3CQ614044B', '', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed'),
(131, 'D-LINK', '3CQ6100ZYW', '', '', 'non-consumables', 'work well', 'available', 'netlab', '0000-00-00 00:00:00', 'not borrowed');

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phone` varchar(14) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `purpose` varchar(255) NOT NULL,
  `status` varchar(7) NOT NULL DEFAULT 'Pending',
  `message` varchar(255) NOT NULL DEFAULT 'you request is not approved yet'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`id`, `user_id`, `phone`, `item_name`, `item_quantity`, `purpose`, `status`, `message`) VALUES
(1, 12, '07856446', 'data socket', 100, '', 'approve', ''),
(2, 13, '4678648', 'data cables', 100, '', 'approve', 'your request have been approved, you should come to our office to take what you requested!'),
(3, 12, '', '', 0, '', 'rejecte', 'your request is reject due to unavailablity of item you requested'),
(4, 12, '07856446', 'data socket', 500, '', 'approve', 'your request have been approved, you should come to our office to take what you requested!'),
(5, 22, '07856446', 'data cables', 100, '', 'approve', 'your request have been approved, you should come to our office to take what you requested!'),
(6, 12, '078842415', 'plugs', 100, '', 'rejecte', 'your request is reject due to unavailablity of item you requested'),
(7, 25, '07203655', 'computer', 1, '', 'approve', 'your request have been approved, you should come to our office to take what you requested!'),
(8, 25, '0788641641', 'monitor', 1, '', 'rejecte', 'your request is reject due to unavailablity of item you requested'),
(12, 12, '654544', 'computer', 1, 'for using in research', 'rejecte', 'your request is reject due to unavailablity of item you requested'),
(13, 25, '078832536', 'monitor', 1, 'for using in research', 'rejecte', 'your request is reject due to unavailablity of item you requested'),
(14, 25, '9132840', 'x', 1, 'for research', 'rejecte', 'your request is reject due to unavailablity of item you requested'),
(15, 25, '078853235', 'monitor', 1, 'for using in research', 'rejecte', 'your request is reject due to unavailablity of item you requested');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(22) NOT NULL,
  `password` varchar(255) NOT NULL,
  `job_position` varchar(255) NOT NULL,
  `profile_img` varchar(100) NOT NULL DEFAULT '0.jpeg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `password`, `job_position`, `profile_img`) VALUES
(10, 'peter', 'Manzi', 'peterofficial21@gmail.com', '0788641641', 'pbkdf2:sha256:260000$5NRZIIq4rTz1lbxZ$c1a5872a497593a07217ee72b503f8744a346d44c14a8ba574c91fdabdeabdd9', 'Admin', '20RP07406.jpg'),
(12, 'Giramata', 'tecla', 'gigtekilah2311@gmail.com', '+250788623055', 'pbkdf2:sha256:260000$ijVhoaunGjIkz4DT$8d61f91ce49be5a92b0c87152ad92b9ab623d84acd969f8a4d46a89fee7abce2', 'student', '20RP00553.JPG'),
(13, 'regis', 'jehovanis', 'regis1@gmail.com', '+250788964280', 'pbkdf2:sha256:260000$vxrjrbWo1L6yBAXj$b5f03bdd1e47017e9874f0706a58b1555e55dc2f68673d6cf32db665f9618e88', 'student', '20RP07102.jpg'),
(22, 'JMV', 'Gtan', 'gtan@gmail.com', '+250788623055', 'pbkdf2:sha256:260000$2Veasjb27l8BVv5F$b0c46c4f90bb1576c8969ff3c3feed5f2fcb42aa22d2af2b33144650fff2f878', 'student', '20rp08967.jpg'),
(24, 'Uwizeyimana', 'Innocent', 'khalidinnocent2020@gmail.com', '', 'pbkdf2:sha256:260000$uyY3jd9KRgO56NEA$4839cda5f4749a9809ad428f2e5d7751803a43a4c73393526f20e79633506dfc', 'Logistic', '0.jpeg'),
(25, 'vainqueur', 'ernest', 'vainqueur1122@gmail.com', '07826', 'pbkdf2:sha256:260000$W04lUXcqv6j9PA4g$9b1fd464f6bbae0abc44fa727659c5ced9d2411cf1ec0dad5ae7229fe026a694', 'lecturer', '20RP00059.JPG'),
(26, 'faustin', 'Iradukunda', 'ifaustin89@gmail.com', '', 'pbkdf2:sha256:260000$L0XRWpF2xzZgIyPV$05006ada55e8b4f37fc39a46680837eb6913880759bf8f8a3247002ec3f587e6', 'Admin', '0.jpeg'),
(27, 'MUVANDIMWE', 'Anastase', 'anastase@gmail.com', '0788964280', 'pbkdf2:sha256:260000$Te3Rq63rKMLCCpvt$7acb6689a7b40ccd14fc2e8f9797d7ebe3c1af1ecb88f58494ec116f85529392', 'lecturer', '20RP0329.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name_id` (`name_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`name_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
