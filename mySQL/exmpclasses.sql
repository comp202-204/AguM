-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 26 May 2024, 18:29:41
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.2.12

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
-- Tablo için tablo yapısı `exmpclasses`
--

CREATE TABLE `exmpclasses` (
  `building_id` int(10) NOT NULL,
  `class_id` int(50) NOT NULL,
  `class_name` varchar(64) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `exmpclasses`
--

INSERT INTO `exmpclasses` (`building_id`, `class_id`, `class_name`, `date`, `time`) VALUES
(1, 1, 'LB207', '2024-05-03', '12:00:00'),
(1, 2, 'LB209', '2024-05-03', '12:00:00'),
(1, 3, 'LB210', '2024-05-03', '12:00:00'),
(1, 4, 'LB212', '2024-05-03', '12:00:00'),
(2, 5, 'FOD9', '2024-05-05', '14:00:00'),
(2, 6, 'FOC35', '2024-05-05', '14:10:54'),
(3, 7, 'B230', '2024-05-05', '14:00:00'),
(3, 8, 'B234', '2024-05-05', '14:00:00'),
(4, 9, 'BA018', '2024-05-05', '14:00:00'),
(4, 10, 'BA014', '2024-05-05', '14:00:00'),
(4, 11, 'BA007', '2024-05-05', '14:00:00');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `exmpclasses`
--
ALTER TABLE `exmpclasses`
  ADD PRIMARY KEY (`class_id`) USING BTREE,
  ADD KEY `building_id` (`building_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `exmpclasses`
--
ALTER TABLE `exmpclasses`
  MODIFY `class_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `exmpclasses`
--
ALTER TABLE `exmpclasses`
  ADD CONSTRAINT `exmpclasses_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
