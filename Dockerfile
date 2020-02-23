FROM maven:3.6.1-jdk-8-slim as build
COPY . .
RUN mvn test
#CMD ["mvn test"]

#FROM openjdk:8-jre-alpine
#COPY --from=build /app/target/spring-petclinic-1.5.1.jar /app
#CMD ["mvn test"]