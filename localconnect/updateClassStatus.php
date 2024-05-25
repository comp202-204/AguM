<?php
// Veritabanı bağlantısı
$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";

// Bağlantı oluştur
$conn = new mysqli($servername, $username, $password, $database);

// Bağlantı kontrolü
if ($conn->connect_error) {
    die("Bağlantı hatası: " . $conn->connect_error);
}

// Gelen verileri al
$data = json_decode(file_get_contents("php://input"), true);

// Alınan veriler
$date = $data['date'];
$start_time = $data['start_time'];
$end_time = $data['end_time'];

try {
    // Sınıfın class_status değerini güncelle
    $sql = "UPDATE reservation SET class_status = 'NotAvailable' WHERE date = '$date' AND time >= '$start_time' AND time < '$end_time'";
    $result = $conn->query($sql);
    if (!$result) {
        throw new Exception("Sorgu hatası: " . $conn->error);
    }

    // Başarılı işlem mesajı gönder
    echo json_encode(array("message" => "Sınıf durumu güncellendi."));
} catch (Exception $e) {
    // Hata mesajı gönder
    echo json_encode(array("error" => $e->getMessage()));
}

// Bağlantıyı kapat
$conn->close();
?>

