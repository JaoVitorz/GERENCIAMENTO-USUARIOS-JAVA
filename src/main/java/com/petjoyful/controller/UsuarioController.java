package com.petjoyful.controller;

import com.petjoyful.dto.LoginDTO;
import com.petjoyful.model.Usuario;
import com.petjoyful.service.UsuarioService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    // Página de login
    @GetMapping("/login")
    public String paginaLogin(Model model) {
        model.addAttribute("loginDTO", new LoginDTO());
        return "login";
    }

    // Processar login
    @PostMapping("/login")
    public String processarLogin(@Valid @ModelAttribute LoginDTO loginDTO, 
                                 BindingResult result, 
                                 RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "login";
        }

        try {
            Usuario usuario = usuarioService.login(loginDTO);
            redirectAttributes.addFlashAttribute("mensagem", "Login realizado com sucesso!");
            redirectAttributes.addFlashAttribute("usuarioLogado", usuario);
            return "redirect:/usuarios/listar";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("erro", e.getMessage());
            return "redirect:/usuarios/login";
        }
    }

    // Página de cadastro
    @GetMapping("/cadastro")
    public String paginaCadastro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "cadastro";
    }

    // Processar cadastro
    @PostMapping("/cadastro")
    public String processarCadastro(@Valid @ModelAttribute Usuario usuario, 
                                    BindingResult result, 
                                    RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "cadastro";
        }

        try {
            usuarioService.cadastrar(usuario);
            redirectAttributes.addFlashAttribute("mensagem", "Cadastro realizado com sucesso! Faça login para continuar.");
            return "redirect:/usuarios/login";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("erro", e.getMessage());
            return "redirect:/usuarios/cadastro";
        }
    }

    // Listar todos os usuários
    @GetMapping("/listar")
    public String listarUsuarios(Model model) {
        List<Usuario> usuarios = usuarioService.listarTodos();
        model.addAttribute("usuarios", usuarios);
        return "listar-usuarios";
    }

    // Página de edição
    @GetMapping("/editar/{id}")
    public String paginaEditar(@PathVariable String id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Usuario usuario = usuarioService.buscarPorId(id)
                    .orElseThrow(() -> new RuntimeException("Usuário não encontrado!"));
            model.addAttribute("usuario", usuario);
            return "editar-usuario";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("erro", e.getMessage());
            return "redirect:/usuarios/listar";
        }
    }

    // Processar edição
    @PostMapping("/editar/{id}")
    public String processarEdicao(@PathVariable String id, 
                                  @Valid @ModelAttribute Usuario usuario, 
                                  BindingResult result, 
                                  RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "editar-usuario";
        }

        try {
            usuarioService.atualizar(id, usuario);
            redirectAttributes.addFlashAttribute("mensagem", "Usuário atualizado com sucesso!");
            return "redirect:/usuarios/listar";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("erro", e.getMessage());
            return "redirect:/usuarios/editar/" + id;
        }
    }

    // Deletar usuário
    @GetMapping("/deletar/{id}")
    public String deletarUsuario(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
            usuarioService.deletar(id);
            redirectAttributes.addFlashAttribute("mensagem", "Usuário deletado com sucesso!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("erro", e.getMessage());
        }
        return "redirect:/usuarios/listar";
    }

    // API REST - Listar todos (JSON)
    @GetMapping("/api")
    @ResponseBody
    public ResponseEntity<List<Usuario>> listarTodosAPI() {
        return ResponseEntity.ok(usuarioService.listarTodos());
    }

    // API REST - Buscar por ID (JSON)
    @GetMapping("/api/{id}")
    @ResponseBody
    public ResponseEntity<Usuario> buscarPorIdAPI(@PathVariable String id) {
        return usuarioService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // API REST - Cadastrar (JSON)
    @PostMapping("/api")
    @ResponseBody
    public ResponseEntity<?> cadastrarAPI(@Valid @RequestBody Usuario usuario) {
        try {
            Usuario usuarioSalvo = usuarioService.cadastrar(usuario);
            return ResponseEntity.status(HttpStatus.CREATED).body(usuarioSalvo);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body("{\"erro\": \"" + e.getMessage() + "\"}");
        }
    }

    // API REST - Login (JSON)
    @PostMapping("/api/login")
    @ResponseBody
    public ResponseEntity<?> loginAPI(@Valid @RequestBody LoginDTO loginDTO) {
        try {
            Usuario usuario = usuarioService.login(loginDTO);
            return ResponseEntity.ok(usuario);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("{\"erro\": \"" + e.getMessage() + "\"}");
        }
    }
}

