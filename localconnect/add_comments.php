<?php
// MySQL database connection parameters
$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";

// Establish MySQL database connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the data sent by the client (Flutter app)
    $data = json_decode(file_get_contents("php://input"), true);
    $comment_text = $data['text'];
    $comment_date = date('Y-m-d H:i:s'); // Get current date and time

    // Insert the new comment into the database
    $sql = "INSERT INTO comments (text, date) VALUES ('$comment_text', '$comment_date')";
    if ($conn->query($sql) === TRUE) {
        echo "New comment added successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
} else {
    echo "Invalid request method";
}

// Close the database connection
$conn->close();
?>

