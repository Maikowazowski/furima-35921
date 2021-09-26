window.addEventListener('load', function(){
  
  const priceInput = document.getElementById("item-price");
  
  priceInput.addEventListener('input', function(){
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const addProfitDom = document.getElementById("profit");
    const calcFee = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = calcFee;
    addProfitDom.innerHTML = (inputValue - calcFee);
  })
});