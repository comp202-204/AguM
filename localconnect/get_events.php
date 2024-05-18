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

// SQL query to select all events
$sql = "SELECT event_id, event_name, description, data_time FROM events ORDER BY data_time DESC";
$result = $conn->query($sql);

$events = array();

if ($result->num_rows > 0) {
    // Output data of each row
    while($row = $result->fetch_assoc()) {
        $events[] = $row;
    }
} else {
    echo json_encode(array('message' => 'No events found'));
    exit;
}

echo json_encode($events);

$conn->close();

?>
