<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Детали заказа #${order.id}</title>
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
            max-width: 600px;
            position: relative;
        }
        h2 {
            margin-bottom: 20px;
            color: #4a4a4a;
            text-align: center;
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
        .detail-item {
            margin-bottom: 15px;
            font-size: 16px;
        }
        .label {
            font-weight: 600;
            color: #4a4a4a;
        }
        form.status-form {
            margin-top: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        select {
            padding: 5px 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        button.update-btn {
            padding: 6px 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s;
        }
        button.update-btn:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        a.back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
            transition: background 0.3s;
        }
        a.back-link:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
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

    <h2>Детали заказа #${order.id}</h2>

    <p class="detail-item"><span class="label">Клиент:</span> ${order.client.username}</p>
    <p class="detail-item"><span class="label">Описание:</span> ${order.description}</p>
    <p class="detail-item">
        <span class="label">Статус:</span>
        <c:choose>
            <c:when test="${order.status == 'PENDING'}">Ожидает</c:when>
            <c:when test="${order.status == 'APPROVED'}">Одобрен</c:when>
            <c:when test="${order.status == 'REJECTED'}">Отклонен</c:when>
            <c:when test="${order.status == 'IN_PROGRESS'}">В работе</c:when>
            <c:when test="${order.status == 'COMPLETED'}">Выполнен</c:when>
            <c:otherwise>${order.status}</c:otherwise>
        </c:choose>
    </p>

    <form class="status-form" action="${pageContext.request.contextPath}/seller/orders/${order.id}/status" method="post">
        <label for="status">Изменить статус:</label>
        <select name="status" id="status">
            <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Ожидает</option>
            <option value="APPROVED" ${order.status == 'APPROVED' ? 'selected' : ''}>Одобрен</option>
            <option value="REJECTED" ${order.status == 'REJECTED' ? 'selected' : ''}>Отклонен</option>
            <option value="IN_PROGRESS" ${order.status == 'IN_PROGRESS' ? 'selected' : ''}>В работе</option>
            <option value="COMPLETED" ${order.status == 'COMPLETED' ? 'selected' : ''}>Выполнен</option>
        </select>
        <button type="submit" class="update-btn">Обновить статус</button>
    </form>

    <a href="${pageContext.request.contextPath}/seller/orders" class="back-link">Назад к списку заказов</a>
</div>
</body>
</html>