package models;

import java.util.Date;

public class Cart {
    private int cartId;
    private int userId;
    private Date dateCreate;

    public Cart() {
    }

    public Cart(int cartId, int userId, Date dateCreate) {
        this.cartId = cartId;
        this.userId = userId;
        this.dateCreate = dateCreate;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Date dateCreate) {
        this.dateCreate = dateCreate;
    }
}
