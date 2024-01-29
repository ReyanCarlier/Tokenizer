// SPDX-License-Identifier: MIT

// Ce contrat intelligent est pour le token ERC20 "42TOKEN" (42TOK)
// Il est basé sur les contrats OpenZeppelin et est un contrat évolutif (upgradeable)
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
        require(amount <= _maxWhaleAmount || msg.sender == owner(), "Transfer amount exceeds whale limit");

        uint256 reserveAmount = (amount * 1) / 100; // Calcul du montant à envoyer à la réserve (1%)
        uint256 transferAmount = amount - reserveAmount; // Montant à transférer à l'adresse du destinataire

        _transfer(msg.sender, recipient, transferAmount); // Transfert au destinataire
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

