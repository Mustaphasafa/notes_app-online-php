<?php

define("MB", 1048576);

function requestFilter($request){
    return htmlspecialchars(strip_tags($_POST[$request]));
}

function uploadImage($imageRequest){

    global $Msgerror;

    $imagename = rand(1000,10000) . $_FILES[$imageRequest]['name'];
    $imagetmp = $_FILES[$imageRequest]['tmp_name'];
    $imagesize = $_FILES[$imageRequest]["size"];

    $strtoarray = explode(".",$imagename);
    $ext = end($strtoarray);
    $ext = strtolower($ext);

    $allowext = array("jpg","png","gif","mp3");

    if(!empty($imagename) && !in_array($ext,$allowext)){
         $Msgerror[] = "Ext";
    }
    if($imagesize > 2 * MB){
        $Msgerror[] = "Size";
    }
    if(empty($Msgerror)){
        move_uploaded_file($imagetmp,"../upload/".$imagename);
        return $imagename;
    }else{
       return "fail";

    }

}

function deleteImage($dir,$imagename){
    if(file_exists($dir."/".$imagename)){
        unlink($dir."/".$imagename);
    }
}
function    checkAuthenticate() {
     if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
        if ($_SERVER['PHP_AUTH_USER'] != "mustapha" ||  $_SERVER['PHP_AUTH_PW'] != "123456"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
}
?>