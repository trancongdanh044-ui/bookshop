package model;

public class Book {
    private int id;
    private String title;
    private String author;
    private String description;
    private double price;
    private double discount;
    private int quantity;
    private String image;
    private Category category;

    public Book() {}

    public Book(int id, String title, String author, String description,
                double price, double discount, int quantity, String image, Category category) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.quantity = quantity;
        this.image = image;
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getFinalPrice() {
        return Math.max(0, price - discount);
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    
}
