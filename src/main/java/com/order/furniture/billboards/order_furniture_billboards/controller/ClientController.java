package com.order.furniture.billboards.order_furniture_billboards.controller;


import com.order.furniture.billboards.order_furniture_billboards.entity.Order;
import com.order.furniture.billboards.order_furniture_billboards.entity.User;
import com.order.furniture.billboards.order_furniture_billboards.repository.UserRepository;
import com.order.furniture.billboards.order_furniture_billboards.service.OrderService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Обрабатывает запросы на просмотр, создание и управление заказами клиента.
 */
@Controller
@RequestMapping("/client")
public class ClientController {

    private final OrderService orderService;
    private final UserRepository userRepository;

    public ClientController(OrderService orderService, UserRepository userRepository) {
        this.orderService = orderService;
        this.userRepository = userRepository;
    }

    @GetMapping("/orders")
    public String listOrders(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        User client = userRepository.findByUsername(userDetails.getUsername()).orElseThrow();
        List<Order> orders = orderService.getOrdersByClient(client);
        model.addAttribute("orders", orders);
        return "client/order";
    }

    @GetMapping("/orders/new")
    public String newOrderForm(Model model) {
        model.addAttribute("order", new Order());
        return "client/new_order";
    }

    @PostMapping("/orders")
    public String createOrder(@AuthenticationPrincipal UserDetails userDetails,
                              @ModelAttribute Order order) {
        User client = userRepository.findByUsername(userDetails.getUsername()).orElseThrow();
        order.setClient(client);
        order.setStatus(Order.Status.PENDING);
        orderService.createOrder(order);
        return "redirect:/client/orders";
    }

}