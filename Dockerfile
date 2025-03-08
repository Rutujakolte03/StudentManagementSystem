# Use Maven image to build the project
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy all project files
COPY . .

# Build the JAR file
RUN mvn clean package -DskipTests

# Use OpenJDK for running the app
FROM openjdk:17
WORKDIR /app

# Copy the built JAR from the previous step
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
