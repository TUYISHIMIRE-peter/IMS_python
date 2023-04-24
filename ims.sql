-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2023 at 08:42 PM
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
(4, 13, 'you are dead');

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
  `item_location` varchar(255) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `item_name`, `item_code`, `item_serial_number`, `item_quantity`, `item_category`, `item_status`, `item_location`, `date_registered`) VALUES
(1, 'PRINTER', 'PU4343ACSGF', 'HGFSHAF5W6Q', '123PCS', 'non-consumables', 'functioning', 'lab5', '2023-04-16 15:43:55'),
(2, 'eeeeee', 'tp209156', 'wewfef2', '23', '1', 'work well', 'lab6', '2023-04-16 21:00:27'),
(3, 'laptop', 'cu108', '3626fag', '12', '1', 'work well', 'lab6', '2023-04-16 22:50:24'),
(4, 'climping', 'cl00977', 'zadbiw', '120', 'non-consumables', 'work well', 'netlab', '2023-04-17 12:15:03'),
(5, 'RJ-45', '', '', '140', 'consumables', 'work well', 'netlab', '2023-04-17 13:11:26'),
(6, 'desktop', 'Cu008', 'wewfef2', '1', 'non-consumables', 'not functioning', 'lab7', '2023-04-17 14:20:31'),
(8, 'cable', 'tp209156', 'wewfef2', '100', 'consumables', 'work well', 'netlab', '2023-04-17 14:26:26'),
(9, 'monitor', 'cu105', 'se12452v', '1', 'non-consumables', 'work well', 'lab7', '2023-04-18 17:46:03'),
(11, 'switch 2960', 'sw009', 'zadbiw', '', 'non-consumables', 'functioning well', 'server_room_1', '2023-04-18 19:34:03'),
(12, '', '', '', '', 'select category', 'functioning well', 'Lab1', '2023-04-18 19:54:33'),
(13, 'data sockect', '', '', '1246', 'consumables', '', 'netlab', '2023-04-19 10:57:37'),
(14, 'data sockect', '', '', '846', 'consumables', '', 'Stock', '2023-04-19 10:56:37'),
(15, 'data sockect', '', '', '100', 'consumables', '', 'Lab1', '2023-04-19 10:58:43');

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
  `status` varchar(7) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`id`, `user_id`, `phone`, `item_name`, `item_quantity`, `status`) VALUES
(1, 12, '07856446', 'data socket', 100, 'Approve'),
(2, 13, '4678648', 'data cables', 100, 'Pending'),
(3, 12, '', '', 0, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `job_position` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `job_position`) VALUES
(9, 'jado', 'mustapha', 'mustapha@gmail.com', 'pbkdf2:sha256:260000$8TKJZUF5G0mSqeNA$a702aadf7a9f7b435d7282815731f24b0b5ca606563316438a27dc5db339a675', 'lecturer'),
(10, 'peter', 'TUYISHIMIRE ', 'peterofficial21@gmail.com', 'pbkdf2:sha256:260000$3t37OhnLG38DMxZn$3cc798eca4b7af584311a69a28e907cbd4b2189aa0b499461b53c323c16b7439', 'Admin'),
(12, 'Giramata', 'tecla', 'gigtekilah2311@gmail.com', 'pbkdf2:sha256:260000$0Rw8PNEAOppCVI63$7a8d341249abee69b4751208dd57b0c9ea0f1847343a9edc0daaca5074f57809', 'student'),
(13, 'regis', 'jehovanis', 'regis@gmail.com', 'pbkdf2:sha256:260000$hOG7q32OvyXW2ZBH$536ccb538676685f73823cabe284d2911cd83d09f3625d5046bbd038b8e97c64', 'student');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
