<?php

$servername = "localhost";
$email = "root";
$password = "";
$database = "localconnect";


// Create connection
$conn = new mysqli($servername,$email,$password, $database);

// Check connection
if (!$conn) {
    echo "Database Conn Failed";
}

$email = $_POST['email'];// it will come from flutter
$password = $_POST['password'];// it will come from flutter


$sql = "SELECT * FROM users WHERE email = '".$email."' and password = '".$password."' ";

$result = mysqli_query($conn, $sql);
$count =  mysqli_num_rows($result);

// Verify password
if ($count >= 1) {
    echo json_encode("success");
} else {
    echo json_encode("Please enter correct values or register");
}
?>

