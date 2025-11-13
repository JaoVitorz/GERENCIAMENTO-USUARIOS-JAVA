package com.petjoyful.service;

import com.petjoyful.dto.LoginDTO;
import com.petjoyful.model.Usuario;
import com.petjoyful.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public Usuario cadastrar(Usuario usuario) {
        // Verifica se o email já existe
        if (usuarioRepository.existsByEmail(usuario.getEmail())) {
            throw new RuntimeException("Email já cadastrado!");
        }
        // Garante que a data de cadastro seja definida
        if (usuario.getDataCadastro() == null) {
            usuario.setDataCadastro(new java.util.Date());
        }
        // Garante que o status ativo seja definido
        if (usuario.getAtivo() == null) {
            usuario.setAtivo(true);
        }
        return usuarioRepository.save(usuario);
    }

    public Usuario login(LoginDTO loginDTO) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByEmail(loginDTO.getEmail());
        
        if (usuarioOpt.isEmpty()) {
            throw new RuntimeException("Email ou senha inválidos!");
        }

        Usuario usuario = usuarioOpt.get();
        
        if (!usuario.getSenha().equals(loginDTO.getSenha())) {
            throw new RuntimeException("Email ou senha inválidos!");
        }

        if (!usuario.isAtivo()) {
            throw new RuntimeException("Usuário inativo!");
        }

        return usuario;
    }

    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }

    public Optional<Usuario> buscarPorId(String id) {
        return usuarioRepository.findById(id);
    }

    public Usuario atualizar(String id, Usuario usuarioAtualizado) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado!"));

        // Verifica se o email está sendo alterado e se já existe
        if (!usuario.getEmail().equals(usuarioAtualizado.getEmail()) 
                && usuarioRepository.existsByEmail(usuarioAtualizado.getEmail())) {
            throw new RuntimeException("Email já cadastrado!");
        }

        usuario.setNome(usuarioAtualizado.getNome());
        usuario.setEmail(usuarioAtualizado.getEmail());
        usuario.setTelefone(usuarioAtualizado.getTelefone());
        usuario.setEndereco(usuarioAtualizado.getEndereco());
        usuario.setTipo(usuarioAtualizado.getTipo());
        usuario.setCpf(usuarioAtualizado.getCpf());
        usuario.setCnpj(usuarioAtualizado.getCnpj());
        usuario.setCrmv(usuarioAtualizado.getCrmv());
        
        if (usuarioAtualizado.getSenha() != null && !usuarioAtualizado.getSenha().isEmpty()) {
            usuario.setSenha(usuarioAtualizado.getSenha());
        }

        return usuarioRepository.save(usuario);
    }

    public void deletar(String id) {
        if (!usuarioRepository.existsById(id)) {
            throw new RuntimeException("Usuário não encontrado!");
        }
        usuarioRepository.deleteById(id);
    }
}

