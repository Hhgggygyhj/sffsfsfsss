# Utiliza una imagen base que soporte systemd, por ejemplo, Ubuntu
FROM xilixmeaty41/ubuntu:20.04 as base

# Instala los paquetes necesarios
RUN apt-get update \
    && apt-get install -y shellinabox systemd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo 'root:root' | chpasswd

# Expone todos los puertos del 0 al 65535
EXPOSE 0-65535

# Crea un usuario no root para ejecutar el servicio
RUN useradd -ms /bin/bash shellinaboxuser

# Inicia shellinabox como el usuario no root
USER shellinaboxuser
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
