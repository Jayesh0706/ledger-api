FROM maven:3.9-eclipse-temurin-17 as builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn package -DskipTests -B


FROM eclipse-temurin:17-jre
RUN groupadd -r spring && useradd -r -g spring spring
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
RUN chown spring:spring /app
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
USER spring
EXPOSE 8080
ENV JAVA_OPTS="XX:MaxRAMPercentage=75.0"
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]