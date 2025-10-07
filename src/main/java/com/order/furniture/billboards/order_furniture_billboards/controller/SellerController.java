package com.order.furniture.billboards.order_furniture_billboards.controller;


import com.order.furniture.billboards.order_furniture_billboards.entity.Order;
import com.order.furniture.billboards.order_furniture_billboards.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * брабатывает запросы продавца
 */
@Controller
@RequestMapping("/seller")
public class SellerController {

    private final OrderService orderService;

    public SellerController(OrderService orderService){
        this.orderService = orderService;
    }

    @GetMapping("/orders")
    public String listAllOrders(Model model){
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "seller/orders";
    }

    @GetMapping("/orders/{id}")
    public String viewOrder(@PathVariable Long id, Model model){
        Order order = orderService.getOrderById(id).orElseThrow();
        model.addAttribute("order", order);
        return "seller/order_detail";
    }

    @PostMapping("/orders/{id}/status")
    public String updateOrderStatus(@PathVariable Long id,
                                    @RequestParam("status") Order.Status status){
        Order order = orderService.getOrderById(id).orElseThrow();
        order.setStatus(status);
        orderService.saveOrder(order);
        return "redirect:/seller/orders";
    }
}