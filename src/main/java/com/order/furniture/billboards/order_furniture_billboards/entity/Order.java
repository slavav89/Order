package com.order.furniture.billboards.order_furniture_billboards.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "orders")
public class Order {

    public enum Status {
        PENDING, APPROVED, REJECTED, IN_PROGRESS, COMPLETED
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id")
    private int id;

    @Column(name="description")
    private String description;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User client;

    @Enumerated(EnumType.STRING)
    @Column(name="status")
    private Status status = Status.PENDING;

    public Order() {

    }

    public Order(int id, String description, User client, Status status) {
        this.id = id;
        this.description = description;
        this.client = client;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getClient() {
        return client;
    }

    public void setClient(User client) {
        this.client = client;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}