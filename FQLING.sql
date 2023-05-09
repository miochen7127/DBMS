-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-05-09 05:45:09
-- 伺服器版本： 10.4.28-MariaDB
-- PHP 版本： 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `sql_chl`
--

-- --------------------------------------------------------

--
-- 資料表結構 `classroom`
--

CREATE TABLE `classroom` (
  `building` varchar(10) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `capacity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `classroom`
--

INSERT INTO `classroom` (`building`, `room_number`, `capacity`) VALUES
('文學館', '105', 15),
('文學館', '106', 30),
('資電館', '201', 30),
('資電館', '202', 20),
('資電館', '302', 30),
('資電館', '306', 20),
('資電館', '404', 30),
('通識館', '101', 20),
('通識館', '102', 20),
('通識館', '999', 2);

-- --------------------------------------------------------

--
-- 資料表結構 `course`
--

CREATE TABLE `course` (
  `course_id` varchar(10) NOT NULL,
  `name` varchar(10) DEFAULT NULL,
  `credits` varchar(10) DEFAULT NULL,
  `choose` varchar(10) DEFAULT NULL,
  `dept_name` varchar(10) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `course`
--

INSERT INTO `course` (`course_id`, `name`, `credits`, `choose`, `dept_name`, `grade`) VALUES
('1000', '資料庫系統', '3', '必', '資訊系', 2),
('1001', '物聯網實務應用', '3', '選', '資訊系', 4),
('1002', '系統程式', '3', '必', '資訊系', 2),
('1003', '機率與統計', '3', '必', '資訊系', 2),
('1004', '程式設計', '3', '必', '資訊系', 1),
('1005', '線性代數', '3', '必', '資訊系', 1),
('1006', '電子學', '3', '選', '資訊系', 2),
('1008', '微處理機系統', '3', '必', '資訊系', 3),
('1009', '應用程式開發', '3', '選', '資訊系', 3),
('1010', '物件導向設計', '3', '選', '資訊系', 2),
('1011', '互連網路', '3', '選', '資訊系', 2),
('1101', '英文作文', '3', '必', '英文系', 1),
('1102', '西洋文學專論', '3', '選', '英文系', 1),
('1103', '語言學概論', '3', '必', '英文系', 2),
('1104', '口譯技巧演練', '2', '選', '英文系', 2),
('1105', '美國文學', '3', '必', '英文系', 3),
('1106', '語言與文化', '3', '選', '英文系', 3),
('1107', '英語語言史', '3', '選', '英文系', 4),
('1500', '現代軍事學', '2', '選', '通識中心', 0),
('1501', '創新綠色科技', '2', '選', '通識中心', 0),
('1502', '心理學原理', '4', '選', '通識中心', 0),
('1503', '材料與生活', '3', '選', '通識中心', 0),
('1504', '台灣民間信仰', '2', '選', '通識中心', 0),
('1998', '超智能設計', '28', '選', '資訊系', 0),
('1999', '測試課', '3', '選', '通識中心', 0);

-- --------------------------------------------------------

--
-- 資料表結構 `department`
--

CREATE TABLE `department` (
  `dept_ name` varchar(10) NOT NULL,
  `building` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `department`
--

INSERT INTO `department` (`dept_ name`, `building`) VALUES
('英文系', '文學館'),
('資訊系', '資電館'),
('通識中心', '通識館'),
('電子系', '資電館');

-- --------------------------------------------------------

--
-- 資料表結構 `section`
--

CREATE TABLE `section` (
  `course_id` varchar(10) NOT NULL,
  `sec_id` varchar(10) NOT NULL,
  `semester` varchar(10) NOT NULL,
  `year` int(11) NOT NULL,
  `building` varchar(10) DEFAULT NULL,
  `room_number` varchar(10) DEFAULT NULL,
  `time_slot_id` varchar(10) DEFAULT NULL,
  `current_people` int(11) DEFAULT NULL,
  `Max_People` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `section`
--

INSERT INTO `section` (`course_id`, `sec_id`, `semester`, `year`, `building`, `room_number`, `time_slot_id`, `current_people`, `Max_People`) VALUES
('1000', '2001', '下學期', 112, '資電館', '302', 'TE11', 6, 20),
('1000', '2002', '下學期', 112, '資電館', '306', 'TE12', 4, 10),
('1001', '2003', '下學期', 112, '資電館', '404', 'TE13', 1, 10),
('1002', '2004', '下學期', 112, '資電館', '201', 'TE21', 7, 15),
('1003', '2005', '下學期', 112, '資電館', '404', 'TE44', 7, 15),
('1004', '2006', '下學期', 112, '資電館', '201', 'TE11', 4, 15),
('1005', '2007', '下學期', 112, '資電館', '404', 'TE21', 3, 15),
('1006', '2008', '下學期', 112, '資電館', '404', 'TE43', 2, 15),
('1008', '2010', '下學期', 112, '資電館', '306', 'TE32', 8, 15),
('1009', '2011', '下學期', 112, '資電館', '302', 'TE31', 8, 15),
('1010', '2012', '下學期', 112, '資電館', '202', 'TE11', 3, 15),
('1011', '2013', '下學期', 112, '資電館', '202', 'TE23', 1, 10),
('1102', '2102', '下學期', 112, '文學館', '105', 'TE22', 0, 10),
('1500', '2500', '下學期', 112, '通識館', '102', 'TE21', 1, 15),
('1501', '2501', '下學期', 112, '通識館', '101', 'TE41', 2, 10),
('1502', '2502', '下學期', 112, '通識館', '102', 'TE31', 1, 15),
('1503', '2503', '下學期', 112, '通識館', '101', 'TE33', 10, 10),
('1504', '2504', '下學期', 112, '通識館', '102', 'TE33', 3, 15),
('1998', '2998', '下學期', 112, '資電館', '404', 'TE52', 1, 3),
('1999', '4999', '下學期', 112, '通識館', '999', 'TE51', 1, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `student`
--

CREATE TABLE `student` (
  `ID` varchar(10) NOT NULL,
  `name` varchar(10) DEFAULT NULL,
  `dept_ name` varchar(10) DEFAULT NULL,
  `total_cred` int(11) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `student`
--

INSERT INTO `student` (`ID`, `name`, `dept_ name`, `total_cred`, `grade`) VALUES
('D1093191', '李秉擇', '資訊系', 28, 2),
('D1101645', '陳煜仁', '資訊系', 16, 2),
('D1121000', '林秀芬', '資訊系', 9, 4),
('D1121001', '郭志瑋', '資訊系', 12, 4),
('D1121002', '陽柏毅', '資訊系', 11, 4),
('D1121087', '黃凱禮', '資訊系', 9, 3),
('D1121088', '劉靖丞', '資訊系', 9, 3),
('D1121089', '涂家豪', '資訊系', 9, 3),
('D1121090', '林麗虹', '資訊系', 9, 3),
('D1121091', '陳人蘋', '資訊系', 9, 3),
('D1121092', '黃瓊法', '資訊系', 9, 3),
('D1121175', '郭林卉', '資訊系', 12, 2),
('D1121176', '朱淑芳', '資訊系', 9, 2),
('D1121177', '宋男南', '資訊系', 9, 2),
('D1121178', '伍怡如', '資訊系', 9, 2),
('D1121179', '呂靖為', '資訊系', 9, 2),
('D1121263', '梁玉婷', '資訊系', 10, 1),
('D1121264', '孫珮君', '資訊系', 10, 1),
('D1121265', '陳佳穎', '資訊系', 10, 1),
('D1176395', '許恩翔', '資訊系', 30, 4);

-- --------------------------------------------------------

--
-- 資料表結構 `takes`
--

CREATE TABLE `takes` (
  `ID` varchar(10) NOT NULL,
  `course_id` varchar(10) NOT NULL,
  `sce_id` varchar(10) NOT NULL,
  `semester` varchar(10) NOT NULL,
  `year` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `takes`
--

INSERT INTO `takes` (`ID`, `course_id`, `sce_id`, `semester`, `year`) VALUES
('D1093191', '1998', '2998', '下學期', 112),
('D1101645', '1000', '2001', '下學期', 112),
('D1101645', '1002', '2004', '下學期', 112),
('D1101645', '1003', '2005', '下學期', 112),
('D1101645', '1502', '2502', '下學期', 112),
('D1101645', '1503', '2503', '下學期', 112),
('D1121000', '1000', '2002', '下學期', 112),
('D1121000', '1006', '2008', '下學期', 112),
('D1121000', '1008', '2010', '下學期', 112),
('D1121001', '1000', '2002', '下學期', 112),
('D1121001', '1009', '2011', '下學期', 112),
('D1121001', '1503', '2503', '下學期', 112),
('D1121001', '1999', '4999', '下學期', 112),
('D1121002', '1000', '2002', '下學期', 112),
('D1121002', '1010', '2012', '下學期', 112),
('D1121002', '1503', '2503', '下學期', 112),
('D1121002', '1504', '2504', '下學期', 112),
('D1121087', '1008', '2010', '下學期', 112),
('D1121087', '1009', '2011', '下學期', 112),
('D1121087', '1503', '2503', '下學期', 112),
('D1121088', '1008', '2010', '下學期', 112),
('D1121088', '1009', '2011', '下學期', 112),
('D1121088', '1503', '2503', '下學期', 112),
('D1121089', '1008', '2010', '下學期', 112),
('D1121089', '1009', '2011', '下學期', 112),
('D1121089', '1503', '2503', '下學期', 112),
('D1121090', '1008', '2010', '下學期', 112),
('D1121090', '1009', '2011', '下學期', 112),
('D1121090', '1503', '2503', '下學期', 112),
('D1121091', '1008', '2010', '下學期', 112),
('D1121091', '1009', '2011', '下學期', 112),
('D1121091', '1010', '2012', '下學期', 112),
('D1121092', '1008', '2010', '下學期', 112),
('D1121092', '1009', '2011', '下學期', 112),
('D1121092', '1010', '2012', '下學期', 112),
('D1121092', '1500', '2500', '下學期', 112),
('D1121175', '1000', '2001', '下學期', 112),
('D1121175', '1002', '2004', '下學期', 112),
('D1121175', '1003', '2005', '下學期', 112),
('D1121175', '1503', '2503', '下學期', 112),
('D1121176', '1000', '2001', '下學期', 112),
('D1121176', '1002', '2004', '下學期', 112),
('D1121176', '1003', '2005', '下學期', 112),
('D1121177', '1000', '2001', '下學期', 112),
('D1121177', '1002', '2004', '下學期', 112),
('D1121177', '1003', '2005', '下學期', 112),
('D1121178', '1000', '2001', '下學期', 112),
('D1121178', '1002', '2004', '下學期', 112),
('D1121178', '1003', '2005', '下學期', 112),
('D1121179', '1000', '2001', '下學期', 112),
('D1121179', '1002', '2004', '下學期', 112),
('D1121179', '1003', '2005', '下學期', 112),
('D1121263', '1004', '2006', '下學期', 112),
('D1121263', '1005', '2007', '下學期', 112),
('D1121263', '1501', '2501', '下學期', 112),
('D1121263', '1504', '2504', '下學期', 112),
('D1121264', '1004', '2006', '下學期', 112),
('D1121264', '1005', '2007', '下學期', 112),
('D1121264', '1501', '2501', '下學期', 112),
('D1121264', '1504', '2504', '下學期', 112),
('D1121265', '1004', '2006', '下學期', 112),
('D1121265', '1005', '2007', '下學期', 112),
('D1121265', '1503', '2503', '下學期', 112),
('D1176395', '1000', '2002', '下學期', 112),
('D1176395', '1001', '2003', '下學期', 112),
('D1176395', '1002', '2004', '下學期', 112),
('D1176395', '1003', '2005', '下學期', 112),
('D1176395', '1004', '2006', '下學期', 112),
('D1176395', '1006', '2008', '下學期', 112),
('D1176395', '1008', '2010', '下學期', 112),
('D1176395', '1009', '2011', '下學期', 112),
('D1176395', '1011', '2013', '下學期', 112),
('D1176395', '1503', '2503', '下學期', 112);

-- --------------------------------------------------------

--
-- 資料表結構 `teacher`
--

CREATE TABLE `teacher` (
  `ID` varchar(10) NOT NULL,
  `name` varchar(10) DEFAULT NULL,
  `dept_ name` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `teacher`
--

INSERT INTO `teacher` (`ID`, `name`, `dept_ name`) VALUES
('TH1', '許懷中', '資訊系'),
('TH10', '貲廖俈', '資訊系'),
('TH2', '劉怡芬', '資訊系'),
('TH3', '劉宗杰', '資訊系'),
('TH4', '蔡國裕', '資訊系'),
('TH5', '劉明機', '資訊系'),
('TH6', '林佩君', '資訊系'),
('TH7', '何子豪', '資訊系'),
('TH8', '吳鴻章', '資訊系'),
('TH9', '陳錫民', '資訊系'),
('TH91', '呂晃志', '通識中心'),
('TH92', '王志宇', '通識中心'),
('TH98', '曹志能', '資訊系'),
('TH999', '康測士', '通識中心');

-- --------------------------------------------------------

--
-- 資料表結構 `teaches`
--

CREATE TABLE `teaches` (
  `ID` varchar(10) NOT NULL,
  `course_id` varchar(10) NOT NULL,
  `sec_id` varchar(10) NOT NULL,
  `semester` varchar(10) NOT NULL,
  `year` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `teaches`
--

INSERT INTO `teaches` (`ID`, `course_id`, `sec_id`, `semester`, `year`) VALUES
('TH1', '1000', '2001', '下學期', 112),
('TH10', '1000', '2002', '下學期', 112),
('TH2', '1003', '2005', '下學期', 112),
('TH3', '1002', '2004', '下學期', 112),
('TH4', '1000', '2002', '下學期', 112),
('TH5', '1004', '2006', '下學期', 112),
('TH6', '1005', '2007', '下學期', 112),
('TH7', '1006', '2008', '下學期', 112),
('TH8', '1008', '2010', '下學期', 112),
('TH9', '1009', '2011', '下學期', 112),
('TH92', '1504', '2504', '下學期', 112),
('TH98', '1998', '2998', '下學期', 112),
('TH999', '1999', '4999', '下學期', 112);

-- --------------------------------------------------------

--
-- 資料表結構 `time_slot`
--

CREATE TABLE `time_slot` (
  `time_slot_id` varchar(10) NOT NULL,
  `day` varchar(10) NOT NULL,
  `start_time` varchar(10) NOT NULL,
  `end_time` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `time_slot`
--

INSERT INTO `time_slot` (`time_slot_id`, `day`, `start_time`, `end_time`) VALUES
('TE11', '星期一', '13:10', '15:00'),
('TE12', '星期一', '10:10', '12:00'),
('TE13', '星期一', '8:10', '10:00'),
('TE14', '星期一', '15:10', '17:00'),
('TE21', '星期二', '8:10', '10:00'),
('TE22', '星期二', '10:10', '12:00'),
('TE23', '星期二', '13:10', '15:00'),
('TE31', '星期三', '8:10', '10:00'),
('TE32', '星期三', '10:10', '12:00'),
('TE33', '星期三', '13:10', '15:00'),
('TE41', '星期四', '8:10', '10:00'),
('TE42', '星期四', '10:10', '12:00'),
('TE43', '星期四', '13:10', '15:00'),
('TE44', '星期四', '14:10', '16:00'),
('TE51', '星期五', '8:10', '10:00'),
('TE52', '星期五', '10:10', '12:00');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `classroom`
--
ALTER TABLE `classroom`
  ADD PRIMARY KEY (`building`,`room_number`);

--
-- 資料表索引 `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `dept_name` (`dept_name`);

--
-- 資料表索引 `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_ name`);

--
-- 資料表索引 `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`course_id`,`sec_id`,`semester`,`year`),
  ADD KEY `time_slot_id` (`time_slot_id`),
  ADD KEY `building` (`building`,`room_number`);

--
-- 資料表索引 `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `dept_ name` (`dept_ name`);

--
-- 資料表索引 `takes`
--
ALTER TABLE `takes`
  ADD PRIMARY KEY (`ID`,`course_id`,`sce_id`,`semester`,`year`),
  ADD KEY `course_id` (`course_id`,`sce_id`,`semester`,`year`);

--
-- 資料表索引 `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `dept_ name` (`dept_ name`);

--
-- 資料表索引 `teaches`
--
ALTER TABLE `teaches`
  ADD PRIMARY KEY (`ID`,`course_id`,`sec_id`,`semester`,`year`),
  ADD KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`);

--
-- 資料表索引 `time_slot`
--
ALTER TABLE `time_slot`
  ADD PRIMARY KEY (`time_slot_id`,`day`,`start_time`);

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_ name`);

--
-- 資料表的限制式 `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `section_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `section_ibfk_2` FOREIGN KEY (`time_slot_id`) REFERENCES `time_slot` (`time_slot_id`),
  ADD CONSTRAINT `section_ibfk_3` FOREIGN KEY (`building`,`room_number`) REFERENCES `classroom` (`building`, `room_number`);

--
-- 資料表的限制式 `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`dept_ name`) REFERENCES `department` (`dept_ name`);

--
-- 資料表的限制式 `takes`
--
ALTER TABLE `takes`
  ADD CONSTRAINT `takes_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `student` (`ID`),
  ADD CONSTRAINT `takes_ibfk_2` FOREIGN KEY (`course_id`,`sce_id`,`semester`,`year`) REFERENCES `section` (`course_id`, `sec_id`, `semester`, `year`);

--
-- 資料表的限制式 `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`dept_ name`) REFERENCES `department` (`dept_ name`);

--
-- 資料表的限制式 `teaches`
--
ALTER TABLE `teaches`
  ADD CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `teacher` (`ID`),
  ADD CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`course_id`,`sec_id`,`semester`,`year`) REFERENCES `section` (`course_id`, `sec_id`, `semester`, `year`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
