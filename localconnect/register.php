<?php
$servername = "localhost";
$username = "root";
$email = "";
$password = "";
$database = "localconnect";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if (!$conn) {
    echo "Database Conn Failed";
}

$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];


$sql = "INSERT INTO users (username, email, password)
    SELECT * FROM (SELECT '".$username."' AS username, '".$email."' AS email,'".$password."' as password) AS tmp
    WHERE NOT EXISTS (
        SELECT 1 FROM users WHERE email = '".$email."')";

$query = mysqli_query($conn, $sql);

if($query){
    echo json_encode("Register Successed");
}else {
    echo json_encode("This email already exist");
}

?>