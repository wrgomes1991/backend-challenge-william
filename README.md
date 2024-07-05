Backend Challenge Application

Este projeto contém uma aplicação FastAPI containerizada para verificação de JWT. A aplicação é empacotada em um contêiner Docker para fácil implantação em um cluster Kubernetes.

Requisitos
Docker
Kubernetes
CI/CD (GitHub Actions)

Configuração da Imagem Docker
A aplicação FastAPI é containerizada usando Docker. 

Construindo e Publicando a Imagem Docker
Construa a imagem Docker:

sh
Copiar código
docker build -t <seu-registro>/challenge-app:latest .
Publique a imagem no registro de contêiner:

sh
Copiar código
docker push <seu-registro>/challenge-app:latest

Logs
A aplicação FastAPI utiliza o módulo de logging padrão do Python para registrar informações importantes.

CI/CD

Configurar as credenciais AWS no GitHub Secrets, com o seguinte formato:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY

KUBECONFIG

O processo de implantação será automatizado usando um pipeline CI/CD (por exemplo, GitHub Actions). 




Contato
Para dúvidas ou suporte, entre em contato com o administrador do projeto.

Este README fornece uma visão geral básica e as instruções necessárias para construir, configurar e implantar a aplicação FastAPI utilizando Docker e Kubernetes. Ajuste conforme necessário para o seu ambiente específico.