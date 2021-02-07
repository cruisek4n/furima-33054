window.addEventListener('load', () =>{
  console.log("ok");
  
  const priceInput = document.getElementById("item-price");
    console.log(priceInput);
  
  priceInput.addEventListener('input', () =>{
    console.log("イベント発火");

    const inputValue = priceInput.value;
     console.log(inputValue);

    const addTaxDom = document.getElementById("add-tax-price");
     addTaxDom.innerHTML = (Math.floor(inputValue * 0.1));
     console.log(addTaxDom);

    const profitNumber = document.getElementById("profit");
     const tax = inputValue * 0.1;
     console.log(tax);
     profitNumber.innerHTML = (Math.floor(inputValue - tax));
     console.log(profitNumber); 
    
    
  });
});

