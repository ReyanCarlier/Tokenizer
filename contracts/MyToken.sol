// SPDX-License-Identifier: MIT

// Ce contrat intelligent est pour le token ERC20 "42TOKEN" (42TOK)
// Il est basé sur les contrats OpenZeppelin.
// Il est déployé sur le réseau de test Sepolia.
// @Auteur: Recalie
// @Date: 29-01-2024
// @Version: 1

// Sélection de la version du compilateur Solidity
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    address private _reserveAddress;
    uint256 private _maxWhaleAmount;

    constructor(address initialOwner, address reserveAddress) ERC20("42TOKEN", "42TOK") Ownable(initialOwner) {
        _mint(initialOwner, 1000000 * (10 ** uint256(decimals())));
        _maxWhaleAmount = 100000 * (10 ** uint256(decimals()));
        _reserveAddress = reserveAddress;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require((recipient.balance + amount) < getMaxWhaleAmount() || msg.sender == owner(), string(abi.encodePacked("Recipient balance will be higher than anti-whale limit (", uint2str(getMaxWhaleAmount()), " 42TOK)")));
        require(amount <= _maxWhaleAmount || msg.sender == owner(), "Transfer amount exceeds whale limit");
        require(msg.sender.balance > amount + (amount * 1) / 100, "You don't have enough tokens to perform this operation."); // On s'assure que la personne qui envoie dispose de suffisament de jetons.
        uint256 reserveAmount = (amount * 1) / 100; // Calcul du montant à envoyer à la réserve (1%)
        _transfer(msg.sender, recipient, amount); // Transfert au destinataire
        _transfer(msg.sender, _reserveAddress, reserveAmount); // Transfert à la réserve
        return true;
    }

    function setMaxWhaleAmount(uint256 amount) public onlyOwner {
        _maxWhaleAmount = amount;
    }

    function getOwner() public view returns (address) {
        return owner();
    }

    // Fonction pour déposer des jetons dans la réserve
    function depositToReserve(uint256 amount) public onlyOwner {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Not enough balance to deposit");
        _transfer(msg.sender, _reserveAddress, amount);
    }

    // Fonction pour convertir un uint en une chaîne de caractères
    function uint2str(uint _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    // Fonction pour retirer des jetons de la réserve
    function withdrawFromReserve(uint256 amount, address target) public onlyOwner {
        if (target == getOwner())
        {
            require(false, "Withdraw to owner is not allowed.");
        }
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(_reserveAddress) >= amount, "Not enough balance to withdraw");
        _transfer(_reserveAddress, msg.sender, amount);
    }

    // Fonction pour récupérer le montant maximum de jetons qu'un utilisateur peut envoyer
    function getMaxWhaleAmount() public view returns (uint256) {
        return _maxWhaleAmount;
    }

    // Fonction pour récupérer l'adresse de la réserve
    function getReserveAddress() public view returns (address) {
        return _reserveAddress;
    }

    // Fonction pour récupérer le solde de la réserve
    function getReserveBalance() public view returns (uint256) {
        return balanceOf(_reserveAddress);
    }

    // Fonction pour récupérer le solde de l'adresse du propriétaire
    function getOwnerBalance() public view returns (uint256) {
        return balanceOf(owner());
    }
}

