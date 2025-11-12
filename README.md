# 🐾 Pet Joyful - Backend Spring Boot

Sistema de gerenciamento de usuários para a plataforma Pet Joyful, desenvolvido com Spring Boot e MongoDB.

## 🚀 Tecnologias Utilizadas

- **Java 17**
- **Spring Boot 3.2.0**
- **Spring Data MongoDB**
- **Thymeleaf** (para templates HTML)
- **Bootstrap 5** (para interface)
- **MongoDB**

## 📋 Pré-requisitos

Antes de executar o projeto, certifique-se de ter instalado:

- **Java 17** ou superior
- **Maven 3.6+**
- **MongoDB** (local ou remoto)

## 🛠️ Instalação e Configuração

### 1. Clonar o repositório

```bash
git clone https://github.com/JaoVitorz/Pet-Joyful---Projeto-Integrador--NextJs.git
cd "tela java"
```

### 2. Configurar MongoDB

#### Opção 1: MongoDB Local

1. Instale o MongoDB em sua máquina
2. Inicie o serviço do MongoDB
3. O MongoDB estará disponível em `mongodb://localhost:27017`

#### Opção 2: MongoDB Atlas (Cloud)

1. Crie uma conta no [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Crie um cluster gratuito
3. Obtenha a string de conexão
4. Atualize o arquivo `application.properties` com sua string de conexão

### 3. Configurar a conexão do MongoDB

Edite o arquivo `src/main/resources/application.properties`:

```properties
# Para MongoDB local
spring.data.mongodb.uri=mongodb://localhost:27017/petjoyful

# Para MongoDB Atlas (exemplo)
# spring.data.mongodb.uri=mongodb+srv://usuario:senha@cluster.mongodb.net/petjoyful
```

### 4. Compilar o projeto

**Opção A: Usando Maven Wrapper (Recomendado - não precisa instalar Maven)**
```bash
.\mvnw.cmd clean install
```

**Opção B: Se você tem Maven instalado**
```bash
mvn clean install
```

### 5. Executar o projeto

**Opção A: Usando Maven Wrapper**
```bash
.\mvnw.cmd spring-boot:run
```

**Opção B: Se você tem Maven instalado**
```bash
mvn spring-boot:run
```

> **Nota:** Se você receber o erro "mvn não é reconhecido", use o Maven Wrapper (Opção A) ou consulte o arquivo `INSTALAR_MAVEN.md` para instruções de instalação do Maven.

Ou execute diretamente a classe `PetJoyfulApplication.java`

## 🌐 Acessar a aplicação

Após iniciar o servidor, acesse:

- **Página de Login**: http://localhost:8080/usuarios/login
- **Página de Cadastro**: http://localhost:8080/usuarios/cadastro
- **Lista de Usuários**: http://localhost:8080/usuarios/listar

## 📡 API REST

O projeto também oferece endpoints REST para integração:

### Listar todos os usuários
```
GET http://localhost:8080/usuarios/api
```

### Buscar usuário por ID
```
GET http://localhost:8080/usuarios/api/{id}
```

### Cadastrar novo usuário
```
POST http://localhost:8080/usuarios/api
Content-Type: application/json

{
  "nome": "João Silva",
  "email": "joao@email.com",
  "senha": "123456",
  "telefone": "(11) 99999-9999",
  "endereco": "Rua Exemplo, 123"
}
```

### Login
```
POST http://localhost:8080/usuarios/api/login
Content-Type: application/json

{
  "email": "joao@email.com",
  "senha": "123456"
}
```

## 📁 Estrutura do Projeto

```
src/
├── main/
│   ├── java/
│   │   └── com/petjoyful/
│   │       ├── PetJoyfulApplication.java
│   │       ├── controller/
│   │       │   ├── UsuarioController.java
│   │       │   └── HomeController.java
│   │       ├── model/
│   │       │   └── Usuario.java
│   │       ├── repository/
│   │       │   └── UsuarioRepository.java
│   │       ├── service/
│   │       │   └── UsuarioService.java
│   │       └── dto/
│   │           └── LoginDTO.java
│   └── resources/
│       ├── application.properties
│       └── templates/
│           ├── login.html
│           ├── cadastro.html
│           ├── listar-usuarios.html
│           └── editar-usuario.html
└── pom.xml
```

## 🔐 Funcionalidades

- ✅ **Cadastro de Usuários**: Criação de novos usuários com validação
- ✅ **Login**: Autenticação de usuários
- ✅ **Listagem**: Visualização de todos os usuários cadastrados
- ✅ **Edição**: Atualização de dados do usuário
- ✅ **Exclusão**: Remoção de usuários do sistema
- ✅ **Validação**: Validação de campos obrigatórios e formato de email
- ✅ **Interface Web**: Interface moderna e responsiva com Bootstrap

## 📝 Notas Importantes

- As senhas são armazenadas em texto plano (não recomendado para produção)
- Para produção, considere usar **BCrypt** ou similar para hash de senhas
- O MongoDB cria automaticamente a coleção `usuarios` quando o primeiro registro é inserido
- A porta padrão do servidor é **8080** (pode ser alterada no `application.properties`)

## 🔒 Melhorias Futuras

- [ ] Implementar hash de senhas com BCrypt
- [ ] Adicionar autenticação JWT
- [ ] Implementar roles/permissões de usuário
- [ ] Adicionar paginação na listagem
- [ ] Implementar busca e filtros
- [ ] Adicionar testes unitários e de integração

## 👥 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

## 📄 Licença

Este projeto é parte do Projeto Integrador da Fatec.

# GERENCIAMENTO-USUARIOS-JAVA
