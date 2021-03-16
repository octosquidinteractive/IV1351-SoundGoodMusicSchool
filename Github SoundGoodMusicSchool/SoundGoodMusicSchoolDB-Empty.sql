-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 16, 2021 at 04:30 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `SoundGoodMusicSchoolDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrative_staff`
--

CREATE TABLE `administrative_staff` (
  `administrative_staff_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `application`
--

CREATE TABLE `application` (
  `application_id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `level_of_skill` int(11) DEFAULT NULL,
  `administrative_staff_id` int(11) NOT NULL,
  `person_number` varchar(12) NOT NULL,
  `instrument_type` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `audition`
--

CREATE TABLE `audition` (
  `audition_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `level_of_skill` int(11) DEFAULT NULL,
  `administrative_staff_id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `bill_id` int(11) NOT NULL,
  `sum` int(11) DEFAULT NULL,
  `student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE `email` (
  `email_address` varchar(250) NOT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ensemble`
--

CREATE TABLE `ensemble` (
  `ensemble_id` int(11) NOT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `time_slot` datetime(6) DEFAULT NULL,
  `attendees` int(11) DEFAULT NULL,
  `minimum_attendees` int(11) DEFAULT NULL,
  `maximum_attendees` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `lesson_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `group_lesson`
--

CREATE TABLE `group_lesson` (
  `group_lesson_id` int(11) NOT NULL,
  `time_slot` datetime(6) NOT NULL,
  `attendees` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `lesson_id` int(11) NOT NULL,
  `instrument_type` varchar(250) DEFAULT NULL,
  `minimum_attendees` int(11) DEFAULT NULL,
  `maximum_attendees` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `individual_lesson`
--

CREATE TABLE `individual_lesson` (
  `individual_lesson_id` int(11) NOT NULL,
  `time_slot` datetime(6) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `lesson_id` int(11) NOT NULL,
  `instrument_type` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `instructor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `instructor_pay`
--

CREATE TABLE `instructor_pay` (
  `instructor_pay_id` int(11) NOT NULL,
  `sum` int(11) DEFAULT NULL,
  `instructor_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `instrument`
--

CREATE TABLE `instrument` (
  `instrument_id` int(11) NOT NULL,
  `instrument_type` varchar(250) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `instrument_rent`
--

CREATE TABLE `instrument_rent` (
  `instrument_id` int(11) NOT NULL,
  `amount_in_stock` int(11) DEFAULT NULL,
  `brand` varchar(250) DEFAULT NULL,
  `model` varchar(250) DEFAULT NULL,
  `instrument_type` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `lesson`
--

CREATE TABLE `lesson` (
  `lesson_id` int(11) NOT NULL,
  `level_of_skill` int(11) DEFAULT NULL,
  `instructor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `lesson_student`
--

CREATE TABLE `lesson_student` (
  `student_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `parent`
--

CREATE TABLE `parent` (
  `parent_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `personal_info`
--

CREATE TABLE `personal_info` (
  `person_number` varchar(12) NOT NULL,
  `name` varchar(250) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `phone_number`
--

CREATE TABLE `phone_number` (
  `phone_no` char(10) NOT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rental`
--

CREATE TABLE `rental` (
  `rental_id` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `delivery_address` varchar(50) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `duration` datetime(6) DEFAULT NULL,
  `instrument_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `returned` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `accepted` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student_fee`
--

CREATE TABLE `student_fee` (
  `student_fee_id` int(11) NOT NULL,
  `sum` int(11) NOT NULL,
  `bill_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student_parent`
--

CREATE TABLE `student_parent` (
  `student_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrative_staff`
--
ALTER TABLE `administrative_staff`
  ADD PRIMARY KEY (`administrative_staff_id`);

--
-- Indexes for table `application`
--
ALTER TABLE `application`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `FK_application_0` (`administrative_staff_id`),
  ADD KEY `FK_application_1` (`person_number`);

--
-- Indexes for table `audition`
--
ALTER TABLE `audition`
  ADD PRIMARY KEY (`audition_id`),
  ADD KEY `FK_audition_0` (`administrative_staff_id`),
  ADD KEY `FK_audition_1` (`application_id`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`bill_id`),
  ADD KEY `FK_bill_0` (`student_id`);

--
-- Indexes for table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`email_address`),
  ADD KEY `FK_email_0` (`instructor_id`),
  ADD KEY `FK_email_1` (`student_id`),
  ADD KEY `FK_email_2` (`parent_id`);

--
-- Indexes for table `ensemble`
--
ALTER TABLE `ensemble`
  ADD PRIMARY KEY (`ensemble_id`),
  ADD KEY `FK_ensemble_0` (`lesson_id`);

--
-- Indexes for table `group_lesson`
--
ALTER TABLE `group_lesson`
  ADD PRIMARY KEY (`group_lesson_id`),
  ADD KEY `FK_group_lesson_0` (`lesson_id`);

--
-- Indexes for table `individual_lesson`
--
ALTER TABLE `individual_lesson`
  ADD PRIMARY KEY (`individual_lesson_id`),
  ADD KEY `FK_individual_lesson_0` (`lesson_id`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `instructor_pay`
--
ALTER TABLE `instructor_pay`
  ADD PRIMARY KEY (`instructor_pay_id`),
  ADD KEY `FK_instructor_pay_0` (`instructor_id`),
  ADD KEY `FK_instructor_pay_1` (`lesson_id`);

--
-- Indexes for table `instrument`
--
ALTER TABLE `instrument`
  ADD PRIMARY KEY (`instrument_id`),
  ADD KEY `FK_instrument_0` (`instructor_id`),
  ADD KEY `FK_instrument_1` (`student_id`);

--
-- Indexes for table `instrument_rent`
--
ALTER TABLE `instrument_rent`
  ADD PRIMARY KEY (`instrument_id`);

--
-- Indexes for table `lesson`
--
ALTER TABLE `lesson`
  ADD PRIMARY KEY (`lesson_id`),
  ADD KEY `FK_lesson_0` (`instructor_id`);

--
-- Indexes for table `lesson_student`
--
ALTER TABLE `lesson_student`
  ADD PRIMARY KEY (`student_id`,`lesson_id`),
  ADD KEY `FK_lesson_student_1` (`lesson_id`);

--
-- Indexes for table `parent`
--
ALTER TABLE `parent`
  ADD PRIMARY KEY (`parent_id`);

--
-- Indexes for table `personal_info`
--
ALTER TABLE `personal_info`
  ADD PRIMARY KEY (`person_number`),
  ADD KEY `FK_personal_info_0` (`instructor_id`),
  ADD KEY `FK_personal_info_1` (`student_id`),
  ADD KEY `FK_personal_info_2` (`parent_id`);

--
-- Indexes for table `phone_number`
--
ALTER TABLE `phone_number`
  ADD PRIMARY KEY (`phone_no`),
  ADD KEY `FK_phone_number_0` (`instructor_id`),
  ADD KEY `FK_phone_number_1` (`student_id`),
  ADD KEY `FK_phone_number_2` (`parent_id`);

--
-- Indexes for table `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`rental_id`),
  ADD KEY `FK_rental_0` (`instrument_id`),
  ADD KEY `FK_rental_1` (`student_id`),
  ADD KEY `FK_rental_2` (`bill_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_fee`
--
ALTER TABLE `student_fee`
  ADD PRIMARY KEY (`student_fee_id`),
  ADD KEY `FK_student_fee_0` (`bill_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrative_staff`
--
ALTER TABLE `administrative_staff`
  MODIFY `administrative_staff_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `application`
--
ALTER TABLE `application`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audition`
--
ALTER TABLE `audition`
  MODIFY `audition_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ensemble`
--
ALTER TABLE `ensemble`
  MODIFY `ensemble_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `group_lesson`
--
ALTER TABLE `group_lesson`
  MODIFY `group_lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `individual_lesson`
--
ALTER TABLE `individual_lesson`
  MODIFY `individual_lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `instructor`
--
ALTER TABLE `instructor`
  MODIFY `instructor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `instructor_pay`
--
ALTER TABLE `instructor_pay`
  MODIFY `instructor_pay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `instrument`
--
ALTER TABLE `instrument`
  MODIFY `instrument_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `instrument_rent`
--
ALTER TABLE `instrument_rent`
  MODIFY `instrument_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `lesson`
--
ALTER TABLE `lesson`
  MODIFY `lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `rental`
--
ALTER TABLE `rental`
  MODIFY `rental_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `student_fee`
--
ALTER TABLE `student_fee`
  MODIFY `student_fee_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `application`
--
ALTER TABLE `application`
  ADD CONSTRAINT `FK_application_0` FOREIGN KEY (`administrative_staff_id`) REFERENCES `administrative_staff` (`administrative_staff_id`),
  ADD CONSTRAINT `FK_application_1` FOREIGN KEY (`person_number`) REFERENCES `personal_info` (`person_number`) ON DELETE CASCADE;

--
-- Constraints for table `audition`
--
ALTER TABLE `audition`
  ADD CONSTRAINT `FK_audition_0` FOREIGN KEY (`administrative_staff_id`) REFERENCES `administrative_staff` (`administrative_staff_id`),
  ADD CONSTRAINT `FK_audition_1` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`) ON DELETE CASCADE;

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `FK_bill_0` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);

--
-- Constraints for table `email`
--
ALTER TABLE `email`
  ADD CONSTRAINT `FK_email_0` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_email_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_email_2` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`) ON DELETE CASCADE;

--
-- Constraints for table `ensemble`
--
ALTER TABLE `ensemble`
  ADD CONSTRAINT `FK_ensemble_0` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`lesson_id`) ON DELETE CASCADE;

--
-- Constraints for table `group_lesson`
--
ALTER TABLE `group_lesson`
  ADD CONSTRAINT `FK_group_lesson_0` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`lesson_id`) ON DELETE CASCADE;

--
-- Constraints for table `individual_lesson`
--
ALTER TABLE `individual_lesson`
  ADD CONSTRAINT `FK_individual_lesson_0` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`lesson_id`) ON DELETE CASCADE;

--
-- Constraints for table `instructor_pay`
--
ALTER TABLE `instructor_pay`
  ADD CONSTRAINT `FK_instructor_pay_0` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`),
  ADD CONSTRAINT `FK_instructor_pay_1` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`lesson_id`);

--
-- Constraints for table `instrument`
--
ALTER TABLE `instrument`
  ADD CONSTRAINT `FK_instrument_0` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_instrument_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `lesson`
--
ALTER TABLE `lesson`
  ADD CONSTRAINT `FK_lesson_0` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE CASCADE;

--
-- Constraints for table `lesson_student`
--
ALTER TABLE `lesson_student`
  ADD CONSTRAINT `FK_lesson_student_0` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_lesson_student_1` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`lesson_id`) ON DELETE CASCADE;

--
-- Constraints for table `personal_info`
--
ALTER TABLE `personal_info`
  ADD CONSTRAINT `FK_personal_info_0` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_personal_info_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_personal_info_2` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`) ON DELETE CASCADE;

--
-- Constraints for table `phone_number`
--
ALTER TABLE `phone_number`
  ADD CONSTRAINT `FK_phone_number_0` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_phone_number_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_phone_number_2` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`) ON DELETE CASCADE;

--
-- Constraints for table `rental`
--
ALTER TABLE `rental`
  ADD CONSTRAINT `FK_rental_0` FOREIGN KEY (`instrument_id`) REFERENCES `instrument_rent` (`instrument_id`),
  ADD CONSTRAINT `FK_rental_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_rental_2` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_fee`
--
ALTER TABLE `student_fee`
  ADD CONSTRAINT `FK_student_fee_0` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
