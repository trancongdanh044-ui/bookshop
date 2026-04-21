package model;

import java.util.List;

public class Cart {
    private int id;
    private User user;
    private List<CartItem> items;

    public Cart() {}

    public Cart(int id, User user, List<CartItem> items) {
        this.id = id;
        this.user = user;
        this.items = items;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    
}