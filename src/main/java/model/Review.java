package model;

public class Review {
    private int reviewID;
    private int customerID;
    private int bookID;
    private int rating;
    private String comment;
    private User user;
    private Book book;

    public Review() {}

    public Review(int reviewID, int customerID, int bookID, int rating, String comment) {
        this.reviewID = reviewID;
        this.customerID = customerID;
        this.bookID = bookID;
        this.rating = rating;
        this.comment = comment;
    }

    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public int getId() {
        return reviewID;
    }

    public void setId(int id) {
        this.reviewID = id;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}