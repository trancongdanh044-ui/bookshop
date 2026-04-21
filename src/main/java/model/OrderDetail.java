package model;

public class OrderDetail {
    private int id;
    private int orderId;
    private Orders order;
    private Book book;
    private int quantity;
    private double price;

    public OrderDetail() {}

    public OrderDetail(int id, Orders order, Book book, int quantity, double price) {
        this.id = id;
        this.order = order;
        this.book = book;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Orders getOrder() {
        return order;
    }

    public void setOrder(Orders order) {
        this.order = order;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
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

    
}