// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "./PassType.sol";
import "./BuyPass.sol";

contract NFTPass is ERC1155, ERC1155Pausable, ERC1155Burnable, ERC1155Supply, PassType, BuyPass {
    string public name = "NFT PASS";
    string public symbol = "NFPASS";

    //error OperatorUNAUTHORIZED(address operator , address executor);

    error InsufficientAmountPayment(uint256 valueTotal, uint256 valueSender);

    constructor(address initialOwner, address feeAddr, uint256 feeTax, string memory nm, string memory sbl)
        ERC1155("")
        PassType(initialOwner)
        BuyPass(initialOwner, feeAddr, feeTax)
    {
        name = nm;
        symbol = sbl;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mintInternal(address account, uint256 id, uint256 amount) internal activePASSType(id) {
        PassType.PASSType storage pType = passTypes[id];

        if (pType.supply + amount > pType.maxSupply) {
            revert PassType.InsufficientSupply(pType.supply + amount, pType.maxSupply);
        }

        pType.supply = pType.supply + amount;

        bytes memory data = "NFTPASS";

        _mint(account, id, amount, data);
    }

    function mint(address account, uint256 id, uint256 amount) external onlyOwner activePASSType(id) {
        mintInternal(account, id, amount);
    }

    function buyNFTPass(uint256 idType, uint256 qtd) public payable override activePASSType(idType) {
        checkPayment(idType, qtd);
        mintInternal(msg.sender, idType, qtd);
    }

    function checkPayment(uint256 idType, uint256 qtd) public payable override {
        PASSType memory pType = getPASSType(idType);

        uint256 priceTotal = pType.price * qtd;

        if (priceTotal > msg.value) {
            revert InsufficientAmountPayment(priceTotal, msg.value);
        }
    }

    function contractURI() public view returns (string memory) {
        return this.getPassInfoJSON();
    }

    function uri(uint256 id) public view override returns (string memory) {
        return this.getPassTypeJSON(id);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Pausable, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
