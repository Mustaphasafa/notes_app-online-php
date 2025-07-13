<?php

include "../connect.php";


$noteid = requestFilter("noteid");
$imagename = requestFilter("file");



$stmt = $con->prepare("
DELETE from notes WHERE `notes_id`= ?");
$stmt->execute(array($noteid,));




$count = $stmt->rowCount();

if ($count > 0) {
   deleteImage("../upload",$imagename);
    echo json_encode(array("status" => "succes",),);
} else {
    echo json_encode(array("status" => "fail"));
}
?>