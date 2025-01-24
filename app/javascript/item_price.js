function item_price (){
  const priceInput = document.getElementById('item-price');

  priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;
  const addTaxDom = document.getElementById('add-tax-price');
  const tax =Math.floor(inputValue * 0.1);
  addTaxDom.innerHTML =Math.floor(inputValue * 0.1);

  const profitDom = document.getElementById('profit');
  const profit = inputValue - tax;
  profitDom.innerHTML = profit;
  });
};

window.addEventListener('turbo:load', item_price);
window.addEventListener('turbo:render', item_price);
