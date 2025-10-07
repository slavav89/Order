package com.order.furniture.billboards.order_furniture_billboards.repository;


import com.order.furniture.billboards.order_furniture_billboards.entity.Order;
import com.order.furniture.billboards.order_furniture_billboards.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByClient(User client);
}
