-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 07, 2017 at 12:25 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `quizID` int(11) NOT NULL,
  `quizTopic` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `videoID` int(100) NOT NULL,
  `cdate` date NOT NULL,
  `udate` date NOT NULL,
  `lupdateBY` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quizID`, `quizTopic`, `category`, `videoID`, `cdate`, `udate`, `lupdateBY`) VALUES
(4, 'Series: Wall Story', 'Eng', 4, '2017-06-20', '2017-08-22', 'TING'),
(5, 'Martin Luther King Jr.', 'Eng', 5, '2017-06-20', '2017-08-22', 'TING'),
(6, 'Remembering Nelson Mandele', 'Eng', 6, '2017-08-22', '2017-08-22', 'TING'),
(7, 'Inside Grandhog Day', 'Eng', 7, '2017-08-22', '2017-08-22', 'TING'),
(8, 'The IT Girls', 'Eng', 8, '2017-06-20', '2017-08-22', 'TING'),
(13, 'Mathematics A++', 'Math', 0, '2017-09-07', '2017-09-07', 'kevin'),
(15, 'Science Biology\r\n', 'Bio', 0, '2017-09-07', '2017-09-07', 'kevin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`quizID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `quizID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
