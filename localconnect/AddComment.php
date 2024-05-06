<?php

$buildingId = $_POST['buildingId'];
$classId = $_POST['classId'];
$comment = $_POST['comment'];

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

// SQL ile yorum eklemek
$sql = "INSERT INTO comments (building_id, class_id, comment) VALUES ('$buildingId', '$classId', '$comment')";

if ($conn->query($sql) === TRUE) {
    echo "Comment added successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// Bağlantıyı kapatma
$conn->close();

?>

