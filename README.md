# practice-microservice

## Docker Common

- `docker system df`: 顯示 Docker 實際上所使用的磁碟空間
- `docker login --username <user-name>`: 登入儲存庫伺服器(預設為 Docker Hub)
- `docker info`: 可以查看 Docker 的相關設定，包含不安全的登錄伺服器清單
- `echo $'\n127.0.0.1 registry.local' | sudo tee -a /etc/hosts`: 寫入電腦的 hosts 檔案來為本機的 Docker Registry 取別名

## Docker Network

- `docker network create <network-name>`: 建立 Docker 虛擬網路
- `docker network list`: 列出所有虛擬網路

## Dockerfile

- `FROM <image-name>`: 基礎映像檔，每個映像檔都是建立在另一個映像檔之上
- `ENV <KEY>=<"VALUE">`: 用於設置環境變數
- `WORKDIR <path>`: 指定映像檔系統中的工作目錄
- `COPY <source-path> <target-path>`: 將檔案複製到工作目錄下的路徑
- `RUN ...`: 執行指令
- `CMD ...`: 設定在啟動容器時自動執行的指令
- `ENTRYPOINT [..., ...]`: 從映像檔啟動容器時應執行的操作
- `EXPOSE <port-number>`: 指定連接的埠號
- `VPLUME <target-directory>`: 建立新的 volume 掛載到容器中，每次執行都會是隨幾的 ID，但是在容器刪除後會保存
- `HEALTHCHECK ...`: 狀態檢查
- `CMD curl --fail ... && ...`: 相依性檢查利用 `CMD` 參考快速失敗(fail-fast)設計

## Docker Image

- `docker image pull <image-name>`: 從 Docker Hub 上抓取映像檔
- `docker image push <image-reference>`: 將映像檔推上服務器
- `docker image history <image-name>`: 顯示映像檔的映像層(metadata)
- `docker image tag <target-image> <account-name>/<image-name>:<tag>`: 將映像檔重新命名為映像檔完整名稱(image reference)
- `docker images`: 列出所有映像檔
  - `'<key-word>*'`: 指定開頭字母
  - `--filter reference=<image-name> --filter reference='*/<image-name>'`: 列出所有該映像檔的版本
- `docker build <dockerfile-path>`: 建立映像檔
  - `-t <image-name>`, `--tag <image-name>`: 設定映像檔名稱
  - `<image-name>:<tag-name>`: 標記 TAG
- `docker run <image-name>`: 執行容器
  - `--interactive --tty`: 執行容器並連接終端對話視窗
  - `-d`, `--detach`: 在背景啟動容器並顯示容器 ID
  - `-p`, `--publish <host-port>:<container-port>`: 配發實體網路的連接埠`<host-port>`給容器`<container-port>`使用
  - `--name`: 為容器命名
  - `-e <KEY>=<VALUE>`, `--env <KEY>=<VALUE>`: 設定環境變數
  - `--network <vnetwork-name>`: 連接到 Docker 虛擬網路
  - `--restart <options>`: 設定重啟 Docker 時容器的重啟策略
  - `--volumes-from <container-name>`: 從其他容器掛載 Volume
  - `-v <volume-name>:<path>`: 掛載 Volume，此指令會覆蓋 Dockerfile 中的 `VOLUME`
  - `--mount type=<bind>,source=<source-path>,target=<target-path>`: 掛載本機資料夾
    - `readonly`: 唯讀
  - `--health-interval <time>`: 狀態檢查時間頻率
  - `--memory <mount>m`: 限制容器記憶體空間
  - `--memory-swap <mount>G`: 限制容器硬碟置換空間
  - `--cpu-shares <mount>`: 限制 CPU 的使用率

## Registry API [(docs)](https://docs.docker.com/registry/spec/api/)

- `curl <registry-server-path>/v2/<image-name>/tags/list`: 列出 Registry 中 image 的所有版本
- `curl --head <registry-server-path>/v2/<image-name>/manifests/<tag> -H 'Accept: application/vnd.docker.distribution.manifest.v2+json'`: 查看 image tag 版本的 manifest
- `curl -X DELETE <registry-server-path>/v2/<image-name>/manifests sha256:<hash-number>`: 刪除對應雜湊值的 image

## Docker Container

- `docker rm <container-id>`: 移除容器
  - `-f`, `--force`: 強制執行
  - `$(docker ps -aq)`: 列出所有容器 ID，可作為數值替換`<container-id>`
- `docker ps`: 列出執行中容器
  - `-a`: 包含未在執行中的容器
- `docker top <container-id>`: 列出指定容器的程序
- `docker logs <container-id>`: 顯示容器的日誌檔內容
- `docker inspect <container-id>`: 顯示容器的詳細完整資訊
- `docker stats <container-id>`: 顯示容器使用系統資源狀況
- `docker cp <source-path> <target-path>`: 透過容器 ID 也可以將檔案複製進容器內，ex: `docker cp index.html fbe:/usr/local/apache2/htdocs/index.html`
- `docker commit <container-name> <new-image-name>`: 以容器建立新的映像檔
- `docker inspect <container-name>`: 檢視容器詳細資訊
  - `--format '{{.Mounts}}'`: 僅列出掛載 Volume
- `docker exec <container-name> <command>`: 在容器內執行指令
- `docker volume`: 進行 Volume 相關的指令操作
  - `ls`: 列出所有 Volume
  - `create <volume-name>`: 建立 Volume

## Docker Compose

- `docker compose up`: 建立 Compose
  - `-f`: 指定 docker compose 檔案
  - `-d`, `--detach`: 於背景中執行
  - `--scale <component-name>=<count>`: 擴展應用程式元件
- `docker compose start`: 執行 Compose
- `docker compose stop`: 停止 Compose
- `docker compose down`: 卸除 Compose
- `docker compose logs`: 顯示每個容器的日誌
  - `--tail=`: 顯示最後幾筆日誌
  - `<component-name>`: 指定某元件的日誌
- `docker run --rm -it --name dcv -v ${PWD}:/input pmsipilot/docker-compose-viz render -m image docker-compose.yml --output-file=docker-compose.png --force`: 可以利用 pmsipilot/docker-compose-viz 將 compose.yml 圖示化

## Docker Compose File

- `version: '<version-name>'`: compose 版本
- `services`: 組成應用程式的所有元件
  - `<component>`: 命名元件名稱
    - `image`: 元件的映像檔
    - `restart: <on-failure>`: 重啟情況
    - `ports`: 連接的埠號
    - `environment`: 環境變數
    - `depends_on`: 相依於其他的容器
    - `networks`: 列出 service 可以加入的 Docker 虛擬網路
    - `secrets tartget`: 讀取的 secret 訊息
    - `healthcheck`: 狀態檢查
      - `test`: 狀態檢查命令
      - `interval`: 時間區間
      - `timeout`: 允許檢查時間
      - `retries`: 允許連續失敗次數
      - `start_period`: 檢查前的等待時間
- `secrets`: 從本機讀檔做 secret 設定

## Prometheus

收集容器指標數據

## Grafana

依賴 Prometheus 呈現多樣儀表板

## minikube

可執行單ㄧ節點的叢集環境，適用於 kubernetes 學習

- `minikube start`: 啟動叢集
- `minikube stop`: 停止叢集
- `minikube delete`: 刪除叢集

## Kubernetes

- `kubectl get all`: 檢視所有物件
- `kubectl get componentstatuses`: 檢查叢集整體健康狀態
- `kubectl get nodes`: 列出叢集中的 nodes
- `kubectl get daemonSets --namespace=kube-system kube-proxy`: 查看正在運行的 proxy
- `kubectl get deployments --namespace=kube-system coredns`: 查看正在運行的 DNS
- `kubectl get services --namespace=kube-system kube-dns`: 查看為 DNS 提供負載平衡的服務
- `kubectl describe <resource-name> <obj-name>`: 觀察特定物件的更多資訊
- `kubectl apply -f <yaml>`: 建立物件
- `kubectl delete -f <yaml>`: 刪除 yaml 部署物件
- `kubectl delete <resource-name>/<pod-name>`: 刪除物件
- `kubectl logs <pod-name>`: 查詢容器中的日誌
  - `-f`: 串流 log 不斷出
  - `--previous`: 從前一個執行個體中取得日誌
- `kubectl exec <pod-name> -- <command>`: 在容器內執行指令
- `kubectl exec -it <pod-name> -- ash`: 執行互動式工作階段
- `kubectl attach -it <pod-name>`: 連接進正在執行的程序
- `kubectl cp <pod-name>:</path/to/remote/file> </path/to/local/file>`: 複製檔案
- `kubectl get events`: 列出目前 namespace 近 10 筆發生的事件
  - `--watch`: 串流事件
- `kubectl cordan`: 讓後續的 Pod 不再安排到此節點
- `kubectl uncordan`: 重新讓 Pod 安排到此節點上
- `kubectl drain`: 移除此節點中的 Pod
- `kubectl port-forward <pod-name> <external-port>:<internal-port>`: 轉發連結埠
