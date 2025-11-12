# ☕ Como Configurar JAVA_HOME no Windows

## 🚨 Problema: "JAVA_HOME not found in your environment"

Este erro significa que o Java não está configurado corretamente no Windows.

---

## ✅ Solução Rápida (3 Passos)

### Passo 1: Verificar se o Java está instalado

Abra o PowerShell e execute:

```powershell
java -version
```

**Se funcionar:** Você verá a versão do Java. Pule para o Passo 2.

**Se NÃO funcionar:** Você precisa instalar o Java primeiro:
1. Acesse: https://adoptium.net/
2. Baixe o **JDK 17** ou superior (versão LTS recomendada)
3. Execute o instalador
4. Durante a instalação, marque a opção "Add to PATH" se disponível

---

### Passo 2: Encontrar o caminho do Java

Execute o script de verificação:

```powershell
.\verificar-java.ps1
```

Este script vai:
- Verificar se o Java está instalado
- Procurar instalações do Java no seu computador
- Sugerir o caminho correto para JAVA_HOME

**Ou encontre manualmente:**

Os locais mais comuns são:
- `C:\Program Files\Java\jdk-17`
- `C:\Program Files\Java\jdk-21`
- `C:\Program Files\Eclipse Adoptium\jdk-17.0.9+9`
- `C:\Program Files\Eclipse Adoptium\jdk-21.0.1+12`

**Importante:** O caminho deve apontar para a **pasta do JDK**, não para a pasta `bin`!

---

### Passo 3: Configurar JAVA_HOME

#### Opção A: Usando o Script Automático (Recomendado)

```powershell
.\configurar-java-home.ps1
```

O script vai pedir o caminho do Java. Cole o caminho encontrado no Passo 2.

**Para configurar para todos os usuários (recomendado):**
1. Clique com botão direito no PowerShell
2. Selecione "Executar como administrador"
3. Execute: `.\configurar-java-home.ps1`

#### Opção B: Configurar Manualmente

1. **Abra as Variáveis de Ambiente:**
   - Pressione `Win + R`
   - Digite: `sysdm.cpl` e pressione Enter
   - Vá na aba **"Avançado"**
   - Clique em **"Variáveis de Ambiente"**

2. **Criar/Editar JAVA_HOME:**
   - Em **"Variáveis do sistema"** (ou "Variáveis do usuário"), clique em **"Novo"**
   - Nome da variável: `JAVA_HOME`
   - Valor da variável: Cole o caminho do Java (ex: `C:\Program Files\Java\jdk-17`)
   - Clique em **"OK"**

3. **Adicionar ao PATH (se ainda não estiver):**
   - Selecione a variável **"Path"**
   - Clique em **"Editar"**
   - Clique em **"Novo"**
   - Adicione: `%JAVA_HOME%\bin`
   - Clique em **"OK"** em todas as janelas

---

## ✅ Verificar se Funcionou

1. **Feche e reabra o PowerShell/CMD** (importante!)

2. Execute:
```powershell
java -version
echo $env:JAVA_HOME
```

3. Você deve ver:
   - A versão do Java
   - O caminho do JAVA_HOME

4. Agora tente executar o projeto:
```powershell
.\mvnw.cmd spring-boot:run
```

---

## 🔧 Solução de Problemas

### "Java não encontrado"
- Instale o Java: https://adoptium.net/
- Certifique-se de marcar "Add to PATH" durante a instalação

### "JAVA_HOME não funciona após configurar"
- **Feche e reabra o terminal** (muito importante!)
- Se ainda não funcionar, **reinicie o computador**
- Verifique se o caminho está correto (deve apontar para a pasta do JDK, não para `bin`)

### "Acesso negado ao configurar variáveis"
- Execute o PowerShell como Administrador
- Ou configure apenas para o usuário atual (Variáveis do usuário)

### "Não encontro o Java instalado"
- Verifique em: `C:\Program Files\Java`
- Verifique em: `C:\Program Files\Eclipse Adoptium`
- Use o script `verificar-java.ps1` para procurar automaticamente

---

## 📝 Exemplo Completo

Se o Java estiver em `C:\Program Files\Java\jdk-17`:

1. **JAVA_HOME** = `C:\Program Files\Java\jdk-17`
2. **PATH** deve conter = `%JAVA_HOME%\bin` (ou `C:\Program Files\Java\jdk-17\bin`)

---

## 🆘 Ainda com Problemas?

1. Verifique se o Java está realmente instalado
2. Certifique-se de que o caminho está correto (sem espaços ou caracteres especiais)
3. Reinicie o computador após configurar
4. Tente executar o script `verificar-java.ps1` para diagnóstico

---

**Depois de configurar, você poderá executar:**
```powershell
.\mvnw.cmd spring-boot:run
```

E a aplicação estará disponível em: **http://localhost:8080/usuarios/login**

