// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/utils/math/Math.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

abstract contract BuyPass is Ownable {
    using Math for uint256;

    uint256 private immutable feeTax;
    address payable private immutable plataformPay;
    address payable private immutable ownerPay;

    constructor(address ownerAdrr, address addrPlataform, uint256 feePlataform) {
        plataformPay = payable(addrPlataform);
        ownerPay = payable(ownerAdrr);
        feeTax = feePlataform;
    }

    function buyNFTPass(uint256 idType, uint256 qtd) public payable virtual;

    function checkPayment(uint256 idType, uint256 qtd) public payable virtual;

    function calcPayValues(uint256 total) public view returns (uint256 payValue, uint256 feeValue) {
        feeValue = (Math.mulDiv(total, feeTax, 100));
        payValue = total - feeValue;
    }

    receive() external payable {}
    fallback() external payable {}

    function claimPayment() external onlyOwner {
        uint256 amount = address(this).balance;

        uint256 payValue;
        uint256 feeValue;
        (payValue, feeValue) = calcPayValues(amount);

        Address.sendValue(ownerPay, payValue);
        Address.sendValue(plataformPay, feeValue);

        /* (bool sentOwner,) = ownerPay.call{value: payValue}("");
        require(sentOwner, "Failed to pay ownerPay");

        (bool sentPlataform,) = plataformPay.call{value: feeValue}("");
        require(sentPlataform, "Failed to pay plataformPay");*/
    }
}
