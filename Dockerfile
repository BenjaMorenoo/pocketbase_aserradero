# Usamos la imagen base de Linux ligera
FROM alpine:3.18

# Instalar utilidades básicas
RUN apk add --no-cache bash curl unzip

# Descargar PocketBase Linux 64-bit
ENV PB_VERSION=0.14.3
RUN curl -L https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip -o /pocketbase.zip \
    && unzip /pocketbase.zip -d / \
    && chmod +x /pocketbase \
    && rm /pocketbase.zip

# Puerto que usa PocketBase
EXPOSE 8090

# Directorio de datos persistentes
VOLUME ["/pb_data"]

# Comando para iniciar PocketBase
CMD ["/pocketbase", "serve", "--http", "0.0.0.0:8090", "--dir", "/pb_data"]
