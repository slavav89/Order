package com.order.furniture.billboards.order_furniture_billboards.repository;

import com.order.furniture.billboards.order_furniture_billboards.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
}