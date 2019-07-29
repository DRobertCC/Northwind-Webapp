package com.codecool.web.servlet;

import com.codecool.web.dao.database.DatabaseTask1Dao;
import com.codecool.web.model.Task1;
import com.codecool.web.service.Task1Service;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/task1")
public final class Task1Servlet extends AbstractServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            DatabaseTask1Dao task1Dao = new DatabaseTask1Dao(connection);
            Task1Service task1Service = new Task1Service(task1Dao);

            List<Task1> task1Results = task1Service.task1Query();
            req.setAttribute("task1result", task1Results);

        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
        req.getRequestDispatcher("task1.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            DatabaseTask1Dao task1Dao = new DatabaseTask1Dao(connection);
            Task1Service task1Service = new Task1Service(task1Dao);

            String company = req.getParameter("company_name");

            List<Task1> task1FilteredResults = task1Service.findTask1BySupplier(company);
            req.setAttribute("task1result", task1FilteredResults);

        } catch (SQLException ex) {
            //throw new ServletException(ex);
            req.setAttribute("error", ex.getMessage());
        }
        req.getRequestDispatcher("task1.jsp").forward(req, resp);
    }
}
