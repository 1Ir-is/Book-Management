package models;

import jdk.vm.ci.meta.Local;

import java.time.LocalDate;
import java.util.Date;

public class Order {
  private int orderId;
  private int userId;
  private LocalDate orderDate;
  private String status;

    public Order() {
    }

    public Order(int orderId, int userId, LocalDate orderDate, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

