# Procédure de déploiement de 42TOK sur Sepolia Testnet

## Pré-requis :
Google Chrome
Extension Metamask (Deux comptes sont nécessaires)
REMIX IDE - https://remix.ethereum.org

## Obtention de sETH (Sepolia ETH) sur le réseau Sepolia Testnet :
Créer un compte sur Alchemy : https://www.alchemy.com/
Accéder au Faucet de Sepolia : https://sepoliafaucet.com/
Réaliser la demande d'ETH (0.5) vers le wallet Metamask créé plus tôt.

## Création du Smart Contract

### Mise en place
Cloner le repertoire de 42TOK (ou fork le projet et se connecter à Github sur Remix)
Accéder à REMIX : https://remix.ethereum.org
Importer le code dans REMIX

### Compilation
Ouvrir le fichier `MyToken.sol` situé dans le dossier `contracts`
Dans `Solidity Compiler` (menu contextuel à gauche), cliquer sur `Compile MyToken.sol`

### Déploiement
Dans `Deploy & Run Transactions`, choisissez l'environnement "Injected Provider - MetaMask"
Sélectionner dans `Account` le bon compte
Ne pas modifier les autres valeurs
Vérifier que dans `Contract` il soit bien renseigné `MyToken - contracts/MyToken.sol`
Dans `Deploy`, renseigner dans `Initial Owner` l'adresse utilisée pour déployer le contrat (ce doit être la même adresse que dans `Account` plus haut)
Toujours dans `Deploy`, renseigner dans `ReserveAddress` l'adresse du second wallet qui servira de réserve
Enfin, appuyez sur `transact`

### Post-déploiement
Dans le terminal, un lien vers EtherScan (`view on etherscan`) vous permettra de voir la transaction initiale réalisée ainsi que le déploiement du contrat de 42TOK, ouvrir et laisser cette page ouverte.

### Ajouter 42TOK à Metamask
Par défaut, le jeton 42TOK ne sera pas visible sur Metamask, il faudra au préalable ajouter le jeton. Pour se faire, accédez à Metamask à partir de l'extension, cliquez sur `+ Import tokens`.  Dans le champ `Token contract address`, renseigner l'adresse du contrat visible sur EtherScan plus tôt. Les champs `Token symbol` et `Token decimal` seront automatiquement renseignés, appuyer alors sur `Next`.

Répéter la manipulation sur le second compte Metamask.

Bienvenue sur 42TOK !
