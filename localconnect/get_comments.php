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

// Retrieve comments from the database
$sql = "SELECT * FROM comments ORDER BY date DESC"; // Assuming 'comments' is the name of your table
$result = $conn->query($sql);

// Check if there are any comments
if ($result->num_rows > 0) {
    // Output data of each row (comment)
    $comments = array();
    while ($row = $result->fetch_assoc()) {
        $comment = array(
            'text' => $row['text'],
            'date' => $row['date']
        );
        $comments[] = $comment;
    }
    // Convert the comments array to JSON format and output it
    echo json_encode($comments);
} else {
    echo "No comments yet";
}

// Close the database connection
$conn->close();
?>

