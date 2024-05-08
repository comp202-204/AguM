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

// GET parametrelerini al
$date = $_GET["date"];
$time = $_GET["time"];

// Sorgu hazırlama
$sql = "SELECT class_name FROM reservation WHERE `date` = '$date' AND `time` = '$time' AND `class_status` = 'Available'";
$result = $conn->query($sql);

// Sorgu sonuçlarını işleme
$classes = array();
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $classes[] = $row["class_name"];
    }
    echo json_encode($classes);
} else {
    echo "No available classes";
}
$conn->close();
?>

