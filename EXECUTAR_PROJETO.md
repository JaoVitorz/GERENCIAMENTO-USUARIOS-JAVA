# 🚀 Como Executar o Projeto Spring Boot

Agora que o Java está funcionando, vamos executar o projeto!

## ✅ Passo a Passo

### 1. Verificar se o MongoDB está rodando

O projeto precisa do MongoDB. Você tem duas opções:

#### Opção A: MongoDB Local
- Instale o MongoDB: https://www.mongodb.com/try/download/community
- Inicie o serviço do MongoDB
- O MongoDB estará em: `mongodb://localhost:27017`

#### Opção B: MongoDB Atlas (Cloud - Gratuito)
- Crie uma conta: https://www.mongodb.com/cloud/atlas
- Crie um cluster gratuito
- Obtenha a string de conexão
- Edite `src/main/resources/application.properties` com sua string de conexão

### 2. Configurar o MongoDB

Edite o arquivo: `src/main/resources/application.properties`

**Para MongoDB Local:**
```properties
spring.data.mongodb.uri=mongodb://localhost:27017/petjoyful
```

**Para MongoDB Atlas:**
```properties
spring.data.mongodb.uri=mongodb+srv://usuario:senha@cluster.mongodb.net/petjoyful
```

### 3. Executar o Projeto

No PowerShell, execute:

```powershell
# Compilar o projeto
.\mvnw.cmd clean install

# Executar o projeto
.\mvnw.cmd spring-boot:run
```

### 4. Acessar a Aplicação

Após iniciar, acesse no navegador:

- **Login:** http://localhost:8080/usuarios/login
- **Cadastro:** http://localhost:8080/usuarios/cadastro
- **Lista de Usuários:** http://localhost:8080/usuarios/listar

---

## 🎯 Comandos Rápidos

```powershell
# 1. Verificar Java
java -version

# 2. Compilar
.\mvnw.cmd clean install

# 3. Executar
.\mvnw.cmd spring-boot:run
```

---

## ✅ Pronto!

Agora você pode:
- ✅ Cadastrar usuários
- ✅ Fazer login
- ✅ Ver lista de usuários (CRUD)
- ✅ Editar usuários
- ✅ Deletar usuários

Tudo será salvo no MongoDB! 🎉

