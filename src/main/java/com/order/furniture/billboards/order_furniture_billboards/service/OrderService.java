package com.order.furniture.billboards.order_furniture_billboards.service;

import com.order.furniture.billboards.order_furniture_billboards.entity.Order;
import com.order.furniture.billboards.order_furniture_billboards.entity.User;
import com.order.furniture.billboards.order_furniture_billboards.repository.OrderRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Управляет всеми операциями, связанными с заказами.
 * Сервис обрабатывает бизнес-правила,
 * и делегирует хранение данных репозиторию.
 */
@Service
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository){
        this.orderRepository = orderRepository;
    }

    /**
     * Метод для создания нового заказа
     */
    public Order createOrder(Order order){
        return orderRepository.save(order);
    }

    /**
     * Метод получения заказов по клиенту
     */
    public List<Order> getOrdersByClient(User client){
        return orderRepository.findByClient(client);
    }

    /**
     * Метод получения всех заказов с сортировкой по ID в обратном порядке
     */
    public List<Order> getAllOrders() {
        List<Order> listAllOrders = orderRepository.findAll();
        listAllOrders.sort((o1, o2)-> Integer.compare(o2.getId(), o1.getId()));
        return listAllOrders;
    }

    /**
     * Метод поиска заказа по ID
     */
    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }

    /**
     * Метод сохранения изменений
     */
    public Order saveOrder(Order order){
        return orderRepository.save(order);
    }
}