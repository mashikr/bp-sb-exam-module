-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2024 at 01:15 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `updated_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `course_title` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `exam_name` varchar(255) NOT NULL,
  `course_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `details` varchar(255) NOT NULL,
  `status` enum('active','deactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `exams`
--

INSERT INTO `exams` (`exam_id`, `exam_name`, `course_id`, `type`, `details`, `status`) VALUES
(1, 'IQ TEST', NULL, 'test', 'a new exam', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `exam_configuration`
--

CREATE TABLE `exam_configuration` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` tinytext NOT NULL,
  `total_questions` int(20) NOT NULL,
  `pass_mark` float NOT NULL,
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `result_publish_status` enum('not published','hold','published') NOT NULL DEFAULT 'not published',
  `status` enum('active','deactive','postponed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `exam_configuration`
--

INSERT INTO `exam_configuration` (`id`, `name`, `total_questions`, `pass_mark`, `exam_id`, `date`, `start_time`, `end_time`, `result_publish_status`, `status`) VALUES
(1, 'test', 10, 5, 1, '2024-01-29', '05:53:21', '18:22:21', 'not published', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `exam_schedule`
--

CREATE TABLE `exam_schedule` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bpid` varchar(20) NOT NULL,
  `exam_config_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('not started','started','completed') NOT NULL DEFAULT 'not started',
  `password` varchar(20) NOT NULL,
  `login_time` datetime DEFAULT NULL,
  `submission_time` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `exam_schedule`
--

INSERT INTO `exam_schedule` (`id`, `bpid`, `exam_config_id`, `status`, `password`, `login_time`, `submission_time`, `updated_at`) VALUES
(1, '1234', 1, 'completed', '1234', NULL, NULL, '2024-01-29 12:14:24');

-- --------------------------------------------------------

--
-- Table structure for table `mcq_questions`
--

CREATE TABLE `mcq_questions` (
  `question_id` bigint(20) NOT NULL,
  `question` text NOT NULL,
  `option1` varchar(255) DEFAULT NULL,
  `option2` varchar(255) DEFAULT NULL,
  `option3` varchar(255) DEFAULT NULL,
  `option4` varchar(255) DEFAULT NULL,
  `option5` varchar(255) DEFAULT NULL,
  `option6` varchar(255) DEFAULT NULL,
  `correct_option` enum('1','2','3','4','5','6') NOT NULL,
  `time_in_seconds` int(20) NOT NULL DEFAULT 30,
  `show_question` enum('yes','no') NOT NULL DEFAULT 'yes',
  `type` enum('material','exam') DEFAULT NULL,
  `exam_type` enum('mock','final') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mcq_questions`
--

INSERT INTO `mcq_questions` (`question_id`, `question`, `option1`, `option2`, `option3`, `option4`, `option5`, `option6`, `correct_option`, `time_in_seconds`, `show_question`, `type`, `exam_type`) VALUES
(1, 'অক্ষর গুলোকে নতুন করে সাজালে নিচের কোনটি পাওয়া যাবে?', 'একটি মহাসাগর', 'একটি দেশ', 'একটি শহর', 'একটি প্রাণী', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(2, '১৫ দিন আগে সুফিয়া বলেছিল, “আগামী পরশু আমার জন্মদিন।” আজ ৩০ তারিখ হলে কোন তারিখে সুফিয়ার জন্মদিন?', '14', '15', '16', '17', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(3, 'রাস্তা সমান করার রোলার সরাবার জন্য সহজ হবে, যদি রোলারকে ', 'ঠেলে নিয়ে যাওয়া হয়', 'টেনে নিয়ে যাওয়া হয়', 'তুলে নিয়ে যাওয়া হয়', 'সমান সহজ হয়', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(4, 'একটি মোটা ও একটি চিকন হাতলওয়ালা স্কু-ডাইভার দিয়ে একই মাপের দু\'টি স্কু-কে কাঠবোর্ডের ভিতরে সমান গভীরতায় প্রবেশ করাতে চাইলে কোনটি ঘটবে? ', 'মোটা হাতলের ড্রাইভারকে বেশিবার ঘুরাতে হবে', 'চিকন হাতলের ড্রাইভারকে বেশিবার ঘুরাতে হবে', 'দু\'টিকে একই সংখ্যকবার ঘুরাতে হবে', 'কোনটিই নয়', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(5, 'কোন নৌকাকে বেশি গতিতে চালাতে হবে, বৈঠা ব্যবহার করতে হবে- ', 'পিছনে', 'সামনে', 'ডান পার্শ্বে', 'বাম পার্শ্বে', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(6, 'স্কু ও ঘড়ির কাঁটার ঘূর্ণন গতির দিক –', 'একই দিকে', 'উল্টো দিকে', 'উলম্ব রেখায়', 'সমান্তরালে', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(7, '১, ৩, ৬, ১০, ১৫, ২১ …….ধারাটির দশম পদ কত ?', '৪৫', '৭৫', '৬৫', '৫৫', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(8, '১২৮, ৬৪, ৩২, …….ধারাটির ৮ম পদ কোনটি ?', '১', '০', '২', '১/২', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(9, '১৮, ২১, ২৭, ৩৯ এর পরবর্তী সংখ্যাটি কত ?', '৪২', '৪৬', '৪৯', '৬৩', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(10, '৩, ৫, ৮, ১০, ১৮, ২০…….ধারাটির পরবর্তী পদ কত ?', '২৮', '৩০', '৩৪', '৩৮', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(11, '৮, ১১, ১৭, ২৪, ২৯, ৫৩, ৭৮…….এর পরবর্তী সংখ্যাটি কী ?', '৯৮', '৯৯', '১০০', '১০১', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(12, 'সংখ্যা গুলোর পরবর্তী সংখ্যাটি র্নিণয় করোঃ ১, ৫, ৭, ১৩, ২১, ৩৫………..?', '১৪', '৫৭', '৫৮', '৫৬', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(13, 'বিশেষ ক্রমানুযায়ী সাজানো ২, ৩, ৫, ৯, ১৭, …….?', '৪৫', '৩৩', '৬৫', '২৬', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(14, '৫, ১১, ১৯, ২৯, ………ধারাটির পরবর্তী সংখ্যা কত ?', '৩৫', '৩৭', '৪১', '৩৯', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(15, '৫৫৫-এর সর্ব ডানের অংকের স্থানীয় মান কত? ', '৫', '৬', '৭', '৮', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(16, '৩, ৪, ৬, ৫, ১, ৬,..... এই পদক্রমটির পরবর্তী পদ কত?', '৭', '৮', '১০', '১২', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(17, '৫, ৭, ১১, ১৯,−    শূন্যস্থানে কোন সংখ্যাটি বসবে ?', '২৬', '৩০', '৩৫', '৪৩', '44', NULL, '3', 10, 'yes', 'exam', 'final'),
(18, '১১, ১৫, ২৩, ৩১ ............. ধারাটির পরবর্তী সংখ্যা কত?', '৫২', '৬৫', '৭১', '৯২', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(19, '৩, ৬, ১১, ১৮, ২৭-এর পরবর্তী সংখ্যাটি কত?', '৩৫', '৩৮', '৮৩', '৪৮', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(20, '১৯, ৩৩, ৫১, ৭৩, - শেষের সংখ্যাটি কত?', '৮৫', '১২১', '৯৯', '৯৮', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(21, '১, ৩, ৬, ১০, ১৫, ২১,…….ধারাটির দশম পদ কত ?', '৪৫', '৫৫', '৬২', '৭২', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(22, '৭, ১০, ১৬, ২৮, ৫২….ধারাটির পরবর্তী সংখ্যা কত?', '৭৫', '১০০', '১০৫', '১৫০', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(23, '৫, ৮, ১৪, ২৬, ৫০, ........ ধারাটির পরবর্তী সংখ্যা কত?', '৭৪', '৯৮', '১০২', '১১২', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(24, '১, ৩,৫,৭, ...., ধারাটির অষ্টম পদ হবে ?', '১৫', '১৬', '১৭', '১৮', NULL, NULL, '', 10, 'yes', 'exam', 'final'),
(25, '১, ৫, ১৩, ২৯, ৬১, ধারাটির পরবর্তী সংখ্যাটি \r\nকত?\r\n', '৭৬', '১০২', '১০৬', '১২৫', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(26, '৩, ৬, ৪, ৯, ৫, ১২, ৬, ..... ধারাটির দশম পদ হবে ?', '১৪', '১৬', '১৮', '২০', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(27, '৯, ১২, ১৮, ৩০, ৫৪. ….সংখ্যাটি কত? ', '১৫২', '১০৬', '১০২', '৭৬', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(28, '১, ৫, ৩, ৮,…….ধারাটির ৮ম পদ হবে ?', '১১', '১৩', '১৪', '১৫', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(29, '৩, ৫, ৪, ৮, ৫, ১১, ৬, ....... ধারাটির দশম পদ হবে', '১৬', '১৭', '১৪', '১৫', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(30, 'সিরিজের পরের সংখ্যাটি কত হবে? ২, ৫, ১১, ২৩, ........', '৩৫', '৪৫', '৪৭', 'কোনটি নয়', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(31, '১, ৩, ৬, ১০, ১৫, ... ক্রমটির পরবর্তী পদ কত?', '১৮', '২১', '২৪', '৩০', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(32, '১,৩, ৪, ৭, ১১, ১৮, ....... ক্রমটির পরবর্তী পদ কত?', '২৫', '২৯', '৩৬', '৪২', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(33, '১, ২, ৪, ৭.......ক্রমটির পরবর্তী পদ কত?', '১১', '১২', '১৪', '১৫', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(34, '১, ২, ৩, ৫, ৮ ....….. ক্রমটির পরবর্তী পদ কত?', '৭', '৯', '১৩', '১৫', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(35, '০, ৩, ৮, ১৫, ....…….ধারাটির ৮ম পদ হবে ?', '৬৩', '৬৪', '৬৬', '৬৭', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(36, '১, ২, ৪, ৭, ১১, ধারাটির নবম পদ হবে  ?', '৩২', '৩৫', '৩৭', '৪২', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(37, '৫, ৯, ১৭, ৩৩, ৬৫,.... ধারাটি পরবর্তী সংখা কত ?', '১২৫', '১২৯', '১৩৫', '১৪০', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(38, '৯৫, ৮৭, ৮০, ৭৪,... ধারাটির অষ্টম পদ হবে  ?', '৬০', '৬১', '৬২', '৬৩', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(39, '২, ৩, ১, ৪, ....ধারাটির নবম পদ হবে-', '০', '-১', '-২', '২', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(40, '২, ৫, ১১, ২০,...ধারাটির নবম পদ হবে  ?', '৮৬', '১১০', '১২৭', '১৫০', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(41, '৬৪, ৩২, ১৬, ৮ .... ধারাটি পরবর্তী সংখা কত ?', '৪', '-৪', '-২', '২', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(42, '১১, ১৬, ২৬, ৪০, ৯৪ সংখ্যা সারির শূন্যস্থানের সংখ্যাটি কত?', '৬০', '৬২', '৭২', '৮২', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(43, '৫,৭, ১১, ১৯, -। সংখ্যা সারির শূন্যস্থানে কোন সংখ্যাটি হবে?', '৩২', '৩৫', '৩৭', '৪২', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(44, '১১, ১৫, ২৩, ৩৯, .... ধারাটির পরবর্তী সংখ্যা কত?', '৪৫', '৫৫', '৭১', '৮২', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(45, '(?) চিহ্নিত স্থানে কোন সংখ্যাটি বসবে ? ০, ৫, ১২, ২১, ?  ৪৫', '২৮', '৩০', '৩২', '৩৩', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(46, '৮, ১৩, ২৩, ৪৩, ৮৩-এর পরবর্তী সংখ্যাটি কত?', '১৪৩', '১৬৩', '১৫৬', '১৪৬', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(47, '১, ৪, ১৩, ৪০... ধারাটি কত?', '৩৯', '৮১', '১২১', '৩৬৩', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(48, '১, ৯, ২৫, ৪৯, ৮১.... ধারাটি পরবর্তী সংখা কত ?', '১৪৪', '১০০', '১২১', '১৪৫', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(49, 'নিম্নোক্ত সারিটি পূর্ণ করুন ২৭, ৫, ২৫, ৮, ২৩, ১১,২১,……?', '১৫, ২১', '১৪, ১৯', '১৬, ২৩', '১২, ১৯', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(50, 'অজানা সংখ্যাটি কত?  ৪, ১১, ৮, ১৯, ১২, …..?', '২৫', '২৭', '২০', '৩০', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(51, 'নিম্নবর্ণিত সিরিজের পরবর্তী সংখ্যাটি কত হবে? \r\n ৪, ১৩, ৪০, ১২১ ...... ?\r\n', '২০৮', '২৪৩', '১৯৯', '৩৮০', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(52, '2, 5, 9, 19, 37, ?', '75', '76', '78', '73', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(53, '1, 6, 15, ?, 45, 66, 91', '25', '26', '27', '28', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(54, '10000, 11000, 9900, 10890, 9801,?', '10241', '10423', '10781', '10929', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(55, 'T, R, P, N, L, ?, ?', 'J. G.', 'J,H', 'K, H', 'K, H', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(56, 'Find the wrong number in the series: 3, 8, 15, 24, 34, 48, 63  ?', '১৫', '২৪', '৩৪', '৪৮', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(57, 'Find out the missing number in the following series. 65536, 256, 16, ?', '8', '6', '4', '2', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(58, 'Insert the missing number? 4 11 8 19 12-', '25', '20', '27', '30', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(59, 'Which one of the following is the next number in the series: 7, 14, 42, 168,?', '336', '504', '672', '840', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(60, 'What is the next number in the series : 1, 1, 2, 3, 5, 8, 13, 21, ......,?', '34', '31', '41', '50', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(61, 'What is the next number in the series : 1, 4, 9, 16...?', '30', '36', '45', '35', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(62, 'Which one number does not belong to the following series? 3, 5, 8, 11, 17, 23 ......', '8', '11', '17', '23', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(63, 'Which of the following is the next number in the series: 2, 1, 4, 2, 8, 3, 16, 4, 32, 5 ............?', '60', '36', '56', '64', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(64, 'Find out the missing number in the series of numbers given below: 1, 2, 3, 1, 4, 9, .... 8, 27.....', '1', '6', '4', '2', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(65, 'What is the next number in the series? 4, 12, 71/2, 101/2, 11, 9, 141/2.......', '161/2', '15', '121/2', '71/2', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(66, '১, ৩, ৬, ১০, ১৫, ২১-। শূন্যস্থানের সংখ্যাটি কত?', '২৫', '২৭', '২৮', '২৯', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(67, '১৬, ২৫, ৩৬, ৪৯ ............শূন্যস্থানের সংখ্যাটি কত?', '৫৬', '৭২', '৬৪', '৮১', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(68, '৮, ২৭, ৬৪, ১২৫,..........শূন্যস্থানে কোন সংখ্যাটি  বসবে ?', '১৪৪', '১৮৯', '২১৬', '২৫৬', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(69, '৩৮৪, ৪৭৮, ৫৭২, ৪২৫, শূন্যস্থানে কোন সংখ্যাটি বসবে?', '৪৮৫', '৫২৪', '৫৪৮', '৫৯৬', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(70, '৮৭৫, ৪৪৬, ৪২৯, ৭৫৭, ---, ৩৫১ শূন্যস্থানে কোন সংখ্যা বসবে ?', '৪০৬', '৪৪৭', '৫৬৪', '৬০৮', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(71, '৪১, ৪৫, ৪৯, ৫৫, -, ৬৭ শূন্যস্থানে কোন সংখ্যা বসবে ?', '৫৯ ', '৬১', '৬৩', '৬৫', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(72, '২, ৫, ১০,৫০,৫০০...শূন্যস্থানে কোন সংখ্যা বসবে ?', '১০০০', '৫০০০', '১৫০০০', '২৫০০০', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(73, '১৯, ২৮, ৩৯, ৫২, ৬৭, .....শূন্যস্থানে কোন সংখ্যা বসবে ?', '৭২  ', '৭৬', '৮৪', '৯৫', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(74, '৫৬, ৭২, ৯০,১১০,-- শূন্যস্থানে কোন সংখ্যা বসবে? ', '১২১', '১৩২', '১৪৪', '১৫৬', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(75, '১৯, ২৬, ৩৫, ৪৬, ৫৯, - শূন্যস্থানে কোন সংখ্যা বসবে?', '৬৪', '৭০', '৭৪ ', '৮৪', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(76, '১, ১, ২, ৬, ২৪, - শূন্যস্থানে কোন সংখ্যা বসবে?', '৪৮ ', '৭২', '৯৬ ', '১২০', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(77, '১০, ৫, ১৩, ১০, ১৬, ২০, ১৯, --- শূন্যস্থানে কোন সংখ্যা বসবে?', '২৪ ', '২৮', '৩২', '৪০', NULL, NULL, '5', 10, 'yes', 'exam', 'final'),
(78, '৮, ৭, ১১, ১২, ১৪, ১৭, ১৭, ২২, শূন্যস্থানে কোন সংখ্যা বসবে?', '২০  ', '২৩  ', '২৭ ', '২৮', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(79, 'নিম্নোক্ত সারিটি পূর্ণ করুন; ২৭, ৫, ২৫, ৮, ২৩, ১১, \r\n২১.......?\r\n', '১৫, ২১             ', '১৪, ১৯', '১৬, ২৩            ', '১২, ১৯', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(80, '১৭২, ৮৪, ৪০, ১৮,ধারার শূন্যস্থানের সংখ্যা কত?', '৫ ', '৬ ', '৭', '৮', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(81, '১, ১, ২, ৩, ৫, ৮, – ২১ ধারার শূন্যস্থানের সংখ্যাটি কত ?', '১৯', '১৭', '১৩', '১৫', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(82, '১, ৪, ১৬, ৬৪, – ১০২৪ ধারার শূন্যস্থানের সংখ্যা কত?', '২৪  ', '৮০', '৯৬', '২৫৬', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(83, '১, ৪, ৯, ১৬, ২৫,ধারার অষ্টম পদ কত?', '৩৫ ', '৬৪', '৮১ ', '১০০', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(84, '৩, ৭, ৪, ১৪, ৫, ২১........ধারার সপ্তম পদ কত?', '৬', '৭ ', ' ২৭', '১১', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(85, '১৫, ১৩, ১৭, ১৪, ১৯, ১৫, - ধারার সপ্তম পদ কত?', '২৭  ', '১৭  ', '১৯ ', '২১', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(86, ', ৪, ৭, ৭, ১৫, ১৩, ৩১, – ধারার শূন্যস্থানের সংখ্যা কত ?', '২৩  ', '২৪', '২৫  ', '২৬', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(87, '১, ১/৩, ১/৯, ........ধারার পরবর্তী সংখ্যা কত?', '১/৩৬,          ', '১/২৭,       ', '১/২৪,        ', '১/১৮,', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(88, '১/৩, ১/৯,  ১/২৭,  ১/৮১,........ধারার পরবর্তী সংখ্যা কত?', '১/২৪৩,          ', '১/২৯৭,       ', '১/২৫৩,        ', '১/২৭৩,', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(89, ' ১/৩, ১/১৫,  ১/২৭,  ১/৩৯,........ধারার পরবর্তী সংখ্যা কত?', '১৭/৬৮,                  ', '১৭/৫১,       ', '২৭/৭২,        ', '১৩/৬৫', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(90, '০.১, ০.৭, ...৩৪.৩, ২৪০.১ সংখ্যাসারির শূন্যস্থানে কোন্ সংখ্যাটি বসবে?', '২.১          ', '৪.৯       ', '২৩.১       ', '২৭.৩', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(91, 'নিচের ধারাটির পরবর্তী সংখ্যাটি কত? ১, ৪, ১৩, ৪০, ১২১,....?', '৩৬৪ ', '৩৬০ ', '২০০ ', '১৪৮', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(92, 'Of the five words below, four are alike in a certain way. Which is the one not like these four?', 'Bend', 'Shave', 'Chop', 'Whittle', 'Shear', NULL, '1', 10, 'yes', 'exam', 'final'),
(93, 'Of the five words below, four are similar in a certain way. Which is the one not like these four? [27th BCS]', 'smuggle', 'steal', 'bribe', 'cheat', 'sell', NULL, '5', 10, 'yes', 'exam', 'final'),
(94, 'Which one of the five words below is most unlike the other four? [27th BCS]', 'good', 'large', 'red', 'walk', 'thick', NULL, '4', 10, 'yes', 'exam', 'final'),
(95, 'Which one of the five words below is most unlike the other four? [28th BCS]', 'Burmese', 'English', 'Punjabi', 'France', 'Persian', NULL, '4', 10, 'yes', 'exam', 'final'),
(96, 'Which one of the five words below is most unlike the other four? [28th BCS]', 'Triangle', 'Rectangle', 'Square', 'Circle', 'Rhombus', NULL, '3', 10, 'yes', 'exam', 'final'),
(97, 'Which one of the following countries is somehow different from other four?', 'Algeria', 'Morocco', 'Benin', 'Egypt', 'Vietnam', NULL, '2', 10, 'yes', 'exam', 'final'),
(98, 'Which one of the following words dissimilar to other three?', 'Leukemia', 'Cataract', 'Diptheria', 'Bronchitis', 'Leukocyte', NULL, '1', 10, 'yes', 'exam', 'final'),
(99, 'নিচের কোন্ শব্দটি সমগোত্রীয় নয়?', 'Aeroplane', 'Car', 'Scooter', 'Truck', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(100, 'নিচের শব্দগুলোর মধ্যে কোনটি অসামঞ্জস্যপূর্ণ? [ 30th BCS ]', 'কিলোমিটার', 'কিলোগ্রাম', 'মাইল', 'গজ', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(101, 'নিচের কোন্ সংখ্যাটি অন্য রকম? [ 30th BCS ]', '43', '23', '19', '16', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(102, 'খাবারের সাথে কোনটি সবসময় থাকবে?', 'টেবিল', 'থালা বাসন', 'ক্ষুধা', 'খাদ্য সামগ্রী', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(103, 'সর্বদা মনে রাখতে হবে যে, সংসারে কেউ একা নয় । সমস্যাসঙ্কুল জীবনে পদে পদে নিজেকে প্রতিষ্ঠিত করতেহয়।', 'অপ্রীতিকর', 'প্রতিযোগিতাপূর্ণ', 'কষ্টসাধ্য', 'জটিল', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(104, 'নিচের কোন উত্তরটি অন্যগুলোর সাথে সামঞ্জস্যপূণ্য নয়?', 'সিপাহি হামিদুর রহমান', 'ল্যান্স নায়েক নূর মোহাম্মদ', 'মেজর আবু তাহের', 'সিপাহি মোস্তফা কামাল', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(105, 'নিচের কোন উত্তরটি অন্যগুলোর সাথে অসামঞ্জস্যপূর্ণ?', 'PwiÎnxb', 'দেনাপাওন', 'পjøxসমাজ', 'নৌকাডুবি', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(106, 'Give the serial order in which the following word will sdictionary? [32th BCS) come in the', 'Beauty', 'Beautiful', 'Beat', 'Begin', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(107, 'নিচের কোন শব্দটি ভিন্ন ধরনের?', 'পৃথিবী', 'মঙ্গল', 'প্লুটো', 'চাঁদ', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(108, 'নিচের কোন স্থান অন্য স্থান হতে আলাদা?', 'রেসকোর্স ময়দান', 'মুজিবনগর', 'কেন্দ্রীয় শহীদ মিনার', 'থিয়েটার রোড, কোলকাতা', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(109, 'What is related to few as ordinary is to excepational?', 'some', 'less', 'many', 'more', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(110, 'নিচের কোন ব্যক্তি অন্যদের থেকে আলাদা?', 'সৈয়দ নজরুল ইসলাম', 'আব্দুস সামাদ আজাদ', 'তাজউদ্দিন আহমেদ', 'এ এইচ এম কামারুজ্জামান', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(111, 'নিচের কোন বৈশিষ্ট্যের উপর সমাজে ব্যক্তির প্রভাব নির্ভর করে?', 'সম্পদ', 'প্রজ্ঞা', 'মর্যাদা', 'রাজনৈতিক', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(112, 'নিচের নামগুলির কোনটি ভিন্ন ধরনের? টেনিস, ফুটবল, ক্রিকেট, টেবিল টেনিস।', 'টেনিস', 'ফুটবল', 'ক্রিকেট', 'টেবিল টেনিস', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(113, 'নিচের জন্তুগুলোর মধ্যে কোনটি ভিন্ন প্রকৃতির প্রাণী? ঘোড়া, গাধা, জেব্রা, নীল গাই।', 'নীল গাই', 'গাধা', 'ঘোড়া', 'জেব্রা', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(114, 'Trace the odd pair in the following-', 'Hospital and patient', 'Teacher and student', 'Prison and culprit', 'Nest and bird', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(115, 'নিম্নের কোনটি ব্যতিক্রম?', 'পোর্ট অব প্রিÝ', 'মোগাদিসু', 'ডাকার', 'নাইরোবি', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(116, 'Man did not know that the earth moves round the sun until it was -', 'discovered', 'experimented', 'hypothesiged', 'invented', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(117, 'কোনটির অর্থ ভিন্ন?', 'মনিকাঞ্চন যোগ', 'আম দুধে মেশা', 'আদায় কাঁচকলায়', 'সোনায় সোহাগা', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(118, 'নিচের শব্দগুলোর মধ্যে কোনটি সমগোত্রীয় নয়?', 'Plane', 'Car', 'Scooter', 'Truck', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(119, 'caft foged?', 'Aluminum', 'Iron', 'Copper', 'Mercury', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(120, 'নিচের শব্দগুলোর মধ্যে ৩টি সমগোত্রীয়। কোন শব্দটি আলাদা?', 'Conventional', 'Peculiar', 'Conservative', 'Traditional', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(121, 'নিচের শব্দগুলোর মধ্যে ৩টি সমগোত্রীয়। কোন শব্দটি আলাদা?', 'Conventional', 'Peculiar', 'Conservative', 'Traditional', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(122, 'নিচের কোন শব্দটি ভিন্ন ধরনের?', 'চাঁদ', 'মঙ্গল', 'cøy‡Uv', 'পৃথিবী', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(123, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'মানসী', 'সোনার তরী', 'শেষ লেখা', 'শেষের কবিতা', 'ক্ষণিকা', NULL, '4', 10, 'yes', 'exam', 'final'),
(124, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'ঝিলিমিলি', 'বাঁধনহারা', 'মৃত্যুক্ষুধা', 'সোনার তরী', 'কুহেলিকা', NULL, '4', 10, 'yes', 'exam', 'final'),
(125, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'XvKv', 'ivRkvnx', 'Lyjbv', 'h‡kvi', 'wm‡jU', NULL, '4', 10, 'yes', 'exam', 'final'),
(126, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'সীমা', 'iæbv', '¯^Y©v', 'SY©v', 'রিপন', NULL, '5', 10, 'yes', 'exam', 'final'),
(127, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'ইত্তেফাক', 'জনকণ্ঠ', 'দ্য ডেইলি স্টার', 'প্রথম আলো', 'ইনকিলাব', NULL, '3', 10, 'yes', 'exam', 'final'),
(128, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'জাভা', 'অস্ট্রেলিয়া', 'সেন্ট হেলনা', 'সুমাত্রা', 'মাদাগাস্কার', NULL, '3', 10, 'yes', 'exam', 'final'),
(129, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'ডেনমার্ক', 'ভিয়েতনাম', 'ফিনল্যান্ড', 'নরওয়ে', 'সুইডেন', NULL, '2', 10, 'yes', 'exam', 'final'),
(130, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'জাপানিজ', 'চীনা', 'কোরিয়ান', 'ফারসি', 'd«vÝ', NULL, '5', 10, 'yes', 'exam', 'final'),
(131, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'পৃথিবী', 'চাঁদ', 'পুটো', 'মঙ্গল', 'ইউরেনাস', NULL, '2', 10, 'yes', 'exam', 'final'),
(132, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'কাগজ', 'কলম', 'খাতা', 'জামা', 'বই', NULL, '4', 10, 'yes', 'exam', 'final'),
(133, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'আলু', 'পটল', 'বেগুন', 'ফুলকপি', 'বাধাকপি', NULL, '1', 10, 'yes', 'exam', 'final'),
(134, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'ব্যাডমিন্টন', 'ক্রিকেট', 'হকি', 'দাবা', 'টেনিস', NULL, '4', 10, 'yes', 'exam', 'final'),
(135, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'এগার', 'তের', 'পনের', 'সতের', 'উনিশ', NULL, '3', 10, 'yes', 'exam', 'final'),
(136, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'নিধি', 'উদক', 'নীর', 'জীবন', 'সলিল', NULL, '1', 10, 'yes', 'exam', 'final'),
(137, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'বাঁশি', 'হারমোনিয়াম', 'পিয়ানো', 'তবলা', 'টেলিফোন', NULL, '5', 10, 'yes', 'exam', 'final'),
(138, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'কাকা', 'মামা', 'ফুফু', 'দাদী', 'ভাই', NULL, '2', 10, 'yes', 'exam', 'final'),
(139, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'শরীক', 'শিরণাম', 'শষ্য', 'শ্রীমতি', 'শ্রমজীবী', NULL, '5', 10, 'yes', 'exam', 'final'),
(140, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'গরু', 'ভেড়া', 'মহিষ', 'মুরগী', 'ছাগল', NULL, '4', 10, 'yes', 'exam', 'final'),
(141, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'একরাত্রি', 'সমাপ্তি', 'দৃষ্টিদান', 'মাল্যদান', 'জাপান যাত্রী', NULL, '5', 10, 'yes', 'exam', 'final'),
(142, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'মিশিগান', 'ভিক্টোরিয়া', 'মিসিসিপি', 'ইরি', 'বৈকাল', NULL, '3', 10, 'yes', 'exam', 'final'),
(143, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'চরিত্রহীন', 'দেনাপাওনা', 'পল্লী সমাজ', 'নৌকাডুবি', 'শেষের পরিচয়', NULL, '4', 10, 'yes', 'exam', 'final'),
(144, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'তিমির', 'অশ্ব', 'তুরঙ্গ', 'বাজী', 'তুরগ', NULL, '1', 10, 'yes', 'exam', 'final'),
(145, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'তপন', 'দিবাকর', 'অবণী', 'প্রভাকvর', 'সবিতা', NULL, '3', 10, 'yes', 'exam', 'final'),
(146, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'শাপলা', 'গোলাপ', 'কাঁঠাল', 'রয়েল বেঙ্গল টাইগার', 'ইলিশ', NULL, '2', 10, 'yes', 'exam', 'final'),
(147, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', '৫ নং সেক্টর', '২ নং সেক্টর', '১০ নং সেক্টর', '১১ নং সেক্টর', '৬ নং সেক্টর', NULL, '3', 10, 'yes', 'exam', 'final'),
(148, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'অ্যালবাট্রস', 'হামিং বার্ড', 'সুইফট বার্ড', 'কিং কোবরা', 'পেলিক্যান', NULL, '4', 10, 'yes', 'exam', 'final'),
(149, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'মুখস্ত', 'মজুরী', 'মস্তিষ্ক', 'মৎস', 'মিতালী', NULL, '3', 10, 'yes', 'exam', 'final'),
(150, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'জামা', 'প্যান্ট', 'লুঙ্গি', 'গামছা', 'শাড়ী', NULL, '4', 10, 'yes', 'exam', 'final'),
(151, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', '২০তম বিসিএস', '২১তম বিসিএস', '২৬তম বিসিএস', '২৪তম বিসিএস', '২৫তম বিসিএস', NULL, '3', 10, 'yes', 'exam', 'final'),
(152, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'লোট্সি', 'নিউগিনি', 'গ্রিনল্যান্ড', 'বোর্নিও', 'সুমাত্রা', NULL, '1', 10, 'yes', 'exam', 'final'),
(153, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Amity', 'Accord', 'Friendship', 'Enmity', 'Fraternity', NULL, '4', 10, 'yes', 'exam', 'final'),
(154, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Pen', 'Paper', 'Book', 'Scale', 'Ball', NULL, '5', 10, 'yes', 'exam', 'final'),
(155, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Sunday', 'Monday', 'Holiday', 'Friday', 'Wednesday', NULL, '3', 10, 'yes', 'exam', 'final'),
(156, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Iron', 'Silver', 'Gold', 'Cold', 'Copper', NULL, '4', 10, 'yes', 'exam', 'final'),
(157, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Analogous', 'Similar', 'Comparable', 'Equivalent', 'Disparate', NULL, '5', 10, 'yes', 'exam', 'final'),
(158, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Bangladesh', 'Pakistan', 'Nepal', 'Japan', 'India', NULL, '4', 10, 'yes', 'exam', 'final'),
(159, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Minute', 'Hour', 'Talk', 'Week', 'Day', NULL, '3', 10, 'yes', 'exam', 'final'),
(160, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Corpulent', 'Rotund', 'Bulky', 'Slim', 'Stout', NULL, '4', 10, 'yes', 'exam', 'final'),
(161, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'River', 'Ocean', 'Pond', 'Land', 'Sea', NULL, '4', 10, 'yes', 'exam', 'final'),
(162, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Mouth', 'Teeth', 'Head', 'Ear', 'Chew', NULL, '3', 10, 'yes', 'exam', 'final'),
(163, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Contempt', 'Disdain', 'Clemency', 'Neglect', 'Derision', NULL, '4', 10, 'yes', 'exam', 'final'),
(164, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'IDA', 'IBRD', 'IFC', 'IMF', 'MIGA', NULL, '4', 10, 'yes', 'exam', 'final'),
(165, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'France', 'Germany', 'Netherlands', 'Hungary', 'Brazil', NULL, '3', 10, 'yes', 'exam', 'final'),
(166, 'অসামঞ্জস্যপূর্ণ শব্দটি বের করুন', 'Hen', 'Dog', 'Cow', 'Goat', 'Elephant', NULL, '1', 10, 'yes', 'exam', 'final'),
(167, 'It is impossible for a letter to be delivered without', 'stamp', 'a subject', 'an address', 'editing', 'an envelope', NULL, '5', 10, 'yes', 'exam', 'final'),
(168, '-----ছাড়া বিলাসবহুল জীবন-যাপন করা অসম্ভব।', 'প্রাসাদ', 'ক্যাডিলাক গাড়ি', 'সম্পদ', 'তথ্য', 'g‡bi kvwšÍ', NULL, '3', 10, 'yes', 'exam', 'final'),
(169, '----ছাড়া বাজার হয় না।', 'ব্যবসা', 'কাদা', 'সরবরাহ ব্যবস্থা', 'পানি', 'বাতাস', NULL, '3', 10, 'yes', 'exam', 'final'),
(170, '-----ছাড়া সাহসী হওয়া যায় না।', 'অস্ত্র', 'বন্ধু', 'অর্থ', 'সাহস', 'চরিত্র', NULL, '4', 10, 'yes', 'exam', 'final'),
(171, '----ছাড়া আধুনিক জীবন-যাপন করা যায় না।', 'ফ্যাশন', 'বিদ্যুৎ', 'দামী জুতা', 'গাড়ি', 'অলংকার', NULL, '2', 10, 'yes', 'exam', 'final'),
(172, '----ছাড়া দোকান অসম্ভব।', 'ক্রেতা', 'পণ্য', 'তালা', 'বিভিন্নতা', 'ঘর', NULL, '2', 10, 'yes', 'exam', 'final'),
(173, '-----ছাড়া নদী কল্পনা করা যায় না।', 'বালু', 'তীর', 'স্রোত', 'জোয়ার', 'ভাটা', NULL, '2', 10, 'yes', 'exam', 'final'),
(174, '-----ছাড়া কাজ করা অসম্ভব।', 'টাকা', 'সাহায্য', 'দিক-নির্দেশন', 'ধৈর্য', 'কর্মী', NULL, '3', 10, 'yes', 'exam', 'final'),
(175, '-----ছাড়া আলাপ করা অসম্ভব।', 'একটি নির্দিষ্ট বিষয়', 'অন্তত দুজন লোক', 'সামনাসামনি না বসে', 'বুদ্ধি', 'ঐকমত্য', NULL, '2', 10, 'yes', 'exam', 'final'),
(176, '-----ছাড়া একটি শব্দ কল্পনা করা অসম্ভব।', 'অর্থ', 'স্বরবর্ণ', 'বাক্য', 'শব্দকোষ', 'সঠিক বানান', NULL, '1', 10, 'yes', 'exam', 'final'),
(177, '-----ছাড়া ভাইঙ্গেপার কল্পনা করা অসম্ভব।', 'তলা', 'লিফট', 'দশ তলা', 'গ্রাম', 'লক্ষপতি', NULL, '2', 10, 'yes', 'exam', 'final'),
(178, 'যা ছাড়া অভিনয় অসম্ভব।', 'মঞ্চ', 'পোশাক', 'প্রসাধনী', 'দর্শক', 'বক্তব্য', NULL, '1', 10, 'yes', 'exam', 'final'),
(179, 'যা ছাড়া সেলাই করা অসম্ভব।', 'মেশিন', 'সূচ', 'দর্জি', 'হাত', 'অনুশীলন', NULL, '2', 10, 'yes', 'exam', 'final'),
(180, 'যা ছাড়া রংধনু দেখা অসম্ভভ।', 'রোদের কিরণ', 'বৃষ্টি', 'খালি চোখ', 'দিনের বেলা', 'পরিষ্কার আকাশ', NULL, '3', 10, 'yes', 'exam', 'final'),
(181, 'যা ছাড়া তাৎক্ষণিক বক্তৃতা দেয়া অসম্ভব।', 'প্রস্তুতি', 'উপস্থিত বুদ্ধি', 'মাইক্রোফোন', 'শ্রোতা', 'মঞ্চ', NULL, '2', 10, 'yes', 'exam', 'final'),
(182, 'সিংহীর পক্ষে যা অসম্ভব।', 'বন্দী অবস্থায় হিংস্র হওয়া', 'চিড়িয়াখানায় বেঁচে থাকা', 'মাংস পছন্দ করা', 'সার্কাসে খেলা দেখানো', 'কেশর থাকা', NULL, '5', 10, 'yes', 'exam', 'final'),
(183, 'দৈনিক পত্রিকার পক্ষে যা অসম্ভব।', 'সাপ্তাহিক লেখা প্রকাশ', 'ব্যাপক বিক্রয়', 'জনমত জরিপ', 'সাপ্তাহিক ছুটি ভোগ', 'সরকার বিরোধিতা', NULL, '3', 10, 'yes', 'exam', 'final'),
(184, 'একজন গোয়েন্দার পক্ষে যা অসম্ভব।', 'সূত্র ছাড়া রহস্যের সমাধান করা', 'ষষ্ঠ ইন্দ্রিয় থাকা', 'ছদ্মবেশ নেয়া', 'খণ্ডকালীন পেশা গ্রহণ', 'বন্দুক বহন করা', NULL, '2', 10, 'yes', 'exam', 'final'),
(185, 'যে অঙ্গ ছাড়া জীব অসম্ভব।', 'নাক', 'কান', 'মুখ', 'পা', 'লেজ', NULL, '1', 10, 'yes', 'exam', 'final'),
(186, 'যা ছাড়া সাহস অসম্ভব।', 'শক্তি', 'ধৈর্য', 'খাদ্য', 'অর্থ', 'ক্ষমতা', NULL, '2', 10, 'yes', 'exam', 'final'),
(187, 'ছাড়া অফিস চালানো অসম্ভব।', 'গাড়ি', 'টেলিফোন', 'বিদ্যুৎ', 'কর্মকর্তা/কর্মচারী', 'পুলিশ', NULL, '3', 10, 'yes', 'exam', 'final'),
(188, 'Painter: Brush: Writer: ?', 'Word', 'Book', 'Paper', 'Reader', 'Pen', NULL, '5', 10, 'yes', 'exam', 'final'),
(189, 'Salesperson: Commission: Waiter:  ?', 'Hotel', 'Food', 'Order', 'Tip', 'Menu', NULL, '4', 10, 'yes', 'exam', 'final'),
(190, 'Words: Speech: Page: ?', 'Picture', 'Book', 'Chapter', 'Topic', 'Subject', NULL, '2', 10, 'yes', 'exam', 'final'),
(191, 'Traffic police: Traffic: Referee: ?', 'Coach', 'Game', 'Team', 'Match', 'Player', NULL, '2', 10, 'yes', 'exam', 'final'),
(192, 'Burn: Ashes:: Freeze: ?', 'Chill', 'Ice', 'Freshness', 'Hard', 'congealment', NULL, '2', 10, 'yes', 'exam', 'final'),
(193, 'Food: Hunger:: Water: ?', 'Desire', 'Thirst', 'Dehydrate', 'Heat', 'Humidity', NULL, '2', 10, 'yes', 'exam', 'final'),
(194, 'Gymnasium: Exercise:: University: ?', 'Student', 'Class', 'Study', 'Teacher\r\n', 'Laboratory ', NULL, '3', 10, 'yes', 'exam', 'final'),
(195, 'বিরক্তি: ভ্রুকুঞ্চন:: হতাশা: ?', 'বিষণ্নতা', 'নিদ্রাহীনতা', 'মাদকাসক্তি', 'নির্লিপ্ততা', '\'xN©k^vm', NULL, '5', 10, 'yes', 'exam', 'final'),
(196, 'সুর্যালোক: অন্ধকার:: নীরবতা: ?', 'চঞ্চলতা', 'স্নিগ্ধতা', 'মুখরতা', 'উজ্জ্বল', 'সঙ্গীত', NULL, '1', 10, 'yes', 'exam', 'final'),
(197, '¯^vaxb: নির্ভয়:: সংশয় ?', 'বিস্ময়', 'নির্ভয়', 'দ্বিধা', 'প্রত্যয়', 'বিরক্তি', NULL, '3', 10, 'yes', 'exam', 'final'),
(198, 'মিনিট: সেকেন্ড:: দিন: ?', 'রাত', 'সকাল', 'ঘন্টা', 'ঘড়ি', 'মাস', NULL, '3', 10, 'yes', 'exam', 'final'),
(199, 'লক্ষ্মী: পেঁচা:: শাসিত্ম ?', 'চড়াই', 'কবুতর', 'চিল', 'কাক', 'বাদুড়', NULL, '2', 10, 'yes', 'exam', 'final'),
(200, 'হিংস্র: সিংহ:: শাসিত্ম: ?', 'উঠ', 'মেঘ', 'হরিণ', 'বিড়াল', 'হাস', NULL, '4', 10, 'yes', 'exam', 'final'),
(201, 'আয়: সঞ্চয়:: ব্যয়: ?', 'অপচয়', 'কপর্দকহীন', 'বিলাসিত', 'ঋণ', 'বিনিয়োগ', NULL, '4', 10, 'yes', 'exam', 'final'),
(202, 'কুসংস্কার: শিড়্গা:: ব্যাধি ?', 'পরিচ্ছন্নতা', 'পুষ্টিকর খাদ্য', 'চিকিৎসক ', 'চিকিৎসা', 'সচেতনতা', NULL, '4', 10, 'yes', 'exam', 'final'),
(203, 'আগ্নেয়গিরি: লাভা:: হিমবাহ: ?', 'পানি', 'বরফ', 'জমাট অক্সিজেন', 'সাগর', 'জমাট খনিজ পদার্থ', NULL, '1', 10, 'yes', 'exam', 'final'),
(204, 'Art: Culture: education: ?', 'college', 'skill', 'scholarship', 'wealth', 'smart', NULL, '2', 10, 'yes', 'exam', 'final'),
(205, 'Pin: head:: needle: ?', 'prick', 'sew', 'eye', 'point', 'thread', NULL, '3', 10, 'yes', 'exam', 'final'),
(206, 'Cow: chess:: tree: ?', 'log', 'flower', 'shadow', 'fertilizer', 'table', NULL, '5', 10, 'yes', 'exam', 'final'),
(207, 'Time: watch:: pressure: ?', 'barometer', 'force ', 'hard', 'meter', 'instrument', NULL, '1', 10, 'yes', 'exam', 'final'),
(208, 'Water: evaporate:: ice: ?', 'cold', 'snow', 'fall', 'melt', 'flow', NULL, '4', 10, 'yes', 'exam', 'final'),
(209, 'মহাসমুদ্র: হ্রদ:: মহাদেশ: ?', 'নদী', 'ভূমি', 'পাহাড়', 'দ্বীপ', 'আইন', NULL, '4', 10, 'yes', 'exam', 'final'),
(210, 'প্রদীপ: অন্ধকার:: শিড়্গা: ?', 'উন্নতি', 'কুসংস্কার', 'সংস্কার', 'কৃষ্টি', 'জ্ঞান', NULL, '2', 10, 'yes', 'exam', 'final'),
(211, 'আবিষ্কার: প্রয়োজন:: গরম: ?', 'তৃষ্ণা', 'ঠান্ডা', 'ঘাম', 'তাপ', 'বৃষ্টি', NULL, '4', 10, 'yes', 'exam', 'final'),
(212, 'অপরাধ: অপরাধবোধ:: ভুল: ?', 'লজ্জা', 'শানিত্ম', 'অনুতাপ', 'ভয়', 'সংশয়', NULL, '3', 10, 'yes', 'exam', 'final'),
(213, 'চাঁদ: জ্যোৎস্না:: সূর্য: ?', 'সূর্যকিরণ', 'তাপ', 'দিন', 'সূর্যগ্রহণ', 'গতি', NULL, '2', 10, 'yes', 'exam', 'final'),
(214, 'জনপ্রিয়তা: গর্ব:: প্রত্যাখ্যান: ?', 'অবহেলা', 'ব্যর্থতা', 'হতাশা', 'অযোগ্যতা\r\n', 'বিমর্ষতা', NULL, '3', 10, 'yes', 'exam', 'final'),
(215, 'চেহারা: অভিব্যক্তি:: আকাশ: ?', 'মেঘ', 'জলবায়ু', 'আবহাওয়া', 'জ্যোতির্বিদ্যা', 'ধূমকেতু', NULL, '1', 10, 'yes', 'exam', 'final'),
(216, 'ঘড়ি: কাঁটা:: থার্মোমিটার: ?', 'ফারেনহাইট', 'পারদ', 'কাচ', 'তাপমাত্রা', 'অসুস্থতা', NULL, '2', 10, 'yes', 'exam', 'final'),
(217, 'প্রাচুর্য: সম্পদ:: ¯^íZv ?', 'অনটন', 'হীনমন্যতা', 'নিচুতা', 'শূন্যতা', 'দুর্ভিড়্গ', NULL, '1', 10, 'yes', 'exam', 'final'),
(218, 'Bank: Transaction:: Hospital: ?', 'Treatment', 'Patient', 'Medicine', 'Water', 'Dettol', NULL, '1', 10, 'yes', 'exam', 'final'),
(219, 'Milk: Cheese:: Tree: ?', 'Flower', 'Shadow', 'Wood', 'Table', 'Fruit', NULL, '3', 10, 'yes', 'exam', 'final'),
(220, 'Engine: Oil:: Human: ?', 'Money', 'Food', 'Water', 'Mind\r\n', 'Behavior', NULL, '2', 10, 'yes', 'exam', 'final'),
(221, 'কুসংস্কার: শিড়্গা:: ব্যাধি: ?', 'পরিচ্ছন্নতা', 'পুষ্টিকর', 'চিকিৎসক', 'চিকিৎসা', 'সচেতনতা', NULL, '4', 10, 'yes', 'exam', 'final'),
(222, 'অপরাধ: অনুতাপ:: ভুল: ?', 'শাসিত্ম', 'ভয়', 'লজ্জা', 'সংশয়', 'অন্যায়', NULL, '3', 10, 'yes', 'exam', 'final'),
(223, 'জজসাহেব: আদালত:: ডাক্তার: ?', 'ক্লিনিক', 'হাসপাতাল', 'রম্নগী\r\n', '‡P¤^vi', 'ল্যাবরেটরি', NULL, '2', 10, 'yes', 'exam', 'final'),
(224, 'Car: Road:: Train: ?', 'Ticket', 'Railway', 'Passenger', 'Station', 'Bridge', NULL, '2', 10, 'yes', 'exam', 'final'),
(225, 'Cinema: Entertainment:: Bus: ?', 'Communication', 'Reading', 'Passenger', 'Accident', 'Bridge', NULL, '1', 10, 'yes', 'exam', 'final'),
(226, 'Fish: Water:: Tiger: ?', 'Deer', 'Forest', 'Zoo', 'flesh', 'ferocious', NULL, '2', 10, 'yes', 'exam', 'final'),
(227, 'Breakfast: First: Super: ?', 'Noon', 'Night', 'Meal', 'Last', 'dinner', NULL, '4', 10, 'yes', 'exam', 'final'),
(228, 'Wise; Fool:: Modest: ?', 'Vain', 'Preity', 'Conceited', 'Ugly', 'Rough', NULL, '3', 10, 'yes', 'exam', 'final'),
(229, 'Hailstorm: Destruction:: Brainstorm: ?', 'Construction', 'Innovation', 'Neuroticism', 'Resolution', 'Disorientation', NULL, '3', 10, 'yes', 'exam', 'final'),
(230, 'Toy: Child:: Gun: ?', 'Crime', 'Bullet ', 'Police', 'License', 'Army', 'Stage', '6', 10, 'yes', 'exam', 'final'),
(231, 'জন্ম: জীবন:: অড়্গর: ?', 'শিড়্গা', 'স্কুল', 'জ্ঞান', 'নিরড়্গর', 'বর্ণমালা', NULL, '5', 10, 'yes', 'exam', 'final'),
(232, 'মক্কেল: উকিল:: থিয়েটার: ?', 'টিকেট', 'পৃষ্ঠপোষক', 'মালিক', 'দর্শক', 'ঘটনা', NULL, '4', 10, 'yes', 'exam', 'final'),
(233, 'বন: মরম্নভূমি:: লোকালয়: ?', 'জলাশয়', 'নির্জন', 'মরূদ্যান', 'গ্রাম', 'সমাজ', NULL, '2', 10, 'yes', 'exam', 'final'),
(234, 'মণিপুরী: সিলেট:: সাঁওতাল: ?', 'বরিশাল', 'দিনাজপুর', 'পটুয়াখালী', 'ঢাকা', 'ময়মনসিংহ', NULL, '2', 10, 'yes', 'exam', 'final'),
(235, 'শ্রম: উৎপাদন:: পরিশ্রম: ?', 'দড়্গতা', 'সফলতা', 'খ্যাতি', 'উন্নতি', 'বুদ্ধি', NULL, '2', 10, 'yes', 'exam', 'final'),
(236, '¸iæRb: ভক্তি:: শিশু: ?', 'শাসন', 'আদর', 'যত্ন', 'ভালোবাসা', 'স্নেহ', NULL, '2', 10, 'yes', 'exam', 'final'),
(237, 'স্কুল: শৃঙ্খলা:: মসজিদ: ?', 'প্রার্থনা', 'পবিত্রতা', 'নিরবতা', 'পরিচ্ছন্নতা', 'প্রশানিত্ম', NULL, '2', 10, 'yes', 'exam', 'final'),
(238, 'Paper: File:: Hair: ?', 'Comb', 'Oil', 'Dye', 'Clip', 'Parlour', NULL, '4', 10, 'yes', 'exam', 'final'),
(239, 'শিশু: দুধ:: রোগী: ?', 'ঔষধ', 'যত্ন', 'পথ্য', 'ডাক্তার', 'সেবা', NULL, '3', 10, 'yes', 'exam', 'final'),
(240, 'বৃষ্টি: বন্যা:: রৌদ্র: ?', 'তাপ', 'আলো', 'গরম', 'খরা', 'সুর্য', NULL, '4', 10, 'yes', 'exam', 'final'),
(241, '………Qvov কাউকে ফোন করা অসম্ভব ?', 'ফোন b¤^I', 'আত্বীয়তা', 'মোবাইল b¤^i', 'বন্ধুত্ব', 'পরিচয়', NULL, '3', 10, 'yes', 'exam', 'final'),
(242, 'মরম্নভূমি অঞ্চলের মানুষের জন্য অসম্ভব হলো ?', 'যাযাবর হওয়া', 'ধর্মপ্রাণ হওয়া', 'মৎস্যজীবী হওয়া', '¯^v¯’¨evb হওয়া', 'শিড়্গিত হওয়া', NULL, '3', 10, 'yes', 'exam', 'final'),
(243, 'যা ছাড়া এনসাইক্লোপিডিয়ার কথা চিনত্মা করা অসম্ভব-', 'ছবি', 'তথ্য', 'বাংলায় লেখা', 'স্থানীয়ভাবে প্রকাশিত', 'একজনের সংকলন ', NULL, '2', 10, 'yes', 'exam', 'final'),
(244, 'একজন নার্সের পড়্গে অসম্ভব-', 'ক্লিনিকের মালিকা nIqv', 'রম্নগীকে সানত্ম্বনা দেয়া', 'ডাক্তারকে সাহায্য করা ', 'অস্ত্রোপচার করা', 'ইনজেকশন দেয়া', NULL, '4', 10, 'yes', 'exam', 'final'),
(245, 'It is impossible for a traffic police to control traffic without –', 'traffic light ', 'a uniform', 'using a traffic island ', 'a sticks', 'using his voice', NULL, '2', 10, 'yes', 'exam', 'final'),
(246, 'একটি ছবি দেখিয়ে তিন্নী বললো, ‘সে আমার দাদার একমাত্র ছেলের ছেলে’ \r\nছবির ছেলেটির সাথে তিন্নীর সম্পর্ক কি ?\r\n', 'ভাই', 'চাচা', 'ছেলে', 'কোন সম্পর্ক নেই', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(247, 'আপনার মায়ের শশুরের একমাত্র পুত্রবধু আপনার', 'চাচী', 'ফুফি', 'বোন', 'মা', 'মামি', NULL, '4', 10, 'yes', 'exam', 'final'),
(248, 'পাঁচজন ব্যক্তি ট্রেনে ভ্রমণ করছেন। তাঁরা হলে ক, খ,গ,ঘ,ঙ। ক হলেন গ এর মা, গ আবার ঙ এর স্ত্রী। ঘ হলেন ক এর ভাই এবং খ হলেন ক এর ¯^vgx| ঙ এর সঙ্গে খ এর সম্পর্ক কী ?', 'শশুর', 'পিতা', 'চাচা', 'ভাই\r\n', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(249, 'একজন মহিলা  একজন পুরম্নষকে ইঙ্গিত করে বললেন, ঐ পুরম্নষের পিতা হলেন আমার শশুর। পুরম্নষটির সাথে মহিলার সম্পর্ক কী ?', 'পিতা', 'পুত্র', 'জামাই', '¯^vgx', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(250, 'ঘ-এর মাতা গ। ঘ-গ এর  কন্যা নয়। এতএব, ঘ ও গ-এর  মধ্যেকার সম্পর্ক কী ?', 'ঘ, গ-এর ছেলে', 'ঘ ও গ ভাই', 'ঘ, গ-এর দাদা', 'কোন সম্পর্ক নেই', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(251, 'ক খ-এর পুত্র। খ ও গ পরস্পর ভাই। ঘ হচ্ছে গ-এর মা। চ ঘ-এর কন্যা। সম্পর্কে চ ক-এর কী হয় ?', 'খালা', 'দাদী', 'নানী', 'ফুফু', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(252, 'একটি ছবিকে দেখিয়ে হারম্নন নামের একটি ছেলে বললো, ‘সে আমার মায়ের একমাত্র ছেলের ছেলে। সম্পর্কে হারম্নন ঐ ছেলের কী হয় ?', 'দাদা', 'বাবা', 'চাচা', 'ভাই', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(253, 'P এবং Q দুই ভাই। R এবং S দুই বোন। P-Gi ছেলে হলো S-Gi ভাই। তাহলে Q হলো R এর ', 'পুত্র', 'ভাই', 'পিতা', 'চাচা', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(254, 'আপনার ফুফির ভাইয়ের ছেলে আপনার', 'মামা', 'দাদা', 'চাচা', 'ভাই', 'ভাগ্নে', NULL, '4', 10, 'yes', 'exam', 'final'),
(255, 'আপনার বাবার বোনের বাবার ছেলের মেয়ের ছেলে আপনার-', 'ভাগ্নে', 'ভাই', 'কাকা', 'দাদা', 'চাচা', NULL, '1', 10, 'yes', 'exam', 'final'),
(256, 'আপনার বাবার বোনের ছেলের একমাত্র মামা আপনার-', 'কাকা', 'দাদা', 'মামা', 'বাবা\r\n', 'নানা', NULL, '4', 10, 'yes', 'exam', 'final'),
(257, 'রনি,জনিকে  বলল তোমার মামা আমার মায়ের ভাই, রনি ও জনির  সম্পর্ক-', 'চাচা-ভাতিজা ', 'ভাই-ভাই', 'নানা-নাতি	', 'মামা-ভাগ্নে', 'কোনটিই নয়', NULL, '2', 10, 'yes', 'exam', 'final'),
(258, 'রত্না অপুর বোন, শিপু রত্নার ভাই। শিপু ও অপুর সম্পর্ক-', 'ভাই-ভাই', 'মামা-ভাগ্নে', 'চাচা-ভাতিজা', 'বেয়াই-বেয়াই', 'নানা-নাতি', NULL, '1', 10, 'yes', 'exam', 'final'),
(259, 'সুফিয়া এক ভদ্র মহিলার ঘেও ঢুকে দেখল দেওয়ালে একটি ছবি টাঙ্গানো। সুফিয়া জানতে চাইলেন ছবিটি কার ? ভদ্রমহিলা বললেন, সে আমাকে মা বলে ডাকে। তবে ছবিটি  কোন ছেলের নয়। আমার ভদ্রমহিলার মেয়ে সনত্মান নেই। তাহলে ছবিটির ব্যক্তি হল ভদ্রমহিলার-', 'ভাগনি', 'ননদ', 'ছেলের বউ', 'নাতনি', 'মা', NULL, '3', 10, 'yes', 'exam', 'final'),
(260, 'ঝর্নার সামনে রয়েছে একটি ফটোগ্রাফ। ঝর্ণা তার বান্ধবীকে ফটোগ্রাফটি দেখিয়ে বলছে একটি আমার বোন নয় তবে আমার মায়েরই সনত্মান। তাহলে ফটোগ্রাফটির সাথে ঝর্ণার সম্পর্ক-', 'ভাই-বোন', 'খালা-ভাগনে', 'চাচী-ভাতিজা	', 'মা ও ছেলে', 'কোনটিই নয়', NULL, '1', 10, 'yes', 'exam', 'final'),
(261, 'নিশাত ছবির ছেলে। নিশাতের দাদার মেয়ের ছেলের একজনই মামা আছে। ছবির সাথে ওই মামার  সম্পর্ক কী ?', '¯^vgx', 'চাচা', 'দাদা', 'খালু', 'ভগ্নিপতি', NULL, '1', 10, 'yes', 'exam', 'final'),
(262, 'আপনার মায়ের বোনের ছেলের একমাত্র খালার মেয়ে আপনার-', 'খালা', 'ফুফি', 'বোন', 'চাচী\r\n', 'মামি', NULL, '3', 10, 'yes', 'exam', 'final'),
(263, 'A B-Gi তুলনায় খাটো কিন্তু C-Gi চেয়ে j¤^v| D A-Zzjbvq খাটো কিন্তু A-Gi চেয়ে j¤^v| উচ্চতার দিক থেকে মাঝারি কে ?', 'A', 'B', 'C', 'D', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(264, 'একজন মহিলা একজন পুরম্নষকে ইঙ্গিত করে বললেন, ঐ পুরম্নষের পিতা হলেন আমার k^ïi পুরম্নষটির সাথে মহিলার সম্পর্ক ?', 'পিতা', 'পুত্র', 'জামাই', '¯^vgx', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(265, 'ক, খ-এর পুত্র। খ  এবং গ পরস্পর বোন। ঘ হচ্ছে গ-এর মা, চ ঘ-এর পুত্র।  চ-এর সঙ্গেক-এর সম্পর্ক কী ?', 'ক-এর মামা চ  ', 'ক-এর  খালু চ', 'চ-এর নানা ক', 'ক-এর চাচা চ', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(266, 'আপনার কাকার  একমাত্র বড় ভাইয়ের মেয়ের ছোট ভাই আপনার-', 'ভাগ্নে', 'ভাতিজা', 'ভাই', 'মামা', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(267, 'P হচ্ছে Q-Gi পিতা  কিন্তু Q, P-Gi ছেলে নয়। তাদের সম্পর্কটা কোন ধরনের ?', 'পিতা-মাতা', 'ভাই-বোন', 'মেয়ে-পিতা', 'ছেলে-মেয়ে', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(268, 'নিপু,মমি, নাহিদ,বরম্নণ ও জাফর এর মধ্যে নিপু, মমি থেকে j¤^v| নাহিদ, জাফর থেকে বেঁটে। নিপু, বরম্নণ  থেকে বেঁটে। মমি, জাফর থেকে j¤^v| সবচেয়ে j¤^vi ঠিক পরেই কে ?', 'নাহিদ', 'নিপু', 'জাফর', 'বরম্নন', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(269, 'P, Q থেকে j¤^v| Q, R-Gi থেকে j¤^v| M, N থেকে j¤^v| N, Q  অপেড়্গা j¤^v| কে সব থেকে বেঁটে ?', 'P', 'Q', 'R', 'N', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(270, 'A, B এর ছবি দেখিয়ে বলল, সে আমার দাদার একমাত্র ছেলের বউয়ের মেয়ে। B এর মা A এর কি হয়?', 'খালা', 'ফুফু', 'মা', 'চাচী', 'কোনটিই নয়', NULL, '3', 10, 'yes', 'exam', 'final'),
(271, 'আপনার চাচার একমাত্র বড় ভাইয়ের মেয়ের ছোট ভাই আপনার সম্পর্কে কী হয় ?', 'ভাগ্নে', 'ভাতিজা', 'ভাই', 'মামা', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(272, 'P হচ্ছে Q-Gi পিতা, কিন্তু Q, P-Gi ছেলে নয়। তাদের সম্পর্কটা কোন ধরনের ?', 'পিতা-মাতা	 ', 'ভাই-বোন', 'মেয়ে-পিতা', 'ছেলে-মেয়ে ', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(273, 'একটি পার্টিতে একজন ব্যক্তি ও তার স্ত্রী তাদের দুই পুত্র ও তাদের স্ত্রী এবং প্রত্যেক পুত্রের ৪ জন করে সনত্মান ছিল। পার্টিতে মোট কতজন উপস্থিত ছিল ?', '১০ জন', '১৪ জন', '১২ জন	', '১৬ জন', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(274, 'নিপা ও শিপা হেঁটে যাচ্ছে। রাসত্মায় একটি লোক তাদের পরিচয় জানতে  চাইলে নিপা বলল, শিপা আমার বোন নয়। তার বাবা আমার মায়ের চাচা। তাহলে নিপার শিপার সম্পর্ক-', 'চাচাতো বোন  ', 'ফুফাতো বোন', 'খালাতো বোন', 'মামাতো বোন', 'খালাম্মা', NULL, '5', 10, 'yes', 'exam', 'final'),
(275, 'শফিকের বাবা যদি মান্নানের ভাইপো হয় এবং শাহরম্নখ যদি মান্নানের নাতি হয় তাহলে শাহরম্নল ও শফিকের মধ্যে সম্পর্ক-', 'জ্ঞাতি ভাই', 'খালাতো ভাই', 'চাচা-ভাতিজা', 'মামা-ভাগ্নে', 'চাচাতো ভাই', NULL, '1', 10, 'yes', 'exam', 'final'),
(276, 'আপনার ফুফির ভাইয়ের ছেলে আপনার-', 'মামা', 'দাদা', 'চাচা', 'ভাই', 'ভাগ্নে', NULL, '4', 10, 'yes', 'exam', 'final'),
(277, 'আপনার বাবার বোনের বাবার ছেলের মেয়ের ছেলে আপনার-', 'ভাগ্নে', 'ভাই', 'ভাই', 'কাকা', 'চাচা', NULL, '1', 10, 'yes', 'exam', 'final'),
(278, 'ঝর্ণার সামনে রয়েছে একটি ফটোগ্রাফ। ঝর্ণা তার বান্ধবীকে ফটোগ্রাফটি দেখিয়ে বলছে এটি আমার বোন নয় তবে আমার মায়ের সনত্মান। তাহলে ফটোগ্রাফটির সাথে ঝর্ণার সম্পর্ক -', 'ভাই-বোন', 'খালা-ভাগনে', 'চাচী-ভাতিজা', 'মা ও ছেলে', 'কোনটিই নয়', NULL, '1', 10, 'yes', 'exam', 'final'),
(279, 'পুুকুরে একজন মহিলা কাপড় ধুয়ে নিচ্ছে। এমন সময় একজন লোক এসে মহিলার সাথে কথা বলতে শুরম্ন করণ। রাসত্মা দিয়ে যাওয়ার সময় এক ভদ্রলোক এ দৃশ্য দেখে জানতে চাইল লোকটির সাথে মহিলার সম্পর্ক কি? মহিলা বলল সে আমার ছেলের মামীর শশুরের ছেলে। তাহলে লোকটি মহিলার ', '¯^vgx', 'ভাই', 'দেবর', 'বেয়াই', 'মামা', NULL, '2', 10, 'yes', 'exam', 'final'),
(280, 'পিতা ও পুত্র চট্টগ্রাম থেকে প্রাইভেট কার যোগে ঢাকায় আসার পথে কুমিলস্নায় পৌছানোর ঠিক পূর্বে একটি বাসের ধাক্কায় প্রাইভেট কারটি উল্টে গেলে পিতা ঘটনাস্থলে নিহত হয়। পুত্রকে মুমূর্ষ অবস্থায় কয়েকজন লোক ফেনী হাসপাতালে নিয়ে গেলে হাসপাতালের জরম্নরী বিভাগের কর্তব্যরত ডাক্তার তাকে দেখে  চিৎকার করে হায়, আমার ছেলে বলে অজ্ঞান হয়ে যায়, ডাক্তার এবং ঐ ছেলের মধ্যে সম্পর্ক -', 'পিতা-পুত্র', 'k^ïi-RvgvB', 'মা-ছেলে	', 'চাচা-ভাতিজা', 'মামা-ভাগ্নে', NULL, '3', 10, 'yes', 'exam', 'final'),
(281, 'রিপন, কিরণ ও রাজন তিন ভাই। রাজন এক মহিলাকে দেখিয়ে রিপনকে বলল ইনি আমার মামী, ইতোমধ্যে সেখানে এক ভদ্রলোক হাজির হলেন। ভদ্রলোক আবার রিপনের মামা, কিন্তু ভদ্র মহিলার ¯^vgx নয়। তাহলে ভদ্রলোক ও মহিলার সম্পর্ক -', 'মামি ও ভাগ্নে ', 'ভাবী ও দেবর', 'চাচী ও ভাতিজা', 'মা ও ছেলে', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(282, 'রিপন কিরণ ও রাজনের একমাত্র খালাত ভাই চন্দন রিপনের কাছে জানতে চাইল তার নানার মেয়ের একমাত্র ছেলের নাম ু-', 'চন্দন', 'রাজন', 'লিটন', 'রিপন', 'সুমন', NULL, '1', 10, 'yes', 'exam', 'final'),
(283, 'সুমনের বাবা জামিল সাহেব। সুমনের দাদুর মেয়ের ছেলের  একজন মামা আছেন। মামার সাথে সুমনের সম্পর্ক -', 'পিতা ও পুত্র', 'চাচা ও ভাতিজা', 'মামা ও ভাগ্নে', 'নানা ও নাতী', 'কোন সম্পর্ক নেই', NULL, '1', 10, 'yes', 'exam', 'final'),
(284, 'জরিনা বেগম রাসত্মা দিয়ে যাওয়ার সময় দেখল এক ভদ্রলোক একটি মেয়ের হাত ধরে যাচ্ছে মেয়েটির কাছে সে জানতে চাইল লোকটি মেয়েটির কি হয় ? মেয়েটি বলল আপনার সাথে আমার যে সম্পর্ক লোকটির সাথেও তাই। লোকটি মেয়েটির ভাইয়ের কাকা। তাহলে মেয়েটির সাথে জরিনা বেগমের সম্পর্ক -', 'মা ও মেয়ে', 'খালা ও ভাগনি', 'ফুফি ও ভাতিজি', 'চাচী ও মেয়ে', 'চাচী ও ভাতিজি', NULL, '3', 10, 'yes', 'exam', 'final'),
(285, 'একজন ভদ্রলোক তার স্ত্রীর সাথে ঘরে  বসে কথা বলছে। এমন সময় ঘরে আর একজন মহিলা প্রবেশ করে লোকটির পায়ে হাত দিয়ে সালাম করল, ঠিক তখনই তার স্ত্রীও উঠে গিয়ে ঐ মহিলার  পায়ে হাত দিয়ে সালাম করল। তাহলে ঐ মহিলার মধ্যে সম্পর্ক- ', 'সতীন', 'ননদ-ভাবী', 'দুই জা	', 'মা ও মেয়ে', 'মা ও মেয়ে', NULL, '1', 10, 'yes', 'exam', 'final'),
(286, 'যোবায়ের ও সরোয়ার দুই বন্ধু। S যোবায়েরের বোন, P সরোয়ারের ভাই। S এর মেয়ের বাবা P. তাহলে S ও P এর সম্পর্ক -', 'ভাই-বোন	 ', 'বেয়াই-বেয়ান', '¯^vgx-¯¿x', 'ননদ-ভাবী', 'দুই বন্ধু', NULL, '3', 10, 'yes', 'exam', 'final'),
(287, 'হীরা ও পান্না দুই বান্ধবী। রিকশায় করে কলেজে যাওয়ার সময় হঠাৎ হীরা রিকশা থেকে পড়ে গেল। পান্না তাকে নিয়ে হাসপাতালে যেতেই কতব্যরত ডাক্তার বললেন কি হয়েছে আমার মেয়ের। সব কথা শুনে হাসপাতালে ভর্তি করে নিলেন। তারপর পান্না হাসপাতাল থেকে ফিরে আসার সময় এক ভদ্রলোক তাকে বলল বাসায় ফোন পেয়ে চলে এলাম, কি হয়েছে আমার মেয়ের ? তাহলে কতব্যরত ডাক্তারের সাথে হীরার সম্পর্ক -', 'মা ও মেয়ে', 'কোন সম্পর্ক নেই', 'চাচী ও মেয়ে', 'চাচা ও মেয়ে', 'মামা ও ভাগনি', NULL, '1', 10, 'yes', 'exam', 'final'),
(288, 'মু্‌ক্তা আপনার ভাই। হীরা মানিকের বোন, মুক্তার বোন পান্না বলল, মানিক আমার ভাই তাহলে মুক্তা ও মানিকের সম্পর্ক-', 'চাচা-ভাতিজা', 'মামা-ভাগ্নে', 'দুই বন্ধু	', 'ভাই-ভাই', 'কোন সম্পর্ক নেই', NULL, '4', 10, 'yes', 'exam', 'final'),
(289, 'মি. জামান হলো মুক্ত ও হীরার পিতা। মুক্ত মি. জামানের ছেলে কিন্তু হীরা মি. জামানের ছেলে নয়। হীরা ও মি. জামানের মধ্যে সম্পর্ক কী ?', 'জামাই', 'সতীন', 'মেয়ে ও বাবা', 'দুই জা', 'ভাতিজি', NULL, '3', 10, 'yes', 'exam', 'final'),
(290, 'আপনার মায়ের বোনের ছেলের একমাত্র খালার মেয়ে আপনার-', 'খালা', 'ফুফি', 'বোন\r\n', 'চাচী', 'মামি', NULL, '3', 10, 'yes', 'exam', 'final'),
(291, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? Finger : Hand : Leaf : ?', 'Twig', 'Tree', 'Branch', 'Flower', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(292, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? Telephone : Cable : Radio : ?', 'Microphone', 'Wireless', 'Electricity', 'Wire', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(293, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? শব্দ : কর্ণ :: আলো : ?', 'শোনা', 'চক্ষু', 'বুদ্ধি', 'অন্ধকার', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(294, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? Words : writer ?', 'Laws : policeman', 'Butter : baker', 'Chalk : black board', 'Joy : emotion', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(295, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? Patron : support ?', 'Spouse : divorce', 'Artist : imitation', 'Counselor : advice', 'Restaurant : customer', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(296, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? Heart : human ?', 'Wall : brick', 'Hand : child', 'Kitchen : house', 'Engine : car', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(297, 'Sky is to bird as water is to ?', 'Feather', 'Fish', 'Boat', 'Lotus', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(298, ' Good is to bad as white is to ?', 'Dark', 'Black', 'Grey', 'Ebony', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(299, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? Break : Repair : Wound ?', 'Heal', 'Hurt', 'Fix', 'Plaster', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(300, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? Frightened : Scream as Angry : ?', 'Cry', 'Shiver', 'Shout', 'Sneer', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(301, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? DELAY : EXPEDITE ?', 'Related : halt', 'Block : obstruct', 'Drag : procrastinate', 'Detain : dispatch', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(302, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? VACCINE : PREVENT ?', 'Wound : heal', 'Victim : attend', 'Antidote : counteract', 'Diagnosis : cure', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(303, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? Painter : brush ?', 'Sculptor : chisel', 'Musician : instrument', 'Dancer : stage', 'Seamstress : scissors', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(304, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? FIRE : ASHES ?', 'Accident : delay', 'Water : waves', 'Event : memories', 'Wood : splinters', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(305, 'নিচের উপমাটি পূর্ণকারী শব্দ কোনটি? ঘড়ি : কাঁটা : থার্মোমিটার ?', 'ফারেনহাইট', 'তাপমাত্রা', 'চিকিৎসা', 'পারদ', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(306, ' যদি ICE : COLDNESS হয়, তবে EARTH : ?', 'Weight', 'Jungle', 'Sea', 'Gravity', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(307, 'Drive is to Licence as Breathe is to ?', 'Oxygen', 'Atmosphere', 'Windpipe', 'Inhale', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(308, ' স্টেপলারের সাথে যেমন স্টেপল, সুচের সাথে তেমন ?', 'ছিদ্র', 'কাপড়', 'সুতা', 'সেলাই মেশিন', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(309, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: ACCOUNTANT: ACCURATE', 'Judge: Incorruptible', 'Journal: Ledger', 'Books: Accounts', 'Verse: Poem', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(310, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: TREE: ROOTS', 'Building: Foundation', 'Shirt: Sleeve', 'Entrance: Exit', 'Smoke: Chimney', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(311, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: HOT: WARM', 'Frozen: Cold', 'Silly: Sad', 'Upsetting: Funny', 'Black: Grey', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(312, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: ENVELOP: SURROUND', 'Efface: Confront', 'House: Dislodge', 'Loiter: Linger', 'Distend: Struggle', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(313, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: APPRENTICE: MASTER', 'Slave: Owner', 'Employee: Employer', 'Novice: Initiate', 'Pupil: Teacher', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(314, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: PAIN: SEDATIVE', 'Comfort: Stimulant', 'Grief: Consolation', 'Trance: Narcotic', 'Ache: Extraction', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(315, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: AFTER: BEFORE', 'First: Second', 'Contemporary: Sudden', 'Present: Past', 'Successor: Predecessor', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(316, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: LIGHT: BLIND', 'Speech: Dumb', 'Tongue: Sound', 'Language: Deaf', 'Voice: Vibration', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(317, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: DISTANCE: MILE', 'Liquid: Litre', 'Bushel: Corn', 'Weight: Scale', 'Fame: Television', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(318, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: ARMY: LOGISTICS', 'Business: Strategy', 'War: Logic', 'Soldier: Student', 'Team: Individual', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(319, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Dark: Light:: Cold:', 'Sunshine', 'Heat', 'Hot', 'Bright', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(320, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Cyclone is related to Anticyclone in the same way as Flood is related to', 'Drought', 'Devastation', 'Havoc', 'River', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(321, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Root: Stem:: Branch:', 'Fertiliser', 'Wood', 'Leaf', 'Tree', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(322, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Editor: Newspaper:', 'Lecturer: University', 'Teacher: School', 'Nurse: Hospital', 'Architect: Design', NULL, NULL, '4', 10, 'yes', 'exam', 'final');
INSERT INTO `mcq_questions` (`question_id`, `question`, `option1`, `option2`, `option3`, `option4`, `option5`, `option6`, `correct_option`, `time_in_seconds`, `show_question`, `type`, `exam_type`) VALUES
(323, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Army: Logistics::', 'War: Logic', 'Team: Individual', 'Soldier: Student', 'Business: Strategy', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(324, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Doctor: Disease::', 'Psychiatrist: Maladjustment', 'Teacher: Pupils', 'Scholar: Knowledge', 'Judge: Crime', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(325, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Cloud : Storm:', 'Container: Contained', 'Portent: disaster', 'Cumulus: Gale', 'Thunder: Lightning', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(326, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Promise : Fulfill: @', 'Pawn: Redeem', 'Pledge: Deny', 'Law: Enforce', 'Confession: Hedge', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(327, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Cloud: Storm:', 'Container: Contained', 'Portent: Disaster', 'Cumulus: Gale', 'Thunder: Lightning', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(328, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Sail: Ship', 'Propeller: Aeroplane', 'Radar: Satellite', 'Hydrogen: Balloon', 'Accelarator: Car', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(329, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Food: Gourmet', 'Book: Critic', 'Ant: Connoisseur', 'Sports: Fan', 'Craft: Skill', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(330, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Divide: Unite', 'Split: Apart', 'Marriage: Divorce', 'Fission: Fusion', 'Chasm: Gap', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(331, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Month: March', 'Play: Shakespeare', 'Cinema: Name', 'Novel: Title', 'City: Tokyo', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(332, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Bench: Stool', 'Room: Veranda', 'Cup: Saucer', 'Yardstick: Foot Rule', 'Table Cupboard', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(333, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Money: Misappropriation', 'Writing: Plagiarism', 'Gold: Theft', 'Confidence: Deception', 'Germ: Diseases', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(334, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Tooth: Gum', 'Chest: Ribs', 'Bone: Joint', 'Heart : Aorta', 'Eye: Socket', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(335, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Diamond: Necklace', 'Cars: Roads', 'Flowers: Bouquet', 'Gold: Bangle', 'Books: Shop', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(336, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Shard: Glass', 'Grain: Sand', 'Morsel: Meal', 'Strand: Rope', 'Scrap: Quilt', 'Splinter: Wood', NULL, '5', 10, 'yes', 'exam', 'final'),
(337, 'Choose the pair that best expresses the relationship similar to the one expressed by the pair in the capital letters: Bouquet: Flower', 'Humidor: Tobacco', 'Mosaic: Tile', 'Tapestry: Color', 'Pile: Block', 'Sacristy: Vestment', NULL, '4', 10, 'yes', 'exam', 'final'),
(338, 'অভাব: অপচয়:', 'যোগান', 'সংগ্রহ', 'সঞ্চয়', 'ঋণ', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(339, 'মনীষা বুদ্ধি:: বিদ্যুৎ ?', 'অনুভব', 'আলো', 'প্রতিভা', 'গতি', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(340, 'ব্যর্থতা: হতাশা:: সাফল্য ?', 'অভিলাষ', 'অগ্রগতি', 'উৎসাহ', 'আনন্দ', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(341, 'প্রাসাদ: মানব:: নীড় ?', 'বিহগ', 'নেকড়ে', 'বাসা', 'গুহা', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(342, 'শৈবাল সাগর:: তৃণ', 'জঙ্গল', 'মাঠ', 'বন', 'তীর', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(343, 'শত্রু: মিত্র:: জিঘাংসা: ?', 'ঈর্ষা', 'তুষ্টি', 'অনুরাগ', 'উপচিকীর্ষা', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(344, 'নিক্বন: বীণা: কল্লোল ?', 'সুর', 'হৈ চৈ', 'বারি', 'কলতান', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(345, 'পৃথিবী সূর্য: চাঁদ: ?', 'আকাশ', 'পৃথিবী', 'গৃহ', 'নক্ষত্র', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(346, 'ক: চ: ত:?', 'দ', 'প', 'ট', 'ষ', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(347, 'মহামারী: মৃত্যু: প্রলয়: ?', 'কম্পন', 'আলোড়ন', 'নিদান', 'ধ্বংস', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(348, 'সেকেন্ড: দিন:: সপ্তাহ:? ', 'পক্ষ', 'মাস', 'বছর', 'যুগ', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(349, 'ঝড় কম্পন বিপ্লব : ?', 'উত্থান', 'পতন', 'পরিবর্তন', 'ধ্বংস', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(350, 'চৈত্র বৈশাখ :: হেমন্ত : ?', 'বর্ষা', 'গ্রীষ্ম', 'শীত', 'শরৎ', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(351, 'খ্যাতি: কীর্তি:: মহত্ত্ব: ?', 'সরলতা', 'কর্তব্যনিষ্ঠা', 'দায়িত্বশীলতা', 'বদান্যতা', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(352, 'ভৃত্য: ভূতক:: মালিক: ?', 'অংশ', 'বিনিয়োগ', 'আয়', 'ক্ষতি', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(353, 'Book: Chapter:: Building: ?', 'Frame', 'Storey', 'Roof', 'Construction', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(354, 'Child: Patient:: Nurture: ?', 'Nourish', 'Medicine', 'Doctor', 'Care', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(355, 'Building: Inauguration:: Ship: ?', 'Charter', 'Harbour', 'Commission', 'Captain', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(356, 'Portion : Separate :: Part: ?', 'Whole', 'Integrate', 'Classification', 'Isolate', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(357, 'Repeat: Continue:: Again: ?', 'Reiterate', 'More', 'Less', 'Often', NULL, NULL, '1', 10, 'yes', 'exam', 'final'),
(358, 'Retreat: Withdraw:: Fail: ?', 'Baffle', 'Foil', 'Conquer', 'Miss', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(359, 'Wood-cutter : Timber merchant:: Farmer: ?', 'Labour', 'Green grocer', 'Field', 'Landlord', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(360, 'Past: Future:: Previous: ?', 'Present', 'Next', 'Indefinite', 'Other', NULL, NULL, '2', 10, 'yes', 'exam', 'final'),
(361, 'Small: Mini:: Large: ? ', 'Tall', 'Lengthy', 'Wide', 'Jumbo', NULL, NULL, '4', 10, 'yes', 'exam', 'final'),
(362, 'Criminal: Offence:: Judge: ?', 'Execution', 'Vigilance', 'Judgement', 'Lynching', NULL, NULL, '3', 10, 'yes', 'exam', 'final'),
(363, 'Entrance: Ticket::Job: ?', 'interview', 'Degree', 'Experience', 'Bio-data', 'Appointment Letter', NULL, '5', 10, 'yes', 'exam', 'final'),
(364, 'Police: Crime:: Doctor: ?', 'Death', 'Illness', 'Pain', 'Virus', 'Quarantine', NULL, '2', 10, 'yes', 'exam', 'final'),
(365, 'Seed: Fruit:: Pearl: ?', 'Necklace', 'Snail', 'Shell', 'Casket', 'Jewellery Shop', NULL, '5', 10, 'yes', 'exam', 'final'),
(366, 'Class: Class representative:: Country: ?', 'Head of the State', 'Spokesman', 'Member of Parliament', 'Mayor', 'Ambassador', NULL, '2', 10, 'yes', 'exam', 'final'),
(367, 'Curriculum: Class:: Agenda: ?', 'Speech', 'Meeting', 'Lecture', 'Debate', 'Conversation', NULL, '2', 10, 'yes', 'exam', 'final'),
(368, 'aby: Mother:: Symphony: ?', 'Singer', 'Composer', 'Rhythm', 'Melody', 'Song', NULL, '5', 10, 'yes', 'exam', 'final'),
(369, 'Smoke: Pollution:: War: ?', 'Sorrow', 'Frustration', 'Dread', 'Poverty', 'Destruction', NULL, '1', 10, 'yes', 'exam', 'final'),
(370, 'আদালত: বিচারক:: মন্ত্রণালয়: ?', 'মন্ত্রী', 'প্রশাসক', 'উপ-সচিব', 'সচিব', 'মহাপরিচালক', NULL, '1', 10, 'yes', 'exam', 'final'),
(371, 'ইচ্ছা আশা অনুমান ?', 'কল্পনা', 'প্রত্যাশা', 'পরিকল্পনা', 'বাসনা', 'বিবেচনা', NULL, '2', 10, 'yes', 'exam', 'final'),
(372, 'গুড়: চিনি: চা:?', 'দুধ', 'কফি', 'সরবত', 'বিস্কুট', 'কাপ', NULL, '1', 10, 'yes', 'exam', 'final'),
(373, 'খরচ: নিঃশেষ :: আয়: ?', 'বৃদ্ধি', 'উপার্জন', 'উৎপাদন', 'যোগান', 'উন্নয়ন', NULL, '4', 10, 'yes', 'exam', 'final'),
(374, 'অভিপ্রায়: ভবিষ্যৎ:: হতাশা ?', 'পুরাতন', 'নতুন', 'অতীত', 'বর্তমান', 'প্রাচীন', NULL, '1', 10, 'yes', 'exam', 'final'),
(375, 'টেলিফোন আলাপ:: বেতার ?', 'বার্তা', 'রেডিও', 'ভূ-উপগ্রহ', 'ভাষা', 'যন্ত্র', NULL, '3', 10, 'yes', 'exam', 'final');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bpid` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(256) NOT NULL,
  `name_bn` varchar(100) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `designation_bn` varchar(200) DEFAULT NULL,
  `post` varchar(20) DEFAULT NULL,
  `posting_area` varchar(255) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `joining_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `bpid`, `name`, `password`, `name_bn`, `designation`, `designation_bn`, `post`, `posting_area`, `mobile`, `dob`, `joining_date`) VALUES
(1, '1234', 'test', '1234', 'test', 'test', 'test', 'test', 'test', '01405201771', '2024-01-03', '2024-01-20');

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `bpid` varchar(20) NOT NULL,
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `total_marks` float NOT NULL,
  `obtained_marks` float NOT NULL,
  `status` enum('passed','failed') NOT NULL,
  `exam_config_id` bigint(20) UNSIGNED NOT NULL,
  `id` bigint(20) NOT NULL,
  `exam_schedule_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`bpid`, `exam_id`, `total_marks`, `obtained_marks`, `status`, `exam_config_id`, `id`, `exam_schedule_id`) VALUES
('1234', 1, 10, 1, 'failed', 1, 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@course.bpwn.org.bd', NULL, '$2y$12$ZQm4BJ1577j1Wq2bNzjzZOtwmn8QbiOj8JYTco4vH3rx5HsIwc0hO', 'Admin', NULL, '2024-01-17 13:41:42', '2024-01-17 13:41:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`exam_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `exam_configuration`
--
ALTER TABLE `exam_configuration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `exam_schedule`
--
ALTER TABLE `exam_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bpid` (`bpid`),
  ADD KEY `exam_config_id` (`exam_config_id`);

--
-- Indexes for table `mcq_questions`
--
ALTER TABLE `mcq_questions`
  ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bpid` (`bpid`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bpid` (`bpid`),
  ADD KEY `exam_id` (`exam_id`),
  ADD KEY `exam_config_id` (`exam_config_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `exam_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `exam_configuration`
--
ALTER TABLE `exam_configuration`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `exam_schedule`
--
ALTER TABLE `exam_schedule`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mcq_questions`
--
ALTER TABLE `mcq_questions`
  MODIFY `question_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=376;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exams`
--
ALTER TABLE `exams`
  ADD CONSTRAINT `exams_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `exam_configuration`
--
ALTER TABLE `exam_configuration`
  ADD CONSTRAINT `exam_configuration_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`) ON DELETE CASCADE;

--
-- Constraints for table `exam_schedule`
--
ALTER TABLE `exam_schedule`
  ADD CONSTRAINT `exam_schedule_ibfk_1` FOREIGN KEY (`bpid`) REFERENCES `members` (`bpid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `exam_schedule_ibfk_2` FOREIGN KEY (`exam_config_id`) REFERENCES `exam_configuration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `results_ibfk_1` FOREIGN KEY (`bpid`) REFERENCES `members` (`bpid`) ON DELETE CASCADE,
  ADD CONSTRAINT `results_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `results_ibfk_3` FOREIGN KEY (`exam_config_id`) REFERENCES `exam_configuration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
