FROM maven:3.5.3-jdk-10-slim as build

WORKDIR /app
COPY pom.xml .
COPY src src
RUN mvn package -q -Dmaven.test.skip=true

FROM openjdk:10.0.1-10-jre-slim

WORKDIR /app
EXPOSE 8080
ENV STORE_ENABLED=true
ENV WORKER_ENABLED=true
COPY --from=build /app/target/elc-service-0.0.2-SNAPSHOT.jar /app

CMD ["java", "-jar", "elc-service-0.0.2-SNAPSHOT.jar"]