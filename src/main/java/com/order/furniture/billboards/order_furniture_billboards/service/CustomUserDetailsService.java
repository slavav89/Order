package com.order.furniture.billboards.order_furniture_billboards.service;

import com.order.furniture.billboards.order_furniture_billboards.repository.UserRepository;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;


/**
 * Реализует интерфейс UserDetailsService из Spring Security.
 * Основная ответственность — загрузка данных пользователя по имени для аутентификации.
 */
@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    /**
     * Ищет пользователя в репозитории и выбрасывает исключение
     * UsernameNotFoundException, если пользователь не найден. Это обеспечивает интеграцию
     * с механизмом аутентификации, позволяя системе проверять учетные данные при входе;
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));
    }
}