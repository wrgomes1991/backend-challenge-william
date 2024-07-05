# Backend Challenge Application

Este projeto contém uma aplicação Python com FastAPI containerizada para verificação de JWT, incluindo os módulos terraform para criação da infraestrutura necessária para rodar em ambiente AWS.

# Requisitos

- Terraform
- Docker
- Kubernetes
- CI/CD (GitHub Actions)
- Helm

# Helm Chart

- A aplicação está com os values do chart apontando para uma imagem criada e compartilhada por mim no meu repositório público do Dockerhub, para efeito de testes o chart pode ser instalado em qualquer cluster Kubernettes por meio do comando

```
helm upgrade --install backend-app .
```

estando no diretório ./backend-app

Considerando que a solução necessita de diversos pontos de infraestrutura a serem criados nas etapas do Terraform que consequentemente geram insumos para esses valores, após a criação da Infra os passos de criação das secrets do GitHub devem ser seguidos para que o valor do values possa ser alterado com a imagem do repo AWS.


# Configuração da Imagem Docker

A aplicação FastAPI é containerizada usando Docker. 

Construindo e Publicando a Imagem Docker em um ECR da AWS por meio da pipeline do Github Actions.

# CI/CD

O projeto está configurado com os Workflows do Github Actions com dois arquivos sendo um a pipeline referente a infraestrutura e o outro referente a aplicação.

Configurar as credenciais AWS no GitHub Secrets, com o seguinte formato:

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

Após essas configurações é possível realizar um push no diretório challenge-aws-terraform que vai triggar o pipeline que faz a criação da infraestrtura e coletar as informações necessárias para os demais secrets:

- KUBECONFIG
- AWS_EKS_CLUSTER_NAME
- ECR_ID

Satisfazendo essas informações podemos realizar um push na pasta backend-app que vai triggar o pipeline da aplicação e então trocar o valor do arquivo values.yaml com o repositorio de imagem criado onde foi feito o push da imagem e assim rodando o deployment via helm configurado na pipeline.
O primeiro Run da pipeline da aplicação vai conter erros devido aos ajustes necessários com os dados da imagem no repo ECR que devem ser adicionados para que a última etapa de Deploy ocorra corretamente.


Contato

Para dúvidas ou suporte, entre em contato com o administrador do projeto.

Este README fornece uma visão geral básica e as instruções necessárias para construir, configurar e implantar a aplicação FastAPI utilizando Docker e Kubernetes. Ajuste conforme necessário para o seu ambiente específico.
