# 🔧 Como Adicionar Java ao PATH no Windows

## ✅ Método 1: Via Interface Gráfica (Mais Fácil)

### Passo a Passo:

1. **Abra as Variáveis de Ambiente:**
   - Pressione `Win + R` (tecla Windows + R)
   - Digite: `sysdm.cpl`
   - Pressione Enter
   - OU: Pesquise "variáveis de ambiente" no menu Iniciar

2. **Acesse as Variáveis:**
   - Na janela que abrir, clique na aba **"Avançado"**
   - Clique no botão **"Variáveis de Ambiente"**

3. **Editar o PATH:**
   - Na seção **"Variáveis do usuário"** (ou "Variáveis do sistema"), encontre a variável **"Path"**
   - Clique em **"Editar"**

4. **Adicionar o Java:**
   - Clique em **"Novo"**
   - Adicione o caminho: `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin`
     (ou o caminho onde seu Java foi instalado)
   - **Importante:** O caminho deve terminar com `\bin`
   - Clique em **"OK"**

5. **Configurar JAVA_HOME (Opcional mas Recomendado):**
   - Na mesma janela de "Variáveis de Ambiente", clique em **"Novo"** (em "Variáveis do usuário")
   - Nome da variável: `JAVA_HOME`
   - Valor da variável: `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot`
     (o mesmo caminho, mas SEM o `\bin`)
   - Clique em **"OK"**

6. **Aplicar as Mudanças:**
   - Clique em **"OK"** em todas as janelas abertas

7. **Reiniciar o Terminal:**
   - **FECHE completamente** o PowerShell/CMD
   - Abra um novo PowerShell/CMD
   - Teste: `java -version`

---

## ✅ Método 2: Via PowerShell (Rápido)

### Encontrar o Caminho do Java Primeiro:

```powershell
# Procurar Java instalado
Get-ChildItem "C:\Program Files\Eclipse Adoptium" -ErrorAction SilentlyContinue
Get-ChildItem "C:\Program Files\Java" -ErrorAction SilentlyContinue
```

### Adicionar ao PATH:

```powershell
# Substitua pelo caminho real do seu Java
$javaBinPath = "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin"

# Obter PATH atual
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")

# Verificar se já está no PATH
if ($currentPath -notlike "*$javaBinPath*") {
    # Adicionar ao PATH
    $newPath = "$javaBinPath;$currentPath"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "[OK] Java adicionado ao PATH!" -ForegroundColor Green
} else {
    Write-Host "[INFO] Java ja esta no PATH" -ForegroundColor Yellow
}

# Configurar JAVA_HOME
$javaHome = "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot"
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "User")
Write-Host "[OK] JAVA_HOME configurado!" -ForegroundColor Green

Write-Host ""
Write-Host "IMPORTANTE: Feche e reabra o PowerShell!" -ForegroundColor Yellow
```

---

## 🔍 Como Encontrar o Caminho do Java

### Se você acabou de instalar o Eclipse Temurin:

O caminho geralmente é:
```
C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin
```

### Para encontrar o caminho exato:

1. **Abra o Explorador de Arquivos**
2. Vá para: `C:\Program Files\Eclipse Adoptium`
3. Procure por uma pasta como `jdk-25.0.1.8-hotspot` ou similar
4. Dentro dela, deve haver uma pasta `bin`
5. O caminho completo será: `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin`

### Ou use o PowerShell:

```powershell
# Procurar Java
Get-ChildItem "C:\Program Files\Eclipse Adoptium" -Directory | Select-Object FullName
```

---

## ✅ Verificar se Funcionou

Após adicionar ao PATH e **fechar/reabrir o PowerShell**:

```powershell
# Verificar Java
java -version

# Verificar JAVA_HOME
echo $env:JAVA_HOME

# Verificar se está no PATH
$env:Path -split ';' | Select-String "Java\|Eclipse"
```

Se tudo funcionar, você verá:
- A versão do Java
- O caminho do JAVA_HOME
- O Java listado no PATH

---

## 🚨 Problemas Comuns

### "Java ainda não funciona após adicionar ao PATH"

**Soluções:**
1. ✅ **Fechou e reabriu o PowerShell?** (Muito importante!)
2. ✅ Verifique se o caminho está correto (deve terminar com `\bin`)
3. ✅ Reinicie o computador se ainda não funcionar
4. ✅ Verifique se adicionou em "Variáveis do usuário" ou "Variáveis do sistema"

### "Não encontro a pasta do Java"

**Soluções:**
1. Verifique em: `C:\Program Files\Eclipse Adoptium`
2. Verifique em: `C:\Program Files\Java`
3. Use o script: `.\encontrar-java.ps1`

### "Erro de permissão ao adicionar ao PATH"

**Soluções:**
1. Execute o PowerShell como Administrador
2. Ou adicione em "Variáveis do usuário" (não precisa de admin)

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

## 🎯 Depois de Configurar

Execute o projeto Spring Boot:

```powershell
.\mvnw.cmd spring-boot:run
```

A aplicação estará disponível em: **http://localhost:8080/usuarios/login**

