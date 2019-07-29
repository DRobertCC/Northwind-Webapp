<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="en">

<head>
    <title>Northwind Webapp</title>
    <link type="text/css" rel="stylesheet" href="style.css">
</head>

<body>

<div id="wrapper">
    <div id="container">
        <div id="header">
            <h1>Task 1 Query Results</h1>
        </div>

        <jsp:include page="snippets/show-error.jsp"/>


        <jsp:include page="snippets/to-home.jsp"/>

        <h2>Filter by Suppliers:</h2>
        <table>
            <tr>
                <form method="POST" action="task1">
                        <td>Enter a company name you wish to search for:</td>
                        <td><input type="text" name="company_name" required></td>
                        <td><input type="submit" value="Filter"></td>
                </form>
                <form method="GET" action="task1">
                        <td><input type="submit" value="Clear filter"></td>
                </form>

            </tr>

        </table>

        <div id="content">

            <table id="nice-table">

                <tr>
                    <th>Product</th>
                    <th>Company</th>
                </tr>

                <c:forEach var="temp" items="${task1result}">

                    <tr>
                        <td> ${temp.getProduct()} </td>
                        <td> ${temp.getCompany()} </td>
                    </tr>

                </c:forEach>

            </table>

        </div>

    </div>

</div>

</body>

</html>




