# practice-kubernetes

使用 FastAPI 簡單建立起一個回應 "hello, Python" 的服務

`uvicorn main:app --host <ip-number> --port <port-number> --reload`

## Docker

- 列出所有 containers: `docker ps -a`
- 列出 images: `docker images`

### Dockerfile

- 執行建立 image: `docker build -t <image-name> <dockerfile-path>`

### Compose

- 執行 Compose: `docker compose up -d`
- 停用 Compose: `docker compose down`

## Kubernetes

使用 Minikube 建立單ㄧ節點環境
