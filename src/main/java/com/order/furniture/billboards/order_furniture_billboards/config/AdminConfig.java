package com.order.furniture.billboards.order_furniture_billboards.config;

import com.order.furniture.billboards.order_furniture_billboards.entity.User;
import com.order.furniture.billboards.order_furniture_billboards.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Отвечает за инициализацию данных при запуске приложения.
 * Основная ответственность — создание пользователя-администратора (с ролью SELLER)
 * в базе данных, если он отсутствует;
 */
@Configuration
public class AdminConfig {

    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";

    @Bean
    public CommandLineRunner createAdminUser(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        return args -> {
            boolean adminExists = userRepository.findByUsername(ADMIN_USERNAME).isPresent();
            if (!adminExists) {
                User admin = new User();
                admin.setUsername(ADMIN_USERNAME);
                admin.setPassword(passwordEncoder.encode(ADMIN_PASSWORD));
                admin.setRole(User.Role.SELLER);
                userRepository.save(admin);
                System.out.println("Admin user created: username = " + ADMIN_USERNAME +
                        ", password = " + ADMIN_PASSWORD);
            } else {
                System.out.println("Admin user already exists");
            }
        };
    }
}