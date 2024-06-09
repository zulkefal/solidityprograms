//Simple Ecommerce Products Smart Contract

// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Ecommerce {
    struct Product {
        string title;
        string desc;
        address payable seller;
        uint productId;
        uint price;
        address buyer;
        bool delivered;
    }

    Product[] public products;
    uint counter = 1;

    event registered(string title, uint productId, address seller);
    event bought(uint productId, address buyer);
    event delivered(uint productId);

    function registerProduct(string memory _title, string memory _desc, uint _price) public {
        require(_price > 0, "Price should be greater than zero");
        Product memory tempProduct;
        tempProduct.title = _title;
        tempProduct.desc = _desc;
        tempProduct.price = _price * 10**18;
        tempProduct.seller = payable(msg.sender);
        tempProduct.productId = counter;
        tempProduct.buyer = address(msg.sender);
        tempProduct.delivered = false; 
        counter++;
        products.push(tempProduct);

        emit registered(_title, tempProduct.productId, msg.sender);
    }

    function buy(uint _productId) payable public {
        require(_productId > 0 && _productId <= products.length, "Invalid product ID");
        Product storage product = products[_productId - 1];
        require(product.price == msg.value, "Please pay the exact price");
        require(product.seller != msg.sender, "Seller can't be the buyer");
        product.buyer = msg.sender;
        emit bought(_productId, msg.sender);
    }

    function delivery(uint _productId) public payable{
        require(_productId > 0 && _productId <= products.length, "Invalid product ID");
        Product storage product = products[_productId - 1];
        require(product.buyer == msg.sender, "Only buyer can confirm this");
        product.delivered = true;
        product.seller.transfer(product.price);
        emit delivered(_productId);
    }
}

