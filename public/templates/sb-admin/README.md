# Escamboapp

Projeto de uma mini loja virtual com três módulos
* Backoffice -> Cadastro de membros e configuração de acesso
* Profile -> Cadastro e configurações de produtos
* Site -> lista e detalhes de todos os produtos

## Dependências do projeto 

* ImageMagick (https://www.imagemagick.org)

```
	sudo apt-get update
	sudo apt-get install imagemagick
```
* Graphiz(https://www.graphiz.org) - Apenas para desenvolvimento
```
	sudo apt-get update
	sudo apt-get install graphiz
```

## Acesso

Após clonar o projeto faça as migrações
```
rake dev:setup
``` 