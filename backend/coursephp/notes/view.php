<?php

include "../connect.php";


$id = requestFilter("id");


$stmt = $con->prepare("SELECT * FROM notes WHERE `notes_user` = ? ");
$stmt->execute(array($id));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();

if($count>0){
echo json_encode(array("status"=>"succes","data"=>$data));
}else{
echo json_encode(array("status"=>"fail"));

}

?>