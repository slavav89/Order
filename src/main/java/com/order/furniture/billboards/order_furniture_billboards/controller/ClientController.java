package com.order.furniture.billboards.order_furniture_billboards.controller;


import com.order.furniture.billboards.order_furniture_billboards.entity.Order;
import com.order.furniture.billboards.order_furniture_billboards.entity.User;
import com.order.furniture.billboards.order_furniture_billboards.repository.UserRepository;
import com.order.furniture.billboards.order_furniture_billboards.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
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
@Tag(name = "Client API", description = "API для управления заказами клиента")
public class ClientController {

    private final OrderService orderService;
    private final UserRepository userRepository;

    public ClientController(OrderService orderService, UserRepository userRepository) {
        this.orderService = orderService;
        this.userRepository = userRepository;
    }

    @GetMapping("/orders")
    @Operation(summary = "Получить страницу с заказами клиента")
    public String listOrders(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        User client = userRepository.findByUsername(userDetails.getUsername()).orElseThrow();
        List<Order> orders = orderService.getOrdersByClient(client);
        model.addAttribute("orders", orders);
        return "client/order";
    }

    @GetMapping("/orders/new")
    @Operation(summary = "Получить форму создания нового заказа")
    public String newOrderForm(Model model) {
        model.addAttribute("order", new Order());
        return "client/new_order";
    }

    @PostMapping("/orders")
    @Operation(summary = "Создать новый заказ")
    public String createOrder(@AuthenticationPrincipal UserDetails userDetails,
                              @ModelAttribute Order order) {
        User client = userRepository.findByUsername(userDetails.getUsername()).orElseThrow();
        order.setClient(client);
        order.setStatus(Order.Status.PENDING);
        orderService.createOrder(order);
        return "redirect:/client/orders";
    }

    // JSON API endpoints
    @GetMapping("/api/orders")
    @Operation(summary = "Получить список заказов клиента в формате JSON")
    @ResponseBody
    public List<Order> getOrdersJson(@AuthenticationPrincipal UserDetails userDetails) {
        User client = userRepository.findByUsername(userDetails.getUsername()).orElseThrow();
        return orderService.getOrdersByClient(client);
    }

    @PostMapping("/api/orders")
    @Operation(summary = "Создать новый заказ через JSON API")
    @ResponseBody
    public Order createOrderJson(@AuthenticationPrincipal UserDetails userDetails,
                                 @RequestBody Order order) {
        User client = userRepository.findByUsername(userDetails.getUsername()).orElseThrow();
        order.setClient(client);
        order.setStatus(Order.Status.PENDING);
        return orderService.createOrder(order);
    }

}