# docker-phper


## 介绍

个人使用的docker开发环境，持续添加常用组件，镜像精简。
## 常用命令
#### 运行所有:

```bash
docker-compose up -d
```

运行 NGINX 或 MySQL 或 PHP:

```bash
docker-compose up -d  nginx / mysql / php-fpm
```

#### 进入 Workspace 容器

```bash
docker-compose exec workspace /bin/bash
```
退出容器, `exit`.

#### 查看容器
```bash
docker-compose ps
```

#### 查看容器IP地址等信息

```bash
docker inspect {容器id} | grep IPAddress
```

#### 关闭所有容器

```bash
docker-compose stop
```

#### 停止某个容器:

```bash
docker-compose stop {容器名称}
```

#### 删除所有容器，包括网络、容器、共享卷

```bash
docker-compose down
```

#### 建立/重建容器

```bash
docker-compose build
```
指定哪个容器重建(而不是重建所有的容器):

```bash
docker-compose build {container-name}
```

重建整个容器，可以需要使用 `--no-cache` 选项  (`docker-compose build --no-cache {container-name}`).