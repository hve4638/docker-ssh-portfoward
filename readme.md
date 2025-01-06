# docker-ssh-portforward


## 사전 설정

```yml
# docker-compose.yml
ports:
    - "<포트>:22"
```

`docker-compose.yml`에서 외부에 노출할 포트를 변경

## 유의점

### 호스트키 

```dockerfile
# Dockerfile

RUN apk add --no-cache openssh && \
	ssh-keygen -A
```

Dockerfile 내에서 호스트키를 생성하며, 이는 이미지를 한번 빌드하면 동일한 호스트키를 공유하므로 클라이언트 측에서도 동일한 known_ssh로 기록하게 됩니다.

여러 컨테이너를 사용한다면 이미지를 공유해 사용해서는 안됩니다. 호스트 키를 변경하려면 이미지를 삭제 후 재빌드해야 합니다. 단순 재빌드 시 증분 빌드(incremental build)로 인해 제대로 실행되지 않을 수 있습니다.

## 사용

1. Docker 설치
```bash
curl -sSL get.docker.com | sh
```

2. docker-compose 설치
```bash
sudo apt-get install docker-compose-plugin
```

3. 저장소 클론
```bash
git clone https://github.com/hve4638/docker-ssh-portfoward.git
```

4. 컨테이너 실행

```bash
cd docker-ssh-portfoward
docker-compose up
```

5. 개인키 보관

`./vol/ssh/id_rsa` 파일을 

## SSH 터널링

```bash
ssh -Nf -R <PORT_FROM>:localhost:<PORT_TO> sshonly@<ADDR> -p <EXPOSE_PORT> -i /PATH/TO/id_rsa
```

- `PORT_FROM` : 터널링 될 서버 포트
- `PORT_TO` : 연결할 포트
- `ADDR` : 터널링 서버 포트
- `EXPOSE_PORT` : 터널링 서버 주소

*WIP*