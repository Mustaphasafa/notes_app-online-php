<?php

include "../connect.php";




$id = requestFilter("id");
$title = requestFilter("title");
$content = requestFilter("content");
$imagename = uploadImage('file');


if($imagename != "fail"){

$stmt = $con->prepare("
INSERT INTO `notes` (notes_title,notes_content,notes_user,notes_image) VALUES (?,?,?,?)");
$stmt->execute(array($title,$content,$id,$imagename));




$count = $stmt->rowCount();

if ($count > 0) {
   
    echo json_encode(array("status" => "succes",),);
} else {
    echo json_encode(array("status" => "fail"));
}
}else{
        echo json_encode(array("status" => "fail"));
        
}
?>