-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 26, 2018 at 04:42 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `invoicing`
--

-- --------------------------------------------------------

--
-- Table structure for table `Customer`
--

CREATE TABLE `Customer` (
  `cid` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Customer`
--

INSERT INTO `Customer` (`cid`, `name`, `address_id`) VALUES
(1, 'Md. Shohag Mia', 1),
(2, 'Sourav Paul Kundu', 2),
(3, 'Najmul Mollah', 3);

-- --------------------------------------------------------

--
-- Table structure for table `CustomerAddress`
--

CREATE TABLE `CustomerAddress` (
  `id` bigint(20) NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CustomerAddress`
--

INSERT INTO `CustomerAddress` (`id`, `city`, `phone`, `state`, `zip`) VALUES
(1, 'Sirajganj', '01744431381', 'Bangladesh', '6710'),
(2, 'Khulna', '01747148019', 'Bangladesh', '6205'),
(3, 'Tangail', '01734044510', 'Bangladesh', '7290');

-- --------------------------------------------------------

--
-- Table structure for table `Invoice`
--

CREATE TABLE `Invoice` (
  `id` bigint(20) NOT NULL,
  `dueAmount` double NOT NULL,
  `dueDate` varchar(255) DEFAULT NULL,
  `invoiceDate` varchar(255) DEFAULT NULL,
  `invoiceNumber` varchar(255) DEFAULT NULL,
  `payment_term` varchar(255) DEFAULT NULL,
  `salesperson` varchar(255) DEFAULT NULL,
  `srcDocument` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `totalBill` double NOT NULL,
  `customer_cid` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Invoice`
--

INSERT INTO `Invoice` (`id`, `dueAmount`, `dueDate`, `invoiceDate`, `invoiceNumber`, `payment_term`, `salesperson`, `srcDocument`, `status`, `totalBill`, `customer_cid`) VALUES
(18, 0, '2018-02-28', '2018-02-28', 'NA', '15 Days', 'Administraor', 'NA', 'Paid', 202, 1),
(17, 0, '2018-02-26', '2018-02-26', 'NA', '30 Net Days', 'Demo Portal User', 'NA', 'Open', 731, 1),
(19, 0, '2018-02-27', '2018-02-27', 'NA', '15 Days', 'Administraor', 'NA', 'Open', 0, 1),
(20, 0, '2018-02-26', '2018-02-26', 'NA', 'End of Following Month', 'Demo Portal User', 'NA', 'Paid', 504, 2),
(21, 0, '2018-05-22', '2018-05-22', 'NA', 'End of Following Month', 'Demo User', 'NA', 'Open', 217.3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Invoice_Product`
--

CREATE TABLE `Invoice_Product` (
  `Invoice_id` bigint(20) NOT NULL,
  `productList_pid` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Invoice_Product`
--

INSERT INTO `Invoice_Product` (`Invoice_id`, `productList_pid`) VALUES
(18, 31),
(17, 25),
(17, 24),
(20, 30),
(21, 32),
(21, 33),
(21, 34);

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `pid` bigint(20) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `total` double NOT NULL,
  `products_psid` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Product`
--

INSERT INTO `Product` (`pid`, `quantity`, `total`, `products_psid`) VALUES
(26, 4, 202, 2),
(25, 2, 101, 2),
(24, 5, 630, 1),
(27, 4, 504, 1),
(28, 1, 50.5, 2),
(29, 4, 504, 1),
(30, 1, 50.5, 2),
(31, 4, 202, 2),
(32, 1, 126, 1),
(33, 1, 50.5, 2),
(34, 1, 40.8, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Products`
--

CREATE TABLE `Products` (
  `psid` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `productname` varchar(255) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `tax` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Products`
--

INSERT INTO `Products` (`psid`, `description`, `price`, `productname`, `quantity`, `tax`) VALUES
(1, 'Healthy', 120, 'Soup', 12, 5),
(2, 'Vegitable', 50, 'Alu', 120, 1),
(3, 'Vegitable', 40, 'Begun', 200, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Customer`
--
ALTER TABLE `Customer`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `FKk8uwcllqiqer695npe5n5t8wa` (`address_id`);

--
-- Indexes for table `CustomerAddress`
--
ALTER TABLE `CustomerAddress`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Invoice`
--
ALTER TABLE `Invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK8yetkgw56lkebcajpp7m45m9s` (`customer_cid`);

--
-- Indexes for table `Invoice_Product`
--
ALTER TABLE `Invoice_Product`
  ADD UNIQUE KEY `UK_hxw48ohabhniuvrnyg2l6dg2y` (`productList_pid`),
  ADD KEY `FKsbbw7oi2k0gyxmllt1v29k3ms` (`Invoice_id`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `FKggnhe1igw3sgjfrlqcmmf3fyu` (`products_psid`);

--
-- Indexes for table `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`psid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Customer`
--
ALTER TABLE `Customer`
  MODIFY `cid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `CustomerAddress`
--
ALTER TABLE `CustomerAddress`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Invoice`
--
ALTER TABLE `Invoice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `Product`
--
ALTER TABLE `Product`
  MODIFY `pid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `Products`
--
ALTER TABLE `Products`
  MODIFY `psid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
