-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 23, 2017 at 02:56 AM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `adminID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `department` varchar(50) NOT NULL,
  `password` varchar(10) NOT NULL,
  `ldap` varchar(50) NOT NULL,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminID`, `username`, `name`, `department`, `password`, `ldap`) VALUES
(1, 'TING', 'TING', 'Development Team frm Swinburne', '123', '??'),
(2, 'kevin', 'kevin', 'Development Team frm Swinburne', '123', '??');

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE IF NOT EXISTS `announcement` (
  `announID` int(11) NOT NULL AUTO_INCREMENT,
  `announcement` varchar(500) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `adminID` int(11) NOT NULL,
  `cdate` date NOT NULL,
  `udate` date NOT NULL,
  PRIMARY KEY (`announID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `announcement`
--

INSERT INTO `announcement` (`announID`, `announcement`, `content`, `adminID`, `cdate`, `udate`) VALUES
(1, 'Greeting', '<p>Hello, This is Beta Testing Section yolo</p>\r\n', 1, '2017-09-18', '2017-09-22');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE IF NOT EXISTS `feedback` (
  `feedbackID` int(10) NOT NULL AUTO_INCREMENT,
  `videoID` int(10) NOT NULL,
  `quizID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `feedback` varchar(100) NOT NULL,
  `rdate` date NOT NULL,
  PRIMARY KEY (`feedbackID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedbackID`, `videoID`, `quizID`, `username`, `feedback`, `rdate`) VALUES
(1, 6, 6, 'TING TING', 'Dr. Seldon found bug!!! Sjarah Question found in Nelson Mandela video, ', '2017-09-18');

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `quizID` int(10) NOT NULL,
  `questionID` int(10) NOT NULL AUTO_INCREMENT,
  `videoID` int(10) NOT NULL,
  `question` varchar(1000) NOT NULL,
  `type` varchar(5) NOT NULL,
  `input1` varchar(100) NOT NULL,
  `input2` varchar(100) NOT NULL,
  `input3` varchar(100) NOT NULL,
  `input4` varchar(100) NOT NULL,
  `checked` varchar(20) NOT NULL,
  `cdate` date NOT NULL,
  `udate` date NOT NULL,
  `adminID` int(11) NOT NULL,
  PRIMARY KEY (`questionID`,`quizID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=64 ;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`quizID`, `questionID`, `videoID`, `question`, `type`, `input1`, `input2`, `input3`, `input4`, `checked`, `cdate`, `udate`, `adminID`) VALUES
(1, 1, 0, '<p>Siapakah yang membekalkan susu kambing kepada Nabi Muhammad semasa bersembunyi di Gua Thur?</p>\r\n', 'B', 'Khadijah Binti Khuwailid', 'Ummu Salamah', 'Amir bin Fuhairah', 'James Brooke', 'Amir bin Fuhairah ', '2017-08-25', '2017-09-22', 1),
(4, 3, 4, 'The Berlin Wall was painted by artist on both sides before it came down.', 'T', '', '', '', '', 'False', '2017-08-21', '2017-08-28', 1),
(5, 4, 5, 'When was Martin Luther King Jnr. born?', 'M', 'in January 1939', 'in January 1949', 'in January 1929', 'in January 1959', 'C', '2017-08-21', '2017-08-28', 1),
(6, 5, 6, 'When was Nelson Mandela born?', 'M', 'July 19, 1919', 'July 18, 1919', 'July 19, 1918', 'July 18, 1918', 'D', '2017-08-21', '2017-08-28', 1),
(7, 6, 7, 'Where is Punxsutawney?', 'M', 'in Pennsylvania', 'in Transyvania', 'in Castlevania', 'in Bossylvania', 'A', '2017-08-21', '2017-08-28', 1),
(8, 7, 8, 'Which fields of employment are women under-represented in, according to the report?', 'M', 'science, law and accounting', 'construction, tech and law', 'science, engineering and tech', 'not stated in video', 'C', '2017-08-21', '2017-08-28', 1),
(1, 8, 0, 'Dalam Masyarakat Kadazandusun di Sabah terdapat permimpin masyarakat yang digelar "Huguan Siou". Apakah maksud gelaran tersebut?', 'M', 'Ketua Kampung', 'Ketua Menteri', 'Pemimpin Ulung', 'Yang Dipertua Negeri', 'C', '2017-08-25', '2017-08-28', 1),
(2, 8, 0, 'What is another word for lexicon?', 'B', 'Alexicon', 'Dictionary', 'Silicon', 'Texas', 'Dictionary', '2017-08-25', '2017-08-28', 1),
(2, 9, 0, 'Who invented the rabies vaccination?', 'M', 'Louis Pastuer', 'Einstein ', 'Alan Turing', 'Benedict Cumberson', 'A', '2017-08-25', '2017-08-28', 1),
(4, 10, 4, 'Some of the paintings have recently been restored.', 'T', '', '', '', '', 'True', '2017-08-21', '2017-08-28', 1),
(5, 11, 5, 'What did both his grandfather and his father do for a living?', 'M', 'they were politicians', 'they were doctors', 'they were Baptist ministers', 'they were lawyers', 'C', '2017-08-21', '2017-08-28', 1),
(6, 12, 6, 'ANC is short for ', 'M', 'The African National Congress', 'The African Nationalist Congress', 'The African National Convention', 'The African Nationalist Convention', 'A', '2017-08-21', '2017-08-28', 1),
(7, 13, 7, 'What type of animal is Punxsutawney Phil?', 'M', 'a groundhog', 'a squirrel', 'a rat', 'a bat', 'A', '2017-08-21', '2017-08-28', 1),
(8, 14, 8, 'What percentage of Silicon Valley companies have a female board director?', 'M', 'one in eight', '28.5%', '8.5%', '30%', 'C', '2017-08-21', '2017-08-28', 1),
(1, 15, 0, 'Mengapakah British memberikan persetujuan kepada penbuhan Persekutuan Afika Tengah?', 'M', 'Persekutuan ini menekankan kerjasama ekonomi dan sosial negara terlibat', 'Kemerdekaan mudah diberikan kepada negara terlibat', 'Dapat mewujudkan pentadbiran yang seragam', 'Dapat meneguh kedudukan kerajaan bangsa Eropah', 'D', '2017-08-25', '2017-08-28', 1),
(4, 16, 4, 'The section of the wall that remains looked very different back in 1989.', 'T', '', '', '', '', 'True', '2017-08-21', '2017-08-28', 1),
(5, 17, 5, 'How old was Martin Luther King Jnr. when he graduated from high school?', 'M', '15', '16', '18', '19', 'A', '2017-08-21', '2017-08-28', 1),
(6, 18, 6, 'When did Nelson Mandela become head of the ANC''s Youth Wing?', 'M', 'in the 1940''s', 'in the 1950''s', 'in the 1960''s', 'in the 1970''s', 'A', '2017-08-21', '2017-08-28', 1),
(7, 19, 7, 'What kind of prediction does Punxsutawney Phil make?', 'M', 'lottery predictions', 'weather predictions', 'sports predictions', 'future predictions', 'B', '2017-08-21', '2017-08-28', 1),
(8, 20, 8, 'What percentage of open source developers are female?', 'M', 'two percent', 'twenty two percent', 'one in two ', 'fifty percent', 'A', '2017-08-21', '2017-08-28', 1),
(1, 21, 0, '<p>Apakah peristiwa penting yang menandakan bermulanya proses penjajahan di benua Afrika?</p>\n', 'M', 'British terpaksa meninggalkan Terusan Suez', 'Pakatan British-Perancis-Israel dipaksa keluar daripada Mesir', 'British menyerahkan kuasanya di Sudan', 'Kemerdekaan Gold Coast', 'D', '2017-08-25', '2017-08-28', 1),
(6, 22, 6, 'How much time did Nelson Mandela spent in the notorious Robben Island prison?', 'M', '21 years', '15 years', '9 years', '18 years', 'D', '2017-08-21', '2017-08-28', 1),
(7, 23, 7, '<p>Apakah peristiwa penting yang menandakan bermulanya proses penjajahan di benua Afrika?</p>\n', 'M', 'British terpaksa meninggalkan Terusan Suez', 'Pakatan British-Perancis-Israel dipaksa keluar daripada Mesir', 'British menyerahkan kuasanya di Sudan', 'Kemerdekaan Gold Coast', 'D', '2017-08-21', '2017-08-28', 1),
(1, 24, 0, 'Negara yang telah menjadi sekutu utama kepada Serbia dalam konflik dengan Austria akibat pembunuhan Franz Ferdinad ialah...', 'M', 'Britain', 'Perancis', 'Rusia', 'Jerman', 'C', '2017-08-25', '2017-08-28', 1),
(4, 25, 4, 'Thierry Noir used to live in West Berlin', 'T', '', '', '', '', 'True', '2017-08-21', '2017-08-28', 1),
(5, 26, 5, 'Where did Dr King move to after he got married?', 'M', 'Boston', 'Atlanta, Georgia', 'Montgomery, Alabama', 'Cambodia', 'C', '2017-08-21', '2017-08-28', 1),
(7, 27, 7, 'The ceremonial object passed down by previous presidents is...?', 'M', 'a medal', 'a top hat', 'a lamp', 'a cane', 'D', '2017-08-21', '0000-00-00', 1),
(8, 28, 8, 'Why did Shaherose Charania set up her company, Women 2.0?', 'M', 'to train more female programmers', 'to help other women who were starting up company', 'to help programmers', 'not stated in the video', 'B', '2017-08-22', '0000-00-00', 1),
(1, 29, 0, 'Apakah sebernanya isu yang penting di sebalik "masalah kasut" dalam hubungan di antara British-Burma?', 'M', 'Cukai ke atas kasut yang diimport makin meningkat', 'British tidak menghormati adat istiadat orang Burma', 'Perbezaan cara hidup yang ketara antara penduduk tempatan dengan kuasa imperialis', 'Keengganan penduduk tempata mengamalkan kebersihan diri yang baik', 'B', '2017-08-25', '0000-00-00', 1),
(4, 30, 4, 'The artwork is the only reason why the wall still stands.', 'T', '', '', '', '', 'True', '2017-08-21', '0000-00-00', 1),
(5, 31, 5, 'What year did the Montgomery bus boycott begin?', 'M', '1965', '1955', '1956', '1959', 'B', '2017-08-21', '0000-00-00', 1),
(6, 32, 6, 'When did Nelson Mandela win the Nobel Peace Prize?', 'M', 'in 1994', 'in 1993', 'in 1986', 'in 1997', 'B', '2017-08-21', '0000-00-00', 1),
(7, 33, 7, 'How many predictions has Punxsutawney Phil made, according to the video?', 'M', '112', '121', '21', '12', 'B', '2017-08-21', '0000-00-00', 1),
(8, 34, 8, 'What percentage of companies raising money in Silicon Valley that Orange Labs SF looked at were led ', 'M', '3%', '43%', '4.3%', '5%', 'C', '2017-08-22', '0000-00-00', 1),
(1, 35, 0, '<p>Apakah faktor terpenting yang telah menyelamatkan negara China daripada dibahagi-bahagikan antara kuasa imperialis?</p>\n', 'M', 'Kewujudkan pasukan tentera yang terlatih dan besar', 'Persefahaman yang dilakukan oleh kuasa-kuasa imperialis', 'Perasingan yang hebat di kalangan imperialis', 'Dasar pengasingan diri yang berjaya dilaksanakan', 'C', '2017-08-25', '2017-09-10', 1),
(3, 36, 3, 'Why does Chris Shipley feel that female IT entrepreneurs often go unnoticed?', 'M', 'because they prefer to keep a low profile', 'because they tend to be more modest about their ac', 'because they tend not to opt for venture fundraisi', 'because they like it', 'C', '2017-08-22', '0000-00-00', 1),
(5, 37, 5, 'How long did the Montgomery bus boycott last for?', 'M', '318 days', '81 days', '381 days', '365 days', 'C', '2017-08-21', '0000-00-00', 1),
(7, 38, 7, 'Where did the Groundhog Day tradition originate?', 'M', 'in South America', 'in Asia ', 'in Europe', 'in Cambodia', 'C', '2017-08-21', '0000-00-00', 1),
(3, 39, 3, 'Ann Winblad works in the software industry.', 'T', '', '', '', '', 'False', '2017-08-22', '0000-00-00', 1),
(5, 40, 5, 'What did the US Supreme Court rule on December 20th 1956?', 'M', 'that the Montgomery bus boycott was unlawful', 'that segregated buses were lawful', 'that segregated buses was unconstitutional', 'not clear', 'C', '2017-08-21', '0000-00-00', 1),
(7, 41, 7, 'How many people celebrate Groundhog Day in Punxsutawney each year?', 'M', 'around 5000', 'around 30,000', 'around 8000', 'around 7000', 'B', '2017-08-21', '0000-00-00', 1),
(5, 42, 5, 'How many times was Dr King jalled?', 'M', 'the video doesn''t say', '20 times', 'over 20 times', '9 times', 'A', '2017-08-21', '0000-00-00', 1),
(7, 43, 7, 'Why has GroundHog Day become more popular in recent years?', 'M', 'because of the film Groundhog Day', 'because Punxsutawney Phil is on Twitter', 'because Punxsutawney Phil has his own YouTube Chan', 'non specific reason', 'A', '2017-08-21', '0000-00-00', 1),
(5, 44, 5, 'How many speeches did Dr King give between 1957 and 1968?', 'M', '6 million', '2500', '500', '250', 'C', '2017-08-21', '0000-00-00', 1),
(3, 45, 3, 'Which fields of employment are women under-represented in, according to the report?', 'M', 'science, law and accounting', 'construction, tech and law', 'science, engineering and tech', 'not stated in video', 'C', '2017-08-21', '0000-00-00', 1),
(8, 46, 8, 'Why did Shaherose Charania set up her company, Women 2.0?', 'M', 'to train women who wanted to work in the technolog', 'to try and help other women who were starting up c', 'to help women who want to be programmers', 'not stated in the video', 'B', '2017-08-22', '0000-00-00', 1),
(9, 47, 0, '<p>The medulla oblongata is a part of human ?</p>\n', 'M', 'Heart', 'Brain', 'Liver', 'Sex Organ', 'B', '2017-09-07', '2017-09-07', 2),
(9, 48, 0, '<p>The main excretory product of frog is ?</p>\n', 'M', 'Urea', 'Ammonia', 'Uric acid', 'Amino acid', 'A', '2017-09-07', '2017-09-07', 2),
(9, 49, 0, '<p>The lining of marrow cavity is called ?</p>\n', 'M', 'Episteum', ' Periosteum', 'Endosteum', 'Sarcolemma', 'C', '2017-09-07', '2017-09-07', 2),
(9, 50, 0, '<p>The largest part of the human brain is ?</p>\n', 'M', 'Medulla oblongata', 'Cerebellum', 'Cerebrum', 'Mid-brain', 'C', '2017-09-07', '2017-09-07', 2),
(9, 51, 0, '<p>The largest organ of human body is ?</p>\n', 'M', 'Brain', 'Heart', 'Skin', ' Liver', 'C', '2017-09-07', '2017-09-07', 2),
(9, 52, 0, '<p>The human cell contains ?</p>\n', 'M', '44 chromosomes', '48 chromosomes', '46 chromosomes', '23 chromosomes', 'C', '2017-09-07', '2017-09-07', 2),
(10, 53, 0, '<p>The value of 5 in the number  357.21 is____</p>\n', 'M', '5 tenths', '5 ones', '5 tens', '5 hundreds', 'C', '2017-09-07', '2017-09-07', 2),
(10, 54, 0, '<p>In coordinate geometry, the equation of the <em>x</em>-axis is_____</p>\n', 'M', 'y = x', 'y = 0', 'x = 0', 'y = 1', 'B', '2017-09-07', '2017-09-07', 2),
(10, 55, 0, '<p>3<em>x</em> - 4(<em>x</em> + 6) =</p>\n', 'M', 'x + 6', '-x - 24', '7x + 6', '-7x - 24', 'B', '2017-09-07', '2017-09-07', 2),
(10, 56, 0, '<p>Which of the following is the Highest Common Factor of 18, 24 and 36?</p>\n', 'M', '6', '18', '36', '72', 'A', '2017-09-07', '2017-09-07', 2),
(10, 57, 0, '<p>Which of the following is NOT a prime number?</p>\n', 'M', '11', '21', '31', '41', 'B', '2017-09-07', '2017-09-07', 2),
(10, 59, 0, '<p>What is 1004 divided by 2?</p>\n', 'M', ' 52', '502', '520', '5002', 'B', '2017-09-07', '2017-09-07', 2),
(10, 60, 0, '<p>106 &times; 106 &ndash; 94 &times; 94 =</p>\n', 'M', '2004', '2400', '1904', '1906', 'B', '2017-09-07', '2017-09-07', 2),
(10, 61, 0, '<p>Which of the following numbers gives 240 when added to its own square?</p>\n', 'M', '15', '16', '18', '20', 'A', '2017-09-07', '2017-09-07', 2),
(10, 62, 0, '<p>Find the sum of 111 + 222 + 333</p>\n', 'M', '700', '666', '10', '100', 'B', '2017-09-07', '2017-09-07', 2),
(10, 63, 0, '<p>Simplify : 3 + 6 x (5 + 4) &divide; 3 - 7</p>\n', 'M', '11', '16', '14', '15', 'C', '2017-09-07', '2017-09-07', 2);

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `quizID` int(11) NOT NULL AUTO_INCREMENT,
  `quizTopic` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `videoID` int(100) NOT NULL,
  `Note` varchar(1000) NOT NULL,
  `cdate` date NOT NULL,
  `udate` date NOT NULL,
  `adminID` int(11) NOT NULL,
  PRIMARY KEY (`quizID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quizID`, `quizTopic`, `category`, `videoID`, `Note`, `cdate`, `udate`, `adminID`) VALUES
(1, 'SPM Sejarah', 'His', 0, 'Currently there is no note for this quiz. \n\nNote coming soon.', '2017-08-25', '2017-09-22', 1),
(2, 'General English Quiz', 'Eng', 0, 'Currently there is no note for this quiz. \n\nNote coming soon.', '2017-08-25', '2017-09-22', 1),
(4, 'Series: Wall Story', 'English', 4, ' ', '2017-06-20', '2017-08-22', 1),
(5, 'Martin Luther King Jr.', 'English', 5, '', '2017-06-20', '2017-08-22', 1),
(6, 'Remembering Nelson Mandele', 'English', 6, '', '2017-08-22', '2017-08-22', 1),
(7, 'Inside Grandhog Day', 'English', 7, '', '2017-08-22', '2017-08-22', 1),
(8, 'The IT Girls', 'English', 8, '', '2017-06-20', '2017-08-22', 1),
(9, 'Science Biology\n', 'Bio', 0, '', '2017-09-07', '2017-09-07', 2),
(10, 'Mathematics A++', 'Math', 0, '', '2017-09-07', '2017-09-07', 2);

-- --------------------------------------------------------

--
-- Table structure for table `reward`
--

CREATE TABLE IF NOT EXISTS `reward` (
  `rewardID` int(11) NOT NULL AUTO_INCREMENT,
  `reward` varchar(1000) NOT NULL,
  `cdate` date NOT NULL,
  `udate` date NOT NULL,
  `adminID` int(11) NOT NULL,
  PRIMARY KEY (`rewardID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `reward`
--

INSERT INTO `reward` (`rewardID`, `reward`, `cdate`, `udate`, `adminID`) VALUES
(1, '<p>A smart person knows how to talk. A wise person knows when to be silent. - Roy T. Bennett</p>\r\n', '2017-06-21', '2017-09-22', 1),
(2, 'You are never too old to set another goal or to dream a new dream. – C.S.Lewis', '2017-06-21', '2017-06-21', 1),
(3, 'Today a reader, tomorrow a leader. – Margaret Fuller', '2017-06-21', '2017-06-21', 1),
(4, 'Hardest time to lie to somebody is when they''re expecting to be lied to. - Alan Turning', '2017-06-21', '2017-06-21', 1),
(6, 'Never make permanent decision on temporary feelings. - Wiz Khalifa', '2017-06-21', '2017-06-21', 1),
(7, 'Don''t quit. Suffer now and live the rest of your life as a champion. - Muhammad Ali', '2017-06-21', '2017-07-07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(10) NOT NULL,
  `result` int(11) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `username`, `password`, `result`) VALUES
(1, 'TING TING', '123', 75);

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE IF NOT EXISTS `video` (
  `videoID` int(10) NOT NULL AUTO_INCREMENT,
  `videoName` varchar(100) NOT NULL,
  `videoDesc` varchar(500) NOT NULL,
  `category` varchar(15) NOT NULL,
  `videoPath` varchar(1000) NOT NULL,
  `transcript` varchar(10000) NOT NULL,
  PRIMARY KEY (`videoID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`videoID`, `videoName`, `videoDesc`, `category`, `videoPath`, `transcript`) VALUES
(1, 'Biology Ep1', 'What do flowers, goldfish and us have in common? What are we made up of? Watch to know more!', 'Biology', 'resources/vid/BiologiEp1.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.'),
(2, 'Biology Ep2', 'Why is salt used to preserved foods? What happens when some food are soaked in concentrated solution? Watch to know more!', 'Biology', 'resources/vid/BiologiEp2.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.'),
(3, 'Biology Ep3', 'How to remove tough stains from clothes? What does the detergent do to remove the tough stains? Watch to find out!', 'Biology', 'resources/vid/BiologiEp3.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.'),
(4, 'Series: Wall Stories', 'In our series on the 20th anniversary of the fall of the Berlin Wall,we this time visit the East Side Gallery where artists used some of the Berlin Wall as a canvas. One of them is Thierry Noir. We al', 'English', 'resources/vid/SeriesWallStories.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.'),
(5, 'Martin Luther King Jr.', 'A short biography of Dr. Martin Luther King, Jr. He is widely considered the most influential leader of the American civil rights movement. He fought to overturn Jim Crow segregation laws and eliminat', 'English', 'resources/vid/MartinLutherKingJr.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.'),
(6, 'Remembering Nelson Mandela', 'Former South African President Nelson Mandela has died at the age of 95 after a long illness. People around the world are mourning the loss of the country''s first black president. VOA''s Deborah Block ', 'English', 'resources/vid/NelsonMandela.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.'),
(7, 'Inside Groundhog Day', 'Tim Beggy goes behind the scenes at Groundhog Day as we visit the Groundhog Capitol of the world: Punxsutawney, Pennsylvania.', 'English', 'resources/vid/GroundhogDay.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.'),
(8, 'The IT Girls', 'In this special report from Silicon Valley, Leila Makki speaks to five females about breaking down the barriers for women in tech. Interviews with:\nNatalie Quizon, User Experience & Design Lead, Orang', 'English', 'resources/vid/TheITGirls.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.'),
(9, '5 Simple Life Hacks for your Phone', 'The worst feelings ever: one moment your phone is safely in your hands, the next its lying face down on a concrete floor. You pick it up, hoping nothing has happened to it and then you see it: the crack. Before you start freaking out, just watch this video. We have collected some simple phone repairs that may just save your phone.', 'Science & Technology', 'resources/vid/Life Hacks For Phone.mp4', '1. Toothpaste for your cracked screen \n If you have an annoying little crack in your screen that is bothering you, you can fill the crack with toothpaste to make it disappear. Make sure you use the white paste variety, rather than the gel.\nSeal the ports and buttons of your smartphone with tape to make sure no liquid gets in, then rub your chosen toothpaste into the scratched area using a soft cloth. Clean away the excess toothpaste with a slightly damp cloth. \n\n 2. Baking soda for scratches \n No, this isn’t the Great British Bake Off for your phone - but making a thick paste out of baking soda and water may just help to remove scratches. \n Use two parts baking soda to one part water. Mix it well until you have a thick paste. \n Put a small amount of the paste onto a microfiber cloth and gently rub in a circular motion on the scratched part of your screen. \n\n 3. Sandpaper for scratches \n A more drastic solution is to grind any scratches out of your screen, by using fine sandpaper. \n Work cautiously, use the least abrasive sandpaper, press gently and check the results regularly, in case you are creating an uneven surface or worsening the situation. \n\n 4. Replace the screen yourself \n Some smartphone screens are so cracked there is no way you will be able to buff out those scratches. Manufacturers will offer you hugely expensive repairs, but to save yourself some money you can buy kits and new screens online to replace it yourself. \n Get your kit from a website like Mission Repair or iFixit (roughly around £61). They often come with all the tools you need for specific phones. Keep in mind that iPhones can be particularly troublesome because Apple make it almost impossible to take your phone apart. This is why it is imperative to watch a tutorial like the one below before attempting DIY screen replacements. \n\n 5. A bowl of rice for water damage\nDid your cell phone recently get wet? Is it no longer working? Do not worry, try putting it in some rice. It sounds crazy but it may just do the trick. We advise to turn off the device as soon as possible first, and to leave it off for 7 days in rice.'),
(10, 'FixAndroid', 'I use an HTC Wildfire S that has been over -cahrged and this Tutorial has work with nearly any Overcharged Android Phone. 2 Very simple ways that will fix your phone without needing to give it ti a Repair Store.', 'Science & Technology', 'resources/vid/FixAndroid.mp4', 'Currently there is no transcript for this quiz. \n\nTranscript coming soon.');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
