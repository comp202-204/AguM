<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT b.building_id, b.NAME, b.imageURL, b.TYPE, COUNT(c.class_id) as classCount
        FROM buildings b
        LEFT JOIN exmpclasses c ON b.building_id = c.building_id
        GROUP BY b.building_id";
$result = $conn->query($sql);

$buildings = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Assuming $row['classCount'] comes from a database query
        $classCount = (int) $row['classCount'];  // Cast to integer

        $buildings[] = [
            'name' => $row['NAME'],
            'imageURL' => $row['imageURL'],
            'type' => $row['TYPE'],
            'classCount' => $classCount  // Ensure this is an integer
        ];

    }
    echo json_encode($buildings);
} else {
    echo json_encode([]);
}

$conn->close();
?>
