package com.codecool.web.service;

import com.codecool.web.dao.database.DatabaseTask1Dao;
import com.codecool.web.model.Task1;

import java.sql.SQLException;
import java.util.List;

public final class Task1Service {

    private final DatabaseTask1Dao task1Dao;

    public Task1Service(DatabaseTask1Dao task1Dao) {
        this.task1Dao = task1Dao;
    }

    public List<Task1> task1Query() throws SQLException {
        return task1Dao.task1Query();
    }

    public List<Task1> findTask1BySupplier(String supplierName) throws SQLException {
        return task1Dao.findTask1BySupplier(supplierName);
    }

}
