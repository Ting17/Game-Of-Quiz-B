var app = angular.module("myApp", ["ngRoute"]);


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
