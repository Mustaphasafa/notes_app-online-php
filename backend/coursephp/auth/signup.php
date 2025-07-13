<?php

include "../connect.php";


$username = requestFilter("username");
$email = requestFilter("email");
$password = requestFilter("password");


$stmt = $con->prepare("
INSERT INTO `users`( `username`, `email`, `password`) VALUES (? ,? ,?)");
$stmt->execute(array($username, $email, $password));




$count = $stmt->rowCount();

if ($count > 0) {
    $details = $con->prepare("
SELECT * FROM users WHERE `email` = ?");
    $details->execute(array( $email));
    $data = $details->fetch(PDO::FETCH_ASSOC);
    echo json_encode(array("status" => "succes", "data" => $data),);
} else {
    echo json_encode(array("status" => "fail"));
}
?>