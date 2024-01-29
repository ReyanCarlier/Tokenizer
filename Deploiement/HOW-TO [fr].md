# Procédure de déploiement de 42TOK sur Sepolia Testnet

## Pré-requis :
- Google Chrome
- Extension Metamask (Deux comptes sont nécessaires)
- REMIX IDE - https://remix.ethereum.org

## Obtention de sETH (Sepolia ETH) sur le réseau Sepolia Testnet :
1. Créez un compte sur Alchemy : https://www.alchemy.com/
2. Accédez au Faucet de Sepolia : https://sepoliafaucet.com/
3. Effectuez la demande d'ETH (0.5) vers le wallet Metamask créé précédemment.

## Création du Smart Contract

### Mise en place
1. Clonez le répertoire de 42TOK (ou forkez le projet et connectez-vous à Github sur Remix).
2. Accédez à REMIX : https://remix.ethereum.org
3. Importez le code dans REMIX.

### Compilation
1. Ouvrez le fichier `MyToken.sol` situé dans le dossier `contracts`.
2. Dans `Solidity Compiler` (menu contextuel à gauche), cliquez sur `Compile MyToken.sol`.

### Déploiement
1. Dans `Deploy & Run Transactions`, choisissez l'environnement "Injected Provider - MetaMask".
2. Sélectionnez dans `Account` le bon compte.
3. Ne modifiez pas les autres valeurs.
4. Vérifiez que dans `Contract` il soit bien renseigné `MyToken - contracts/MyToken.sol`.
5. Dans `Deploy`, renseignez dans `Initial Owner` l'adresse utilisée pour déployer le contrat (ce doit être la même adresse que dans `Account` plus haut).
6. Toujours dans `Deploy`, renseignez dans `Reserve Address` l'adresse du second wallet qui servira de réserve.
7. Enfin, appuyez sur `Transact`.

### Post-déploiement
1. Dans le terminal, un lien vers EtherScan (`view on etherscan`) vous permettra de voir la transaction initiale réalisée ainsi que le déploiement du contrat de 42TOK, ouvrez et laissez cette page ouverte.

### Ajouter 42TOK à Metamask
- Par défaut, le jeton 42TOK ne sera pas visible sur Metamask, il faudra au préalable ajouter le jeton. Pour ce faire, accédez à Metamask à partir de l'extension, cliquez sur `+ Import tokens`.  Dans le champ `Token contract address`, renseignez l'adresse du contrat visible sur EtherScan plus tôt. Les champs `Token symbol` et `Token decimal` seront automatiquement renseignés, appuyez alors sur `Next`.
- Répétez la manipulation sur le second compte Metamask.

Bienvenue sur 42TOK !
