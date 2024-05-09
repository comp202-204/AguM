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

// Get request'ten gelen classId parametresini al
$classId = $_GET['classId'];

// Sorguyu hazırla
$sql = "SELECT `date`, `time`, `class_name` FROM `reservation` WHERE `classes_id` = $classId AND `class_status` = 'NotAvailable'";

// Sorguyu çalıştır ve sonuçları al
$result = $conn->query($sql);

// Eğer sorgu başarılıysa
if ($result) {
    // Sonuçları bir dizi olarak depola
    $data = array();

    // Sonuçları diziye dönüştür
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    // Diziyi JSON formatına dönüştür ve yazdır
    echo json_encode($data);
} else {
    // Sorgu başarısız ise hata mesajı yazdır
    echo "Sorgu başarısız: " . $conn->error;
}

// Veritabanı bağlantısını kapat
$conn->close();
?>

