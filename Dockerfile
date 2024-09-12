# Usa una imagen base de Tomcat y Java
FROM tomcat:9.0-jdk11-openjdk

# Copia el contenido de tu proyecto al directorio webapps de Tomcat
COPY ./ /usr/local/tomcat/webapps/

# Exponer el puerto 8080 para acceder a la aplicación
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["catalina.sh", "run"]
