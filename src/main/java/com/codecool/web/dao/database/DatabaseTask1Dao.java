package com.codecool.web.dao.database;

import com.codecool.web.model.Task1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseTask1Dao extends AbstractDao {

    public DatabaseTask1Dao(Connection connection) {
        super(connection);
    }

    public List<Task1> task1Query() throws SQLException {

        List<Task1> task1Results = new ArrayList<>();
        String sql = "SELECT P.product_name, S.company_name " +
            "FROM products AS P " +
            "INNER JOIN suppliers AS S " +
            "ON P.supplier_id = S.supplier_id " +
            "ORDER BY P.product_name, S.company_name";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            while (resultSet.next()) {
                task1Results.add(fetchTask1Result(resultSet));
            }
        }
        return task1Results;
    }

    public List<Task1> findTask1BySupplier(String supplierName) throws SQLException {

        if (supplierName == null || "".equals(supplierName)) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }
        List<Task1> task1Results = new ArrayList<>();
        String sql = "SELECT P.product_name, S.company_name " +
            "FROM products AS P " +
            "INNER JOIN suppliers AS S " +
            "ON P.supplier_id = S.supplier_id " +
            "WHERE lower(S.company_name) LIKE ?" +
            "ORDER BY P.product_name, S.company_name";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + supplierName.toLowerCase() + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    task1Results.add(fetchTask1Result(resultSet));
                }
            }
        }
        return task1Results;
    }

    private Task1 fetchTask1Result(ResultSet resultSet) throws SQLException {
        String product = resultSet.getString("product_name");
        String company = resultSet.getString("company_name");
        return new Task1(product, company);
    }

}
