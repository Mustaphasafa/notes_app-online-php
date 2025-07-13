<?php

include "../connect.php";


$noteid = requestFilter("noteid");
$title = requestFilter("title");
$content = requestFilter("content");
$imagename = requestFilter("imagename");

if(isset($_FILES['file'])){
deleteImage("../upload",$imagename);
$imagename = uploadImage("file");
}

$stmt = $con->prepare("
UPDATE `notes` SET notes_title = ?,notes_content=?,notes_image=? WHERE notes_id = ?
");
$stmt->execute(array($title,$content,$imagename,$noteid));




$count = $stmt->rowCount();

if ($count > 0) {
   
    echo json_encode(array("status" => "succes",),);
} else {
    echo json_encode(array("status" => "fail"));
}
?>