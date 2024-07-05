# Backend Challenge Application

Este projeto contém uma aplicação Python com FastAPI containerizada para verificação de JWT, incluindo os módulos terraform para criação da infraestrutura necessária para rodar em ambiente AWS.

# Requisitos

- Terraform
- Docker
- Kubernetes
- CI/CD (GitHub Actions)

# Configuração da Imagem Docker

A aplicação FastAPI é containerizada usando Docker. 

Construindo e Publicando a Imagem Docker em um ECR da AWS por meio da pipeline do Github Actions.

# CI/CD

O projeto está configurado com os Workflows do Github Actions com dois arquivos sendo um a pipeline referente a infraestrutura e o outro referente a aplicação.

Configurar as credenciais AWS no GitHub Secrets, com o seguinte formato:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
KUBECONFIG

O processo de implantação será automatizado usando um pipeline CI/CD (GitHub Actions) que é triggado a partir de um commit na branch main. 



Contato

Para dúvidas ou suporte, entre em contato com o administrador do projeto.

Este README fornece uma visão geral básica e as instruções necessárias para construir, configurar e implantar a aplicação FastAPI utilizando Docker e Kubernetes. Ajuste conforme necessário para o seu ambiente específico.
