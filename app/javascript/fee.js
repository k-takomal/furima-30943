
if(document.URL.match("/items/new") || document.URL.match("/edit")){

function check(){
let input = document.getElementById("item-price");
input.onkeyup = printKey;

  function printKey(){
 let inputValue = input.value;
 
  document.getElementById('add-tax-price').innerHTML = Math.floor(inputValue*0.1);

  document.getElementById('profit').innerHTML =inputValue - Math.floor(inputValue*0.1);
  }
};
setInterval(check,1000)
 }