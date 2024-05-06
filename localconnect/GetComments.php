<?php

$buildingId = $_GET['buildingId'];
$classId = $_GET['classId'];

// MySQL bağlantısı
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "localconnect";

// Bağlantı oluşturma
$conn = new mysqli($servername, $username, $password, $dbname);

// Bağlantıyı kontrol etme
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL ile yorumları almak
$sql = "SELECT * FROM comments WHERE building_id='$buildingId' AND class_id='$classId'";
$result = $conn->query($sql);

$comments = array();

if ($result->num_rows > 0) {
    // Her bir satırı işleme al
    while ($row = $result->fetch_assoc()) {
        // Commentleri diziye ekle
        $comments[] = array(
            'text' => $row['comment'],
            'timestamp' => $row['created_at']
        );
    }
} else {
    echo "No comments found";
}

// Bağlantıyı kapat
$conn->close();

// JSON olarak commentleri geri dön
header('Content-Type: application/json');
echo json_encode($comments);

?>

