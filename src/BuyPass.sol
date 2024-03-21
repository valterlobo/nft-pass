// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/math/Math.sol";

abstract contract BuyPass {
    using Math for uint256;

    uint256 feeTax;
    address payable plataformPay;
    address payable ownerPay;

    constructor(address ownerAdrr, address feeAddr, uint256 fee) {
        plataformPay = payable(feeAddr);
        ownerPay = payable(ownerAdrr);
        feeTax = fee;
    }

    function buyNFTPass(uint256 idType, uint256 qtd) public payable virtual;

    function checkPayment(uint256 idType, uint256 qtd) public payable virtual;

    function calcPayValues(uint256 total) public view returns (uint256 payValue, uint256 feeValue) {
        feeValue = (Math.mulDiv(total, feeTax, 100));
        payValue = total - feeValue;
    }

    function claimPayment() external {
        uint256 amount = address(this).balance;

        uint256 payValue;
        uint256 feeValue;
        (payValue, feeValue) = calcPayValues(amount);

        (bool sentOwner, bytes memory dataOwner) = ownerPay.call{value: payValue}("");
        require(sentOwner, "Failed to pay ownerPay");

        (bool sentPlataform, bytes memory dataPlataform) = plataformPay.call{value: feeValue}("");
        require(sentPlataform, "Failed to pay plataformPay");
    }
}
