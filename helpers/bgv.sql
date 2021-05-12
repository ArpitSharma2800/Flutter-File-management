-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2021 at 07:40 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bgv`
--

-- --------------------------------------------------------

--
-- Table structure for table `alert`
--

CREATE TABLE `alert` (
  `AlertId` varchar(255) NOT NULL,
  `FileName` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `alert`
--

INSERT INTO `alert` (`AlertId`, `FileName`, `userId`) VALUES
('130a77f5-35fd-40c5-9500-b4138d59e88b', 'ML101_Certificate.jpg', 'abcd1234'),
('476cdc72-e0e2-46ba-ae8b-dc31e945c90a', 'CSJ_Certificate.jpg', 'abcd1234'),
('67cf0de6-55c8-4b02-9855-d4df642d77cc', 'ML101_Certificate.jpg', 'abcd1234'),
('925633cf-7b75-4dce-a691-b2c0de33be5a', 'CSJ_Certificate.jpg', 'abcrf34'),
('c8d8805e-11c7-4bc0-8376-743f3fee8c20', 'SIH20Winner.png', 'abcd1234');

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `FilesId` varchar(255) NOT NULL,
  `FileLink` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`FilesId`, `FileLink`, `userId`) VALUES
('9f7cfa42-c7f4-44d5-9188-1acdec56a23a', 'CSJ_Certificate.jpg', 'abcd1234'),
('a946fac4-e9a1-4aa5-b4d5-efee3478bbe6', 'CSJ_Certificate.jpg', 'abcrf34'),
('bf6619a8-2e9c-4a48-bc64-7f6b530c43ba', 'sign.jpg', 'abcd1234'),
('c2f7b419-5c48-46dc-8820-e04feb5e04de', 'CSJ_Certificate.jpg', 'abcrf34'),
('e254f270-c6f3-460d-bd2c-e15f57dd9b2f', 'ML101_Certificate.jpg', 'abcd1234'),
('f342794d-e478-4a68-81ab-b4e4d691bed3', 'arpit', 'abcd1234');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userId` varchar(255) NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userId`, `userName`, `pwd`) VALUES
('abcd1234', 'Arpit', 'arpit'),
('abcrf34', 'TR', 'tr');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alert`
--
ALTER TABLE `alert`
  ADD PRIMARY KEY (`AlertId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`FilesId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alert`
--
ALTER TABLE `alert`
  ADD CONSTRAINT `alert_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`);

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
