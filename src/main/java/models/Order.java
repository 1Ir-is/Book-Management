package models;

import java.util.Date;

public class Order {
    private int id;
    private Date buyDate;
    private String status;
    private User customer;

    public Order() {
    }

    public Order(int id, Date buyDate, String status, User customer) {
        this.id = id;
        this.buyDate = buyDate;
        this.status = status;
        this.customer = customer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }
}

