# Use official Maven image to build the application
FROM maven:3.8.8-amazoncorretto-17 AS build

# Set working directory inside container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use OpenJDK image to run the application
FROM amazoncorretto:17

# Set working directory for runtime
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
