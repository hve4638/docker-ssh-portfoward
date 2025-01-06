# Dockerfile
FROM alpine:latest

RUN apk add --no-cache openssh && \
	ssh-keygen -A

RUN echo -e "Port 22						\n\
PermitRootLogin no							\n\
PasswordAuthentication no					\n\
PubkeyAuthentication yes					\n\
ChallengeResponseAuthentication no			\n\
PermitTunnel yes							\n\
AllowTcpForwarding remote					\n\
AllowStreamLocalForwarding yes				\n\
X11Forwarding no							\n\
PermitTTY no								\n\
AuthorizedKeysFile  /home/sshonly/.ssh/authorized_keys	\n\
" > /etc/ssh/sshd_config

RUN adduser -D --home /home/sshonly -s /bin/sh sshonly && \
	echo sshonly:cd836633d9a6c61fdc9055c10fc438f406f1b4eeecd9306eda41b2685880b76e | chpasswd

COPY entrypoint.sh /entrypoint.sh

RUN mkdir /home/sshonly/.ssh && \
	chown sshonly:sshonly /home/sshonly/.ssh && \
	chmod 700 /home/sshonly/.ssh && \
	chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 22