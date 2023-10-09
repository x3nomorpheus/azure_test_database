FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y mariadb-server

EXPOSE 3306

LABEL version="1.0"
LABEL description="MariaDB Server"

HEALTHCHECK --start-period=5m \
  CMD mariadb -e 'SELECT @@datadir;' || exit 1

RUN mkdir -p /run/mysqld/ && chown -R mysql:mysql /run/mysqld
RUN sed -i s/127.0.0.1/0.0.0.0/g /etc/mysql/mariadb.conf.d/50-server.cnf

USER mysql
CMD ["mariadbd", "--user=mysql"]

