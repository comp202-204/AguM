<?php

$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";

// Create database connection
$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $event_name = $_POST['event_name'];
    $description = $_POST['description'];
    $data_time = $_POST['data_time'];

    $stmt = $conn->prepare("INSERT INTO events (event_name, description, data_time) VALUES (?, ?, ?)");
    if (!$stmt) {
        echo json_encode(["success" => false, "message" => "Prepare statement failed: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("sss", $event_name, $description, $data_time);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Event created successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to create event: " . $stmt->error]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method"]);
}
?>
