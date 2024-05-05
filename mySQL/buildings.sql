-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 05 May 2024, 14:07:48
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
-- Tablo için tablo yapısı `buildings`
--

CREATE TABLE `buildings` (
  `building_id` int(20) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `imageURL` varchar(300) NOT NULL,
  `TYPE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `buildings`
--

INSERT INTO `buildings` (`building_id`, `NAME`, `imageURL`, `TYPE`) VALUES
(1, 'Laboratory', 'http://www.agu.edu.tr/userfiles//lab1.jpeg', 'Lab'),
(2, 'Factory', 'https://mapio.net/images-p/121494873.jpg', 'Factory'),
(3, 'Steel Building', 'https://tr.mefagroup.com/wp-content/uploads/2014/01/01.jpg', ' Steel Building'),
(4, 'Warehouse', 'https://www.arkitera.com/wp-content/uploads/2017/01/AGÜ-Sümer-Kampüsü-Büyük-Ambar-Binası-Restorasyon-Projesi-18.jpg', 'Warehouse');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`building_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `buildings`
--
ALTER TABLE `buildings`
  MODIFY `building_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
