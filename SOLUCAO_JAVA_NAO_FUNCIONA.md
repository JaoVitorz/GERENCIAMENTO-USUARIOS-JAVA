# 🔧 Java -version não funciona - Solução

## Problema

O comando `java -version` não funciona, mesmo após instalar o JDK.

## ✅ Solução Passo a Passo

### 1. Encontrar onde o Java foi instalado

Execute o script:

```powershell
.\encontrar-java.ps1
```

Ou procure manualmente:

- Abra o Explorador de Arquivos
- Vá para: `C:\Program Files\Java`
- Ou: `C:\Program Files\Eclipse Adoptium`
- Procure por pastas como `jdk-25`, `jdk-21`, etc.

### 2. Adicionar Java ao PATH

Depois de encontrar o Java, você precisa adicionar ao PATH:

#### Opção A: Via Interface Gráfica (Mais Fácil)

1. **Abra as Variáveis de Ambiente:**

   - Pressione `Win + R`
   - Digite: `sysdm.cpl` e pressione Enter
   - Vá na aba **"Avançado"**
   - Clique em **"Variáveis de Ambiente"**

2. **Editar o PATH:**

   - Em **"Variáveis do usuário"** (ou "Variáveis do sistema"), encontre **"Path"**
   - Clique em **"Editar"**
   - Clique em **"Novo"**
   - Adicione o caminho: `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin`
     (substitua pelo caminho real do seu Java)
   - Clique em **"OK"** em todas as janelas

3. **Configurar JAVA_HOME (opcional mas recomendado):**
   - Clique em **"Novo"** nas variáveis do usuário
   - Nome: `JAVA_HOME`
   - Valor: `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot` (sem o \bin)
   - Clique em **"OK"**

#### Opção B: Via PowerShell (Rápido)

Execute no PowerShell (substitua pelo caminho real do seu Java):

```powershell
# Adicionar ao PATH
$javaBinPath = "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin"
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$javaBinPath;$currentPath"
[System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")

# Configurar JAVA_HOME
$javaHome = "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot"
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "User")
```

### 3. Fechar e Reabrir o PowerShell

**MUITO IMPORTANTE:** Feche completamente o PowerShell e abra um novo.

### 4. Verificar se funcionou

```powershell
java -version
echo $env:JAVA_HOME
```

Se mostrar a versão do Java, está funcionando! ✅

### 5. Executar o projeto

```powershell
.\mvnw.cmd spring-boot:run
```

---

## 🔄 Se ainda não funcionar

### Reinstalar o Java corretamente:

1. **Desinstale o Java atual** (se houver)
2. **Baixe novamente:**

   - Acesse: https://adoptium.net/
   - Baixe o **JDK 25** ou superior (JDK 17+ também funciona)
   - Escolha a versão **Windows x64** (.msi)

3. **Durante a instalação:**

   - ✅ Marque **"Add to PATH"** ou **"Set JAVA_HOME variable"**
   - ✅ Marque **"Associate .jar files"** (opcional)

4. **Após instalar:**
   - Feche e reabra o PowerShell
   - Teste: `java -version`

---

## 📝 Exemplo Completo

Se o Java estiver em `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot`:

**PATH deve conter:**

```
C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin
```

**JAVA_HOME deve ser:**

```
C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot
```

---

## ❓ Ainda com problemas?

1. Verifique se o Java está realmente instalado
2. Certifique-se de que adicionou o caminho **\bin** ao PATH
3. Reinicie o computador após configurar
4. Tente executar `.\encontrar-java.ps1` para diagnóstico
