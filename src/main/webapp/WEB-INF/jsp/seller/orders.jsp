<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Заказы продавца</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 0;
        }

        .container {
            position: relative;
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 900px;
            max-height: 90vh;
            overflow-y: auto;
            box-sizing: border-box;
        }

        .logout-button {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .logout-button:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #4a4a4a;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            color: #555;
            font-weight: 600;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        tbody tr:hover {
            background-color: #f9f9f9;
        }

        .no-orders {
            text-align: center;
            color: #888;
            font-size: 18px;
            padding: 20px 0;
        }

        a.view-link {
            color: #667eea;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s;
        }

        a.view-link:hover {
            color: #764ba2;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/logout" class="logout-button">Выход</a>

    <h1>Все заказы</h1>

    <c:if test="${empty orders}">
        <p class="no-orders">Нет заказов для отображения.</p>
    </c:if>

    <c:if test="${not empty orders}">
        <table>
            <thead>
            <tr>
                <th>ID заказа</th>
                <th>Описание</th>
                <th>Клиент</th>
                <th>Статус</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.id}</td>
                    <td>${order.description}</td>
                    <td>${order.client.username}</td>
                    <td>
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}">Ожидает</c:when>
                            <c:when test="${order.status == 'APPROVED'}">Одобрен</c:when>
                            <c:when test="${order.status == 'REJECTED'}">Отклонен</c:when>
                            <c:when test="${order.status == 'IN_PROGRESS'}">В работе</c:when>
                            <c:when test="${order.status == 'COMPLETED'}">Выполнен</c:when>
                            <c:otherwise>${order.status}</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/seller/orders/${order.id}" class="view-link">Просмотреть</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>