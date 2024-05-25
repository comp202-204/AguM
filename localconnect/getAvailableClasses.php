<?php
// Veritabanı bağlantı bilgileri
$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";

// Veritabanı bağlantısını oluştur
$conn = new mysqli($servername, $username, $password, $database);

// Bağlantıyı kontrol et
if ($conn->connect_error) {
    die("Veritabanı bağlantısı başarısız: " . $conn->connect_error);
}

// GET isteğinden gelen parametreleri al
$date = $_GET['date'];
$start_time = $_GET['start_time'];
$end_time = $_GET['end_time'];

// Sorguyu hazırla
$sql = "SELECT `date`, `start_time`, `end_time`, `class_name` FROM `reservation` WHERE `date` = ? AND `start_time` >= ? AND `end_time` <= ? AND `class_status` = 'Available'";

// Hazırlanan ifadeyi başlat
$stmt = $conn->prepare($sql);

// Parametreleri bağla
$stmt->bind_param("sss", $date, $start_time, $end_time);

// Sorguyu çalıştır
$stmt->execute();

// Sonuçları al
$result = $stmt->get_result();

// Sonuçları bir diziye dönüştür
$data = array();
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

// JSON formatına dönüştür ve yazdır
header('Content-Type: application/json');
echo json_encode($data);

// Bağlantıyı kapat
$stmt->close();
$conn->close();
?>
