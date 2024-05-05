<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";

$classId = $_GET['classId'];  // Get class ID from query parameters

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT class_name FROM exmpclasses WHERE class_id = $classId";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode(['class_name' => $row['class_name']]);
} else {
    echo json_encode(['class_name' => null]);
}

$conn->close();
?>
