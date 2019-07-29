package com.codecool.web.model;

import java.util.Objects;

abstract class AbstractModel {

    private String company;

    public AbstractModel(String company) {
        this.company = company;
    }

    public String getCompany() {
        return company;
    }

}
