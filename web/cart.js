// Timestamp of cart that page was last updated with
var lastCartUpdate = 0;

/*
 * Adds the specified item to the shopping cart, via Ajax call
 * itemCode - product code of the item to add
 */
function addToCart(itemCode) {

    var req = newXMLHttpRequest();

    req.onreadystatechange = getReadyStateHandler(req, updateCart);
 
    req.open("POST", "cart.do", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("action=add&item="+itemCode);
}

/*
 * Deletes the specified item from the shopping cart, via Ajax call
 * itemCode - product code of the item to add
 */
function deleteFromCart(itemCode) {

    var req = newXMLHttpRequest();

    req.onreadystatechange = getReadyStateHandler(req, updateCart);
 
    req.open("POST", "cart.do", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("action=delete&item="+itemCode);
}


/*
 * Update shopping-cart area of page to reflect contents of cart
 * described in JSON document.
 */
function updateCart(cartJSON) {
    
    var shopCart = jsonParse(cartJSON);
    var generated = shopCart.generated;
    
    if (generated > lastCartUpdate) {
        lastCartUpdate = generated;
        var contents = document.getElementById("contents");
        contents.innerHTML = "";

        var cartItems = shopCart.cart;
        for (var i in cartItems) {
            if (i%2 == 1) {
                var itemDetails = cartItems[i];
            
                var name = itemDetails.name;
                var quantity = itemDetails.quantity;

                var listItem = document.createElement("li");
                listItem.appendChild(document.createTextNode(name+" x "+quantity));
                contents.appendChild(listItem);
            }
        }

    }

    document.getElementById("total").innerHTML = shopCart.total;
}
