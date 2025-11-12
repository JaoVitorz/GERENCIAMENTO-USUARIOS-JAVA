# 🔧 Solução Manual - Java não funciona

Se o script não funcionou, configure manualmente:

## ✅ Método 1: Interface Gráfica (100% Funcional)

### Passo a Passo:

1. **Abra as Variáveis de Ambiente:**
   - Pressione `Win + R`
   - Digite: `sysdm.cpl`
   - Pressione Enter
   - Clique na aba **"Avançado"**
   - Clique em **"Variáveis de Ambiente"**

2. **Configurar JAVA_HOME:**
   - Em **"Variáveis do usuário"**, clique em **"Novo"**
   - Nome da variável: `JAVA_HOME`
   - Valor da variável: `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot`
   - Clique em **"OK"**

3. **Adicionar ao PATH:**
   - Em **"Variáveis do usuário"**, encontre **"Path"**
   - Clique em **"Editar"**
   - Clique em **"Novo"**
   - Adicione: `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin`
   - Clique em **"OK"** em todas as janelas

4. **Fechar e Reabrir:**
   - Feche TODAS as janelas do PowerShell/CMD
   - Abra um NOVO PowerShell
   - Teste: `java -version`

---

## ✅ Método 2: PowerShell como Administrador

1. **Abra o PowerShell como Administrador:**
   - Clique com botão direito no PowerShell
   - Selecione **"Executar como administrador"**

2. **Execute estes comandos:**

```powershell
# Configurar JAVA_HOME
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot", "User")

# Adicionar ao PATH
$javaBin = "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin"
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$javaBin;$currentPath"
[System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")

Write-Host "Configurado! Feche e reabra o PowerShell." -ForegroundColor Green
```

3. **Fechar e Reabrir o PowerShell**

---

## ✅ Método 3: Reiniciar o Computador

Às vezes o Windows precisa reiniciar para aplicar as mudanças:

1. Configure o PATH (usando Método 1 ou 2)
2. **Reinicie o computador**
3. Teste: `java -version`

---

## 🔍 Verificar se Está Configurado

Execute no PowerShell:

```powershell
# Ver JAVA_HOME
echo $env:JAVA_HOME

# Ver PATH (procurar por Java)
$env:Path -split ';' | Select-String "Java|Eclipse|Adoptium"

# Testar Java
java -version
```

---

## ❓ Se Ainda Não Funcionar

1. **Execute o diagnóstico:**
   ```powershell
   .\diagnostico-completo.ps1
   ```

2. **Verifique se o Java está realmente instalado:**
   - Abra o Explorador de Arquivos
   - Vá para: `C:\Program Files\Eclipse Adoptium`
   - Veja se existe a pasta `jdk-25.0.1.8-hotspot`

3. **Reinstale o Java:**
   - Desinstale o Java atual
   - Baixe novamente: https://adoptium.net/
   - Durante a instalação, marque **"Add to PATH"**

---

## 💡 Dica Importante

**SEMPRE feche e reabra o PowerShell após configurar o PATH!**

O PowerShell carrega as variáveis de ambiente quando inicia. Se você não fechar e reabrir, ele continuará usando as variáveis antigas.

