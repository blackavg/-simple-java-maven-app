FROM maven AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM registry.access.redhat.com/ubi8/openjdk-17:1.17-4
WORKDIR /app
COPY --from=build /home/app/target/prueba-tecnica-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8077
CMD ["java","-jar","app.jar"]
