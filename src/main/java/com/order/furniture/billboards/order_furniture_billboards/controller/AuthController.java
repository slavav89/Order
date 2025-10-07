package com.order.furniture.billboards.order_furniture_billboards.controller;


import com.order.furniture.billboards.order_furniture_billboards.entity.User;
import com.order.furniture.billboards.order_furniture_billboards.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;

/**
 * Управляет процессами аутентификации и регистрации пользователей
 */
@Controller
public class AuthController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AuthController(UserRepository userRepository, PasswordEncoder passwordEncoder){
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String registerForm(Model model){
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user, Model model){
        if(userRepository.findByUsername(user.getUsername()).isPresent()){
            model.addAttribute("error",
                    "Пользователь с таким именем уже существует");
            return "register";
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(User.Role.CLIENT);
        userRepository.save(user);
        return "redirect:/login";
    }

    @GetMapping("/home")
    public String defaultAfterLogin(@AuthenticationPrincipal User user) {
        if (user == null) {
            return "redirect:/login";
        }
        if(user.getRole() == User.Role.SELLER){
            return "redirect:/seller/orders";
        } else {
            return "redirect:/client/orders";
        }
    }
}