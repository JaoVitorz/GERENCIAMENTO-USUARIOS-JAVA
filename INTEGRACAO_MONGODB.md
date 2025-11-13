# Integração com MongoDB Atlas - Coleção Users

## ✅ Integração Concluída

O projeto Java Spring Boot foi configurado para integrar com a coleção `users` do MongoDB Atlas, que é a mesma coleção usada pelo backend Node.js e frontend Next.js.

## 🔧 Alterações Realizadas

### 1. Modelo Usuario.java
- **Coleção alterada**: De `usuarios` para `users`
- **Mapeamento de campos**: Adicionadas anotações `@Field` para mapear campos Java (português) para campos MongoDB (inglês):
  - `nome` → `name`
  - `email` → `email`
  - `senha` → `password`
  - `telefone` → `phone`
  - `endereco` → `address`
  - `dataCadastro` → `createdAt`
  - `ativo` → `active`

### 2. Tipo de Dados
- **Data**: Alterado de `LocalDateTime` para `Date` para compatibilidade com MongoDB
- **Status ativo**: Alterado para `Boolean` para melhor compatibilidade

### 3. Template HTML
- Atualizado para usar `#dates.format()` em vez de `#temporals.format()` para exibir datas

### 4. Serviço
- Adicionada validação para garantir que `dataCadastro` e `ativo` sejam definidos ao cadastrar

## 📋 Estrutura do Modelo

O modelo Java agora está sincronizado com a estrutura esperada no MongoDB:

```java
{
  "_id": "ObjectId",
  "name": "String",
  "email": "String",
  "password": "String",
  "phone": "String (opcional)",
  "address": "String (opcional)",
  "tipo": "String (adotante, ong, veterinario)",
  "cpf": "String (opcional - para adotante e veterinário)",
  "cnpj": "String (opcional - para ONG)",
  "crmv": "String (opcional - para veterinário)",
  "createdAt": "Date",
  "active": "Boolean"
}
```

### Tipos de Usuário

O sistema suporta 3 tipos de cadastro:

1. **Adotante** (`tipo: "adotante"`)
   - Campos obrigatórios: nome, email, senha, CPF
   
2. **ONG** (`tipo: "ong"`)
   - Campos obrigatórios: nome, email, senha, CNPJ
   
3. **Veterinário** (`tipo: "veterinario"`)
   - Campos obrigatórios: nome, email, senha, CPF, CRMV

## 🔄 Como Funciona

1. **Usuários cadastrados no frontend Next.js** são salvos na coleção `users` do MongoDB Atlas
2. **O projeto Java** agora lê da mesma coleção `users`
3. **Todos os usuários** aparecem no gerenciador de usuários do Java

## ⚠️ Observações Importantes

### Senhas
- O sistema atual compara senhas em texto plano
- Se o backend Node.js usa hash (BCrypt), será necessário ajustar a lógica de login
- **Recomendação**: Implementar hash de senhas no Java também para segurança

### Campos Opcionais
- Campos como `phone`, `address` podem não existir em todos os documentos
- O modelo Java trata esses campos como opcionais (nullable)

### Data de Cadastro
- Se o backend Node.js não definir `createdAt`, o Java definirá automaticamente ao salvar
- Datas existentes no MongoDB serão preservadas

## 🚀 Próximos Passos

1. **Testar a integração**: Execute o projeto e verifique se os usuários aparecem
2. **Verificar estrutura**: Confirme que os campos no MongoDB correspondem ao mapeamento
3. **Ajustar se necessário**: Se houver campos adicionais no Node.js, adicione ao modelo Java

## 🔍 Verificação

Para verificar se a integração está funcionando:

1. Acesse: `http://localhost:8080/usuarios/listar`
2. Verifique se os usuários cadastrados no frontend aparecem na lista
3. Se não aparecerem, verifique:
   - Conexão com MongoDB Atlas
   - Nome dos campos no MongoDB (podem estar em português ou inglês)
   - Estrutura dos documentos na coleção `users`

## ⚙️ Ajuste de Campos (Se Necessário)

Se os campos no MongoDB estiverem em **português** (nome, email, senha) em vez de inglês (name, email, password), você precisa ajustar as anotações `@Field` no modelo `Usuario.java`:

### Campos em Português no MongoDB:
```java
@Field("nome")      // em vez de @Field("name")
@Field("email")     // mantém igual
@Field("senha")     // em vez de @Field("password")
@Field("telefone")  // em vez de @Field("phone")
@Field("endereco")  // em vez de @Field("address")
@Field("dataCadastro") // em vez de @Field("createdAt")
@Field("ativo")     // em vez de @Field("active")
```

### Como Verificar:
1. Acesse o MongoDB Atlas
2. Navegue até a coleção `users`
3. Veja um documento de exemplo
4. Compare os nomes dos campos com as anotações `@Field` no modelo Java
5. Ajuste conforme necessário

## 📝 Notas Técnicas

- O Spring Data MongoDB usa as anotações `@Field` para mapear automaticamente
- O método `findByEmail()` busca pelo campo `email` no MongoDB
- A coleção `users` é criada automaticamente se não existir
- O banco de dados configurado é `petjoyful` (ver `application.properties`)

