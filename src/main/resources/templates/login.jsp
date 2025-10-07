<html>
<head><title>Вход</title></head>
<body>
<h2>Вход в систему</h2>
<form action="${pageContext.request.contextPath}/login" method="post">
    <label for="username">Имя пользователя:</label><br/>
    <input type="text" id="username" name="username" required/><br/><br/>
    <label for="password">Пароль:</label><br/>
    <input type="password" id="password" name="password" required/><br/><br/>
    <input type="submit" value="Войти"/>
</form>
<p>Нет аккаунта? <a href="${pageContext.request.contextPath}/register">Зарегистрироваться</a></p>
</body>
</html>