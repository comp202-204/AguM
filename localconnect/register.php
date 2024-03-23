<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "localconnect";
$email = "";
// Create connection
$conn = new mysqli($servername, $username, $password,$email,$database);

// Check connection
if (!$conn) {
    echo "Database Conn Failed";
}

$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];


$sql = "INSERT INTO users(username,password,email) VALUES('".$username."','".$password."','".$email."')";
$query = mysqli_query($conn, $sql);

if($query){
    echo json_encode("Register Successed");
}

?>