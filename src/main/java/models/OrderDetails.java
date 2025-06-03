package models;

public class OrderDetails {
    private int id;
    private int quantity;
    private double price;
    private Order order;
    private Book book;

    public OrderDetails() {
    }

    public OrderDetails(int id, int quantity, double price, Order order, Book book) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.order = order;
        this.book = book;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}
