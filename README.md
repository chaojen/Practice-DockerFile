# practice-kubernetes

使用 FastAPI 簡單建立起一個回應 "hello, Python" 的服務

`uvicorn main:app --host <ip-number> --port <port-number> --reload`

## Docker Command

- `docker run <image-name>`: 執行容器
  - `--interactive --tty`: 執行容器並連接終端對話視窗
  - `-d`, `--detach`: 在背景啟動容器並顯示容器 ID
  - `-p`, `--publish <host-port>:<container-port>`: 配發實體網路的連接埠`<host-port>`給容器`<container-port>`使用
  - `--name`: 為容器命名
  - `-e <KEY>=<VALUE>`, `--env <KEY>=<VALUE>`: 設定環境變數
- `docker rm <container-id>`: 移除容器
  - `-f`, `--force`: 強制執行
  - `$(docker ps -aq)`: 列出所有容器 ID，可作為數值替換`<container-id>`
- `docker ps`: 列出執行中容器
  - `-a`: 包含未在執行中的容器
- `docker image pull <image-name>`: 從 Docker Hub 上抓取映像檔
- `docker image history <image-name>`: 顯示映像檔的映像層(metadata)
- `docker images`: 列出所有映像檔
  - `'<alphabet>*'`: 指定開頭字母
- `docker top <container-id>`: 列出指定容器的程序
- `docker logs <container-id>`: 顯示容器的日誌檔內容
- `docker inspect <container-id>`: 顯示容器的詳細完整資訊
- `docker stats <container-id>`: 顯示容器使用系統資源狀況
- `docker cp <source-path> <target-path>`: 透過容器 ID 也可以將檔案複製進容器內，ex: `docker cp index.html fbe:/usr/local/apache2/htdocs/index.html`
- `docker build <dockerfile-path>`: 建立映像檔
  - `-t <image-name>`, `--tag <image-name>`: 設定映像檔名稱
  - `<image-name>:<tag-name>`: 標記 TAG
- `docker system df`: 顯示 Docker 實際上所使用的磁碟空間
- `docker commit <container-name> <new-image-name>`: 以容器建立新的映像檔

### Dockerfile

- `FROM <image-name>`: 基礎映像檔，每個映像檔都是建立在另一個映像檔之上
- `ENV <KEY>=<"VALUE">`: 用於設置環境變數
- `WORKDIR <path>`: 指定映像檔系統中的工作目錄
- `COPY <source-path> <target-path>`: 將檔案複製到工作目錄下的路徑
- `CMD [..., ...]`: 設定在啟動容器時自動執行的指令

### Compose

- `docker compose up -d`: 執行 Compose
- `docker compose down`: 停用 Compose

## Kubernetes

使用 Minikube 建立單ㄧ節點環境
