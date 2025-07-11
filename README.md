# Repositório: video-iac (Infraestrutura como Código)

Este repositório contém a infraestrutura como código para o projeto de Processamento de Vídeos FIAP X. Ele define e orquestra todos os serviços da aplicação utilizando Docker Compose, facilitando o setup e a execução do ambiente completo.

## Estrutura do Projeto e Componentes Orquestrados

<img width="885" height="914" alt="image" src="https://github.com/user-attachments/assets/b2ff3965-e705-414c-badb-84997326b433" />

Este repositório é o ponto central para levantar o ambiente local completo, que inclui:

* **Front-end (gray-video-portal):** A interface web da aplicação, servida por Nginx.
* **User Auth Service:** Microsserviço de autenticação e gerenciamento de usuários em Go.
* **Video Processor Service:** Microsserviço de processamento de vídeos em Go.
* **PostgreSQL:** Banco de dados relacional para persistência de dados.
* **RabbitMQ:** Broker de mensagens para comunicação assíncrona.
* **Prometheus:** Sistema de monitoramento para coleta de métricas.
* **Grafana:** Ferramenta de visualização para dashboards de monitoramento.

## Repositórios Relacionados

O projeto é modular e distribuído em outros repositórios, que são construídos e orquestrados a partir deste `video-iac`:

* **Front-end:** [https://github.com/vitovidale/gray-video-portal](https://github.com/vitovidale/gray-video-portal)
* **User Auth Service:** [https://github.com/vitovidale/user-auth-service](https://github.com/vitovidale/user-auth-service)
* **Video Processor Service:** [https://github.com/vitovidale/video-processor-service](https://github.com/vitovidale/video-processor-service)
