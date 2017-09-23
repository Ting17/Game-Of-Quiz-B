var app = angular.module("myApp", ["ngRoute"]);

var currentDiv = document.getElementById("divEng");
    function show(divID) {
        var div = document.getElementById(divID);

        currentDiv.style.display = "none";
        div.style.display = "block";

        currentDiv = div;
    }
    

function checkansSound(){
    var audio = new Audio('sound/Bing-sound.mp3');
    audio.play();
}

function giveupSound(){
    var audio = new Audio('sound/Fail-trombone.mp3');
    audio.play();
}

function collectSound(){
    var audio = new Audio('sound/Heavengate-angelic-transition.mp3');
    audio.play();
}

function meowSound(){
    var audio = new Audio('sound/Cat-meow-sound-2.mp3');
    audio.play();
} 

//pusheen appear
setTimeout(function() {
    document.getElementById("cateatgif").style.display="none";
    $("#catgiffinish").show();
}, 10000); // appear after 10 seconds