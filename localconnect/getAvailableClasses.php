<?php

// Database configuration settings
$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";

// Create a new MySQLi connection
$conn = new mysqli($servername, $username, $password, $database);

// Check the connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['error' => "Connection failed: " . $conn->connect_error]);
    exit();  // Terminate the script if the database connection fails
}

// Retrieve `date` and `time` from the GET request
$date = isset($_GET['date']) ? $_GET['date'] : null;
$time = isset($_GET['time']) ? $_GET['time'] : null;

$response = [];

// Validate that both date and time have been provided
if ($date && $time) {
    // Prepare SQL statement to prevent SQL injection
    $stmt = $conn->prepare("SELECT id, building_id, classes_id, class_name FROM reservation WHERE date = ? AND time = ?");
    $stmt->bind_param("ss", $date, $time);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Fetch all matching records and populate the response array
        while ($row = $result->fetch_assoc()) {
            $response[] = [
                'id' => $row['id'],
                'building_id' => $row['building_id'],
                'classes_id' => $row['classes_id'],
                'class_name' => $row['class_name']
            ];
        }
    } else {
        // Set HTTP response code to 404 if no entries are found
        http_response_code(404);
        $response = ['message' => 'No classes available'];
    }

    $stmt->close();
} else {
    // Set HTTP response code to 400 for bad request
    http_response_code(400);
    $response = ['error' => 'Both date and time are required'];
}

$conn->close();

echo json_encode($response);
?>
