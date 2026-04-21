package model;

import java.util.Date;

public class Voucher {
    private int id;
    private String code;
    private double discount;
    private String type;
    private Date startDate;
    private Date endDate;
    private int quantity;
    private double minOrderValue;

    public Voucher() {}

    public Voucher(int id, String code, double discount, String type,
                   Date startDate, Date endDate, int quantity, double minOrderValue) {
        this.id = id;
        this.code = code;
        this.discount = discount;
        this.type = type;
        this.startDate = startDate;
        this.endDate = endDate;
        this.quantity = quantity;
        this.minOrderValue = minOrderValue;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(double minOrderValue) {
        this.minOrderValue = minOrderValue;
    }
}