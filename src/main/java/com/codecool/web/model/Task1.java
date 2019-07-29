package com.codecool.web.model;

public final class Task1 extends AbstractModel {

    private final String product;

    public Task1(String product, String company) {
        super(company);
        this.product = product;
    }

    public String getProduct() {
        return product;
    }
}
