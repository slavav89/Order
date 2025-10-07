<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>New order</title>
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
            text-align: center;
            position: relative;
        }
        h2 {
            margin-bottom: 20px;
            color: #4a4a4a;
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
        form {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #4a4a4a;
        }
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            resize: vertical;
            box-sizing: border-box;
        }
        input[type="submit"] {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        input[type="submit"]:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        .back-link {
            display: inline-block;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
            transition: background 0.3s;
        }
        .back-link:hover {
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
    <h2>Создать новый заказ</h2>
    <form action="${pageContext.request.contextPath}/client/orders" method="post">
        <label for="description">Описание заказа:</label><br/>
        <textarea id="description" name="description" rows="4" cols="50" required></textarea><br/><br/>
        <input type="submit" value="Отправить заказ"/>
    </form>
    <a href="${pageContext.request.contextPath}/client/orders" class="back-link">Назад к заказам</a>
</div>
</body>
</html>