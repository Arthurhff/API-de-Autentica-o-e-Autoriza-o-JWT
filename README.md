
# API JWT com Spring Boot

API REST de autenticação e autorização baseada em JWT (JSON Web Token), desenvolvida com Spring Boot. Possui endpoints protegidos por papéis (admin/user), documentação com Swagger, monitoramento com Spring Boot Actuator e Prometheus, e suporte a deploy com Docker.

## Tecnologias Utilizadas

- Java 17  
- Spring Boot 3.5.3  
- Spring Security  
- Spring Data JPA  
- H2 Database  
- JWT  
- Swagger / OpenAPI  
- Spring Boot Actuator  
- Prometheus  
- Docker  

## Pré-requisitos

- Java 17 instalado  
- Maven (ou o wrapper `mvnw`)  
- Docker instalado  

## Compilação do Projeto

### Linux / Mac

```bash
./mvnw clean package
```

### Windows

```cmd
mvnw.cmd clean package
```

O arquivo `.jar` será gerado no diretório `target/`.

## Executando com Docker

### 1. Dockerfile

Crie um arquivo `Dockerfile` na raiz do projeto com o seguinte conteúdo:

```dockerfile
FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

### 2. Build da imagem

```bash
docker build -t apijwt .
```

### 3. Executando o container

```bash
docker run -p 8080:8080 apijwt
```

Acesse a aplicação em `http://localhost:8080`

## Endpoints Principais

| Método | Endpoint               | Descrição                          | Acesso     |
|--------|------------------------|------------------------------------|------------|
| POST   | `/auth/login`          | Autentica e retorna um JWT         | Público    |
| POST   | `/auth/register`       | Cadastra um novo usuário           | Público    |
| GET    | `/auth/users`          | Lista os usuários cadastrados      | ADMIN      |
| DELETE | `/auth/users/{id}`     | Remove um usuário pelo ID          | ADMIN      |
| GET    | `/protected`           | Endpoint protegido para testes     | USER/ADMIN |
| GET    | `/actuator/health`     | Verificação de status              | Público    |
| GET    | `/actuator/prometheus` | Exposição de métricas Prometheus   | Público    |

## Swagger

Acesse: `http://localhost:8080/swagger-ui.html`

### Autenticação

1. Faça um POST em `/auth/login` com:

```json
{
  "username": "admin",
  "password": "123"
}
```

2. Copie o token JWT retornado.
3. No Swagger, clique em "Authorize" e insira:

```
Bearer SEU_TOKEN
```

## H2 Database

- URL: `http://localhost:8080/h2-console`  
- JDBC URL: `jdbc:h2:file:./src/main/resources/db/bancoDeDados`  
- Usuário: `sa`  
- Senha: (em branco)

## Usuários Criados (via DataInitializer)

| Usuário | Senha | Papel       |
|---------|-------|-------------|
| admin   | 123   | ROLE_ADMIN  |
| user    | 123   | ROLE_USER   |

## Monitoramento

- Status da API: `http://localhost:8080/actuator/health`  
- Métricas Prometheus: `http://localhost:8080/actuator/prometheus`

## Autor

**Arthur Fernandes**  
Projeto acadêmico com foco em autenticação com JWT, segurança com Spring Security, métricas com Prometheus e deploy com Docker.
