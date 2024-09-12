


FROM wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.tar.gz && \
    tar -xvzf jdk-22_linux-x64_bin.tar.gz && \
    mv jdk-22 /usr/local/ && \
    rm jdk-22_linux-x64_bin.tar.gz
ENV JAVA_HOME=/usr/local/jdk-22

COPY ./ /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

