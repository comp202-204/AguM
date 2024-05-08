<?php
// Veritabanı bağlantısı
$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect"; // Veritabanı adı

// Bağlantı oluşturma
$conn = new mysqli($servername, $username, $password, $database);

// Bağlantıyı kontrol etme
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Gelen veriyi al
$data = json_decode(file_get_contents('php://input'), true);
$className = $data['class_name'];
$classStatus = $data['class_status'];
$date = $data['date']; // Seçilen tarih
$time = $data['time']; // Seçilen saat

// Sorgu hazırlama
$sql = "UPDATE reservation SET `class_status` = '$classStatus' WHERE `class_name` = '$className' AND `date` = '$date' AND `time` = '$time'";
if ($conn->query($sql) === TRUE) {
    echo "Class status updated successfully";
} else {
    echo "Error updating class status: " . $conn->error;
}
$conn->close();
?>

