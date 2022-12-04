# syntax=docker/dockerfile:1

FROM eclipse-temurin:17-jdk-jammy AS builder 

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src ./src
RUN ./mvnw package

FROM eclipse-temurin:17-jdk-jammy 
WORKDIR /app
COPY --from=builder /app/target ./target/
CMD java -jar target/*.jar 