<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "localconnect";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$data = json_decode(file_get_contents("php://input"), true);
$date = $data['date'];
$start_time = $data['start_time'];
$end_time = $data['end_time'];
$classes = $data['classes'];

$sql = "UPDATE reservation SET class_status = 'NotAvailable'
        WHERE date = ? AND class_name = ?
        AND (
            (start_time <= ? AND end_time > ?) OR
            (start_time < ? AND end_time >= ?) OR
            (start_time >= ? AND end_time <= ?)
        )";
$stmt = $conn->prepare($sql);

foreach ($classes as $class_name) {
    $stmt->bind_param("ssssssss", $date, $class_name, $start_time, $start_time, $end_time, $end_time, $start_time, $end_time);
    $stmt->execute();
}

if ($stmt->error) {
    echo json_encode(["status" => "error", "message" => $stmt->error]);
} else {
    echo json_encode(["status" => "success", "message" => "Class status updated successfully"]);
}

$stmt->close();
$conn->close();
?>

