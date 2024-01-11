FROM openjdk:11
WORKDIR /app/superapp
COPY target/*.jar .
CMD ["java", "-jar", "superapp.jar"]