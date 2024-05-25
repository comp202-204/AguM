-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost
-- Üretim Zamanı: 25 May 2024, 13:02:38
-- Sunucu sürümü: 10.4.28-MariaDB
-- PHP Sürümü: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `localconnect`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `reservation`
--

CREATE TABLE `reservation` (
  `id` int(11) NOT NULL,
  `building_id` int(10) NOT NULL,
  `classes_id` int(60) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `class_name` varchar(50) NOT NULL,
  `class_status` enum('NotAvailable','Available') NOT NULL DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `reservation`
--

INSERT INTO `reservation` (`id`, `building_id`, `classes_id`, `date`, `time`, `class_name`, `class_status`) VALUES
(1, 1, 1, '2024-05-12', '12:00:00', 'LB207', 'NotAvailable'),
(2, 1, 1, '2024-05-12', '13:00:00', 'LB207', 'Available'),
(3, 1, 1, '2024-05-12', '14:00:00', 'LB207', 'Available'),
(4, 1, 2, '2024-05-12', '13:00:00', 'LB209', 'Available'),
(5, 1, 2, '2024-05-12', '14:00:00', 'LB209', 'Available'),
(6, 1, 2, '2024-05-12', '15:00:00', 'LB209', 'Available'),
(7, 1, 3, '2024-05-12', '12:00:00', 'LB210', 'Available'),
(8, 1, 3, '2024-05-12', '13:00:00', 'LB210', 'Available'),
(9, 1, 3, '2024-05-12', '15:00:00', 'LB210', 'Available');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aaa` (`building_id`),
  ADD KEY `classes_id` (`classes_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`classes_id`) REFERENCES `exmpclasses` (`class_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
