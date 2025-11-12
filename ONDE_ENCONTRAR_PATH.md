# 🔍 Onde Encontrar o PATH no Windows

## ✅ Método 1: Via Interface Gráfica (Mais Fácil)

### Passo a Passo Visual:

#### 1. Abrir as Variáveis de Ambiente

**Opção A:**
- Pressione `Win + R` (tecla Windows + R)
- Digite: `sysdm.cpl`
- Pressione Enter

**Opção B:**
- Clique com botão direito em "Este Computador" ou "Meu Computador"
- Selecione "Propriedades"
- Clique em "Configurações avançadas do sistema"

**Opção C:**
- Pesquise "variáveis de ambiente" no menu Iniciar
- Clique em "Editar as variáveis de ambiente do sistema"

#### 2. Acessar as Variáveis

Na janela que abrir:
1. Clique na aba **"Avançado"**
2. Clique no botão **"Variáveis de Ambiente"** (no canto inferior direito)

#### 3. Encontrar o PATH

Você verá duas seções:

**Variáveis do usuário** (apenas para você)
- Procure por **"Path"** ou **"PATH"** na lista
- Clique para selecionar
- Clique em **"Editar"**

**Variáveis do sistema** (para todos os usuários)
- Procure por **"Path"** ou **"PATH"** na lista
- Clique para selecionar
- Clique em **"Editar"**

> **Dica:** Geralmente é melhor editar em "Variáveis do usuário" se você não for administrador.

#### 4. Visualizar o PATH

Ao clicar em "Editar", você verá uma lista com todos os caminhos do PATH, um por linha.

---

## ✅ Método 2: Via PowerShell (Rápido)

### Ver o PATH Atual:

```powershell
# Ver todo o PATH em uma linha
echo $env:Path

# Ver cada pasta do PATH em uma linha separada (mais legível)
$env:Path -split ';'
```

### Editar o PATH via PowerShell:

```powershell
# Ver PATH atual do usuário
[System.Environment]::GetEnvironmentVariable("Path", "User")

# Adicionar novo caminho ao PATH
$newPath = "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin"
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
$updatedPath = "$newPath;$currentPath"
[System.Environment]::SetEnvironmentVariable("Path", $updatedPath, "User")
```

---

## 📍 Localização Física do PATH

O PATH é armazenado no Registro do Windows:

**PATH do Usuário:**
```
HKEY_CURRENT_USER\Environment\Path
```

**PATH do Sistema:**
```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path
```

> **⚠️ Atenção:** Não edite o registro diretamente! Use a interface gráfica ou PowerShell.

---

## 🎯 Onde Você Vai Encontrar o PATH

### Na Interface Gráfica:

```
Painel de Controle
  └─ Sistema
      └─ Configurações avançadas do sistema
          └─ Variáveis de Ambiente
              └─ Path (em "Variáveis do usuário" ou "Variáveis do sistema")
```

### Caminho Rápido:

1. `Win + R` → `sysdm.cpl` → Enter
2. Aba "Avançado"
3. Botão "Variáveis de Ambiente"
4. Procure "Path" na lista
5. Clique em "Editar"

---

## 🔧 Como Editar o PATH

### Adicionar Novo Caminho:

1. Abra o PATH (seguindo os passos acima)
2. Clique em **"Novo"**
3. Cole ou digite o caminho: `C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin`
4. Clique em **"OK"**
5. Clique em **"OK"** em todas as janelas abertas

### Remover Caminho:

1. Abra o PATH
2. Selecione o caminho que deseja remover
3. Clique em **"Excluir"**
4. Clique em **"OK"**

### Editar Caminho Existente:

1. Abra o PATH
2. Selecione o caminho que deseja editar
3. Clique em **"Editar"**
4. Modifique o caminho
5. Clique em **"OK"**

---

## 📸 Visualização do PATH

Quando você abrir o PATH, verá algo assim:

```
C:\Windows\system32
C:\Windows
C:\Windows\System32\Wbem
C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin
C:\Users\João\AppData\Local\Programs\Microsoft VS Code\bin
```

Cada linha é um caminho diferente onde o Windows procura programas.

---

## ✅ Verificar se Funcionou

Após adicionar ao PATH:

1. **FECHE completamente o PowerShell/CMD**
2. Abra um novo PowerShell
3. Teste:
   ```powershell
   java -version
   ```

Se funcionar, o PATH está configurado corretamente! ✅

---

## 🚨 Problemas Comuns

### "Não encontro a variável Path"

- Verifique se está procurando em "Variáveis do usuário" E "Variáveis do sistema"
- A variável pode estar escrita como "PATH" (maiúsculas) ou "Path" (primeira letra maiúscula)

### "Não consigo editar"

- Tente editar em "Variáveis do usuário" (não precisa de admin)
- Ou execute o PowerShell como Administrador

### "Mudanças não funcionam"

- **FECHE e REABRA o terminal** (muito importante!)
- Se ainda não funcionar, reinicie o computador

---

## 💡 Dica Rápida

**Atalho mais rápido:**
1. `Win + R`
2. Digite: `sysdm.cpl`
3. Enter
4. Aba "Avançado" → "Variáveis de Ambiente"
5. Procure "Path" → "Editar"

Pronto! Você encontrou o PATH! 🎯

