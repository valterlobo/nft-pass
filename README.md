## NFT PASS

# deploy

forge script script/DeployToken.s.sol:NFTDeployScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv

# deploy factory

forge script script/DeployFactory.s.sol:DeployFactory --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv

# set

forge script script/TypeToken.s.sol:NFTTypeScript --rpc-url $SEPOLIA_RPC_URL --broadcast  -vvvv

# mint

forge script script/MintToken.s.sol:NFTMintScript --rpc-url $SEPOLIA_RPC_URL --broadcast  -vvvv

## TODO


- Eventos para criação de  NFT PASS ( index e retornos)
- UPDATE AND GET fee Tax and fee addr -> NFTFactory
- Revisar metodos e segurança
- Testes/Coverage nos contratos.
- API ou TheGraph para pesquisa de eventos.
- Desenvolver um micro componente para incluir em  outras paginas de eventos.
- MultCall para adicionar as info e os tipos de pass.
- Melhoria nos checks de parametros ( tempo de incio do evento , tempo final , etc ..)
- Teste em uma pagina  checando o pass(NFT) para identificar novos requisistos
- Integração no discord - com o collab !
- Requisitos para o estorno.
- Garantir o pagamento somente apos o termino do evento e confirmação dos participantes.

## Documentation fondry

<https://book.getfoundry.sh/>

## Usage

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Format

```shell
forge fmt
```

### Gas Snapshots

```shell
forge snapshot
```

### Anvil

```shell
anvil
```
