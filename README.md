# practice-kubernetes

使用 FastAPI 簡單建立起一個回應 "hello, Python" 的服務

`uvicorn main:app --host <ip-number> --port <port-number> --reload`

## Docker

- `docker run <image-name>`: 執行容器
  - `--interactive --tty`: 執行容器並連接終端對話視窗
  - `--detach`: 在背景啟動容器並顯示容器 ID
  - `--publish <host-port>:<container-port>`: 配發實體網路的連接埠`<host-port>`給容器`<container-port>`使用
- `docker rm <container-id>`: 移除容器
  - `-f`: 強制執行
  - `$(docker ps -aq)`: 列出所有容器 ID，可作為數值替換`<container-id>`
- `docker ps`: 列出執行中容器
  - `-a`: 包含未在執行中的容器
- `docker images`: 列出所有映像檔
- `docker top <container-id>`: 列出指定容器的程序
- `docker logs <container-id>`: 顯示容器的日誌檔內容
- `docker inspect <container-id>`: 顯示容器的詳細完整資訊
- `docker stats <container-id>`: 顯示容器使用系統資源狀況
- `docker cp <source-path> <target-path>`: 透過容器 ID 也可以將檔案複製進容器內，ex: `docker cp index.html fbe:/usr/local/apache2/htdocs/index.html`

### Dockerfile

- 執行建立 image: `docker build -t <image-name> <dockerfile-path>`

### Compose

- 執行 Compose: `docker compose up -d`
- 停用 Compose: `docker compose down`

## Kubernetes

使用 Minikube 建立單ㄧ節點環境
