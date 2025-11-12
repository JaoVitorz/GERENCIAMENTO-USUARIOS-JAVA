# 🔧 Como Resolver o Erro "mvn não é reconhecido"

Você tem **3 opções** para resolver este problema:

## ✅ Opção 1: Usar o Maven Wrapper (RECOMENDADO - Mais Fácil)

Agora o projeto tem o Maven Wrapper! Use os seguintes comandos:

### Windows (PowerShell ou CMD):
```bash
.\mvnw.cmd clean install
.\mvnw.cmd spring-boot:run
```

### Se der erro de permissão:
```powershell
# No PowerShell, execute:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## ✅ Opção 2: Instalar o Maven no Windows

### Passo 1: Verificar se o Java está instalado
```bash
java -version
```

Se não estiver instalado, baixe o [JDK 17 ou superior](https://adoptium.net/).

### Passo 2: Baixar o Maven
1. Acesse: https://maven.apache.org/download.cgi
2. Baixe o arquivo **apache-maven-3.9.5-bin.zip** (ou versão mais recente)

### Passo 3: Extrair o Maven
1. Extraia o arquivo ZIP para `C:\Program Files\Apache\maven` (ou outro local de sua preferência)
2. Exemplo: `C:\Program Files\Apache\maven\apache-maven-3.9.5`

### Passo 4: Configurar Variáveis de Ambiente

1. **Abra as Variáveis de Ambiente:**
   - Pressione `Win + R`
   - Digite `sysdm.cpl` e pressione Enter
   - Vá na aba **"Avançado"**
   - Clique em **"Variáveis de Ambiente"**

2. **Criar variável MAVEN_HOME:**
   - Em **"Variáveis do sistema"**, clique em **"Novo"**
   - Nome: `MAVEN_HOME`
   - Valor: `C:\Program Files\Apache\maven\apache-maven-3.9.5` (ajuste para seu caminho)

3. **Adicionar ao PATH:**
   - Selecione a variável **"Path"** nas variáveis do sistema
   - Clique em **"Editar"**
   - Clique em **"Novo"**
   - Adicione: `%MAVEN_HOME%\bin`
   - Clique em **"OK"** em todas as janelas

4. **Reiniciar o Terminal:**
   - Feche e abra um novo PowerShell/CMD
   - Teste com: `mvn -version`

---

## ✅ Opção 3: Usar uma IDE (IntelliJ, Eclipse, VS Code)

As IDEs geralmente já têm Maven integrado:

### IntelliJ IDEA / Eclipse:
- Abra o projeto
- Execute a classe `PetJoyfulApplication.java` diretamente
- Ou use o botão "Run" da IDE

### VS Code:
- Instale a extensão "Extension Pack for Java"
- O Maven será gerenciado automaticamente

---

## 🚀 Após Instalar, Execute:

```bash
# Compilar o projeto
mvn clean install

# Executar a aplicação
mvn spring-boot:run
```

A aplicação estará disponível em: **http://localhost:8080/usuarios/login**

---

## ❓ Precisa de Ajuda?

Se ainda tiver problemas, verifique:
- ✅ Java está instalado? (`java -version`)
- ✅ Variáveis de ambiente estão configuradas?
- ✅ Terminal foi reiniciado após configurar as variáveis?

