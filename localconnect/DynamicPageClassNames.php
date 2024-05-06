<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";

// Create database connection
$conn = new mysqli($servername, $username, $password, $database);

// Check for connection error
if ($conn->connect_error) {
    die(json_encode(['class_name' => 'Connection failed: ' . $conn->connect_error]));
}

// Get class ID and building ID from query parameters
$buildingId = isset($_GET['buildingId']) ? intval($_GET['buildingId']) : 0;
$classId = isset($_GET['classId']) ? intval($_GET['classId']) : 0;

// Prepare and execute the SQL statement
$sql = "SELECT class_name FROM exmpclasses WHERE building_id = ? AND class_id = ?";
$stmt = $conn->prepare($sql);

if ($stmt) {
    $stmt->bind_param("ii", $buildingId, $classId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        echo json_encode(['class_name' => $row['class_name']]);
    } else {
        echo json_encode(['class_name' => 'No class found']);
    }

    $stmt->close();
} else {
    echo json_encode(['class_name' => 'Error preparing statement: ' . $conn->error]);
}

$conn->close();
?>
