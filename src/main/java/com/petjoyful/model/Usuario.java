package com.petjoyful.model;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;

/**
 * Modelo de Usuário integrado com a coleção "users" do MongoDB Atlas.
 * Este modelo está sincronizado com o backend Node.js e frontend Next.js.
 * 
 * Suporta 3 tipos de usuário:
 * - Adotante: requer CPF
 * - ONG: requer CNPJ
 * - Veterinário: requer CPF e CRMV
 * 
 * IMPORTANTE: Se os campos no MongoDB estiverem em português (nome, email, senha),
 * altere as anotações @Field para usar os nomes em português.
 * Exemplo: @Field("nome") em vez de @Field("name")
 */
@Document(collection = "users")
public class Usuario {

    @Id
    private String id;

    @NotBlank(message = "Nome é obrigatório")
    @Size(min = 3, max = 100, message = "Nome deve ter entre 3 e 100 caracteres")
    @Field("name") // Se no MongoDB estiver como "nome", altere para @Field("nome")
    private String nome;

    @NotBlank(message = "Email é obrigatório")
    @Email(message = "Email deve ser válido")
    @Field("email")
    private String email;

    @NotBlank(message = "Senha é obrigatória")
    @Size(min = 6, message = "Senha deve ter no mínimo 6 caracteres")
    @Field("password")
    private String senha;

    @Field("phone")
    private String telefone;
    
    @Field("address")
    private String endereco;
    
    // Tipo de usuário: "adotante", "ong", "veterinario"
    @Field("tipo")
    private String tipo;
    
    // CPF - usado por adotante e veterinário
    @Field("cpf")
    private String cpf;
    
    // CNPJ - usado por ONG
    @Field("cnpj")
    private String cnpj;
    
    // CRMV - usado por veterinário
    @Field("crmv")
    private String crmv;
    
    @Field("createdAt")
    private Date dataCadastro;
    
    @Field("active")
    private Boolean ativo;

    // Construtores
    public Usuario() {
        this.dataCadastro = new Date();
        this.ativo = true;
    }

    public Usuario(String nome, String email, String senha) {
        this();
        this.nome = nome;
        this.email = email;
        this.senha = senha;
    }

    // Getters e Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public Date getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(Date dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

    public Boolean isAtivo() {
        return ativo != null ? ativo : true;
    }

    public Boolean getAtivo() {
        return ativo != null ? ativo : true;
    }

    public void setAtivo(Boolean ativo) {
        this.ativo = ativo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getCrmv() {
        return crmv;
    }

    public void setCrmv(String crmv) {
        this.crmv = crmv;
    }
}

