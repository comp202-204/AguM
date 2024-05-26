<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "localconnect";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$date = $_GET['date'];
$start_time = $_GET['start_time'];
$end_time = $_GET['end_time'];

$sql = "SELECT class_name FROM reservation
        WHERE date = ? AND class_status = 'Available'
        AND (
            (start_time <= ? AND end_time > ?) OR
            (start_time < ? AND end_time >= ?) OR
            (start_time >= ? AND end_time <= ?)
        )";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sssssss", $date, $start_time, $start_time, $end_time, $end_time, $start_time, $end_time);
$stmt->execute();
$result = $stmt->get_result();

$classes = [];
while ($row = $result->fetch_assoc()) {
    $classes[] = $row['class_name'];
}

echo json_encode($classes);

$stmt->close();
$conn->close();
?>

