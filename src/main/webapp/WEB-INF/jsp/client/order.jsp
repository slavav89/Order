<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>My orders</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 800px;
            text-align: center;
            position: relative;
        }
        h2 {
            margin-bottom: 20px;
            color: #4a4a4a;
        }
        .create-link {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
            transition: background 0.3s;
        }
        .create-link:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        .user-info {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .username {
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }
        .logout-link {
            padding: 8px 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
            font-size: 14px;
            transition: background 0.3s;
        }
        .logout-link:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .no-orders {
            font-style: italic;
            color: #888;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="user-info">
        <c:if test="${not empty sessionScope.username}">
            <span class="username">${sessionScope.username}</span>
        </c:if>
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">Выход</a>
    </div>
    <h2>Мои заказы</h2>
    <a href="${pageContext.request.contextPath}/client/orders/new" class="create-link">Создать новый заказ</a>
    <c:if test="${empty orders}">
        <p class="no-orders">У вас пока нет заказов.</p>
    </c:if>
    <c:if test="${not empty orders}">
        <table>
            <tr>
                <th>№</th>
                <th>Описание</th>
                <th>Статус</th>
            </tr>
            <c:forEach var="order" items="${orders}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${order.description}</td>
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
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>
</body>
</html>