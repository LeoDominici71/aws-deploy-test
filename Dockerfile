# Etapa 1: Construção da aplicação
FROM maven:3.8.5-openjdk-17-slim AS builder

# Definir o diretório de trabalho no container
WORKDIR /app

# Copiar o arquivo pom.xml e baixar as dependências do Maven
COPY pom.xml ./
RUN mvn dependency:go-offline -B

# Copiar o código-fonte da aplicação
COPY src ./src

# Construir o artefato do Spring Boot
RUN mvn clean package -DskipTests

# Etapa 2: Criar a imagem final
FROM openjdk:17-jdk-slim

# Criar um diretório para a aplicação
WORKDIR /app

# Copiar o arquivo JAR gerado na etapa anterior
COPY --from=builder /app/target/management-0.0.1-SNAPSHOT.jar management.jar

# Expor a porta que a aplicação irá usar
EXPOSE 8080

# Comando para executar o JAR
ENTRYPOINT ["java", "-jar", "management.jar"]
