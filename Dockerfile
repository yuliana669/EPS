# Usa una imagen base de Ubuntu para mayor flexibilidad
FROM ubuntu:22.04

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y wget curl unzip

# Instalar Java JDK 22
RUN wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.tar.gz && \
    tar -xvzf jdk-22_linux-x64_bin.tar.gz && \
    mv jdk-22 /usr/local/ && \
    rm jdk-22_linux-x64_bin.tar.gz

# Establecer las variables de entorno para Java
ENV JAVA_HOME=/usr/local/jdk-22
ENV PATH=$JAVA_HOME/bin:$PATH

# Descargar e instalar Tomcat 9.0.94
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.94/bin/apache-tomcat-9.0.94.tar.gz && \
    tar -xvzf apache-tomcat-9.0.95.tar.gz && \
    mv apache-tomcat-9.0.95 /usr/local/tomcat && \
    rm apache-tomcat-9.0.95.tar.gz

# Copia tu proyecto al directorio de webapps de Tomcat
COPY ./ /usr/local/tomcat/webapps/

# Exponer el puerto 8080
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
