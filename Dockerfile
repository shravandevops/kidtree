# Use a base image with Java pre-installed
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the host into the container
COPY java-demo-1.0.jar /app/java-demo-1.0.jar

# Command to run the Java application inside the container
CMD ["java", "-jar", "java-demo-1.0.jar"]

