var app = angular.module("myApp", ["ngRoute"]);


function checkansSound(){
    var audio = new Audio('sound/success.mp3');
    audio.play();
}

function giveupSound(){
    var audio = new Audio('sound/Chime.mp3');
    audio.play();
}

function collectSound(){
    var audio = new Audio('sound/Heavengate-angelic-transition.mp3');
    audio.play();
}

function meowSound(){
    var audio = new Audio('sound/Blop.mp3');
    audio.play();
} 

//pusheen appear
setTimeout(function() {
    document.getElementById("cateatgif").style.display="none";
    $("#catgiffinish").show();
}, 10000); // appear after 10 seconds

function changeImage1() {
    document.getElementById("imgClickAndChange1").src = "resources/img/chestopen.png";
}

function changeImage2() {
    document.getElementById("imgClickAndChange2").src = "resources/img/chestopen.png";
}

function changeImage3() {
    document.getElementById("imgClickAndChange3").src = "resources/img/chestopen.png";
}



