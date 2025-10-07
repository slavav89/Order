<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #4a4a4a;
        }
        form {
            display: flex;
            flex-direction: column;
            text-align: left;
        }
        label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            padding: 12px 40px 12px 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
            width: 100%;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #667eea;
            outline: none;
        }
        .password-container {
            position: relative;
            width: 100%;
            display: flex;
            align-items: center;
        }
        .password-container input {
            flex: 1;
        }
        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-90%);
            cursor: pointer;
            width: 24px;
            height: 24px;
            fill: #888;
            transition: fill 0.3s;
            user-select: none;
            background: transparent;
            border: none;
            padding: 0;
        }
        .toggle-password:hover {
            fill: #667eea;
        }
        .toggle-password:focus {
            outline: none;
        }
        input[type="submit"] {
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
            width: 100%;
        }
        input[type="submit"]:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: left;
        }
        .return-link {
            margin-top: 20px;
            text-align: center;
        }
        .return-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        .return-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Регистрация нового пользователя</h2>
    <c:if test="${not empty error}">
        <p class="error-message">${error}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" novalidate>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required autocomplete="username" />
        <div class="error-message" id="usernameError" style="display:none;">Пожалуйста, введите имя пользователя.</div>

        <label for="password">Password:</label>
        <div class="password-container">
            <input type="password" id="password" name="password" required autocomplete="new-password" />
            <svg id="togglePassword" class="toggle-password" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-label="Показать пароль" role="button" tabindex="0">
                <path d="M12 5c-7 0-11 7-11 7s4 7 11 7 11-7 11-7-4-7-11-7zm0 12a5 5 0 110-10 5 5 0 010 10zm0-8a3 3 0 100 6 3 3 0 000-6z"/>
                <line x1="4" y1="4" x2="20" y2="20" stroke="#667eea" stroke-width="2" />
            </svg>
        </div>
        <div class="error-message" id="passwordError" style="display:none;">Пожалуйста, введите пароль.</div>

        <input type="submit" value="Зарегистрироваться" />
    </form>
    <div class="return-link">
        <a href="${pageContext.request.contextPath}/login">Вернуться</a>
    </div>
</div>

<script>
    const togglePassword = document.getElementById('togglePassword');
    const passwordField = document.getElementById('password');

    let isPasswordVisible = false;

    togglePassword.addEventListener('click', () => {
        isPasswordVisible = !isPasswordVisible;
        passwordField.type = isPasswordVisible ? 'text' : 'password';

        if (isPasswordVisible) {
            togglePassword.innerHTML = `
                    <path d="M12 5c-7 0-11 7-11 7s4 7 11 7 11-7 11-7-4-7-11-7zm0 12a5 5 0 110-10 5 5 0 010 10zm0-8a3 3 0 100 6 3 3 0 000-6z"/>
                `;
            togglePassword.setAttribute('aria-label', 'Скрыть пароль');
        } else {
            togglePassword.innerHTML = `
                    <path d="M12 5c-7 0-11 7-11 7s4 7 11 7 11-7 11-7-4-7-11-7zm0 12a5 5 0 110-10 5 5 0 010 10zm0-8a3 3 0 100 6 3 3 0 000-6z"/>
                    <line x1="4" y1="4" x2="20" y2="20" stroke="#667eea" stroke-width="2" />
                `;
            togglePassword.setAttribute('aria-label', 'Показать пароль');
        }
    });

    togglePassword.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            togglePassword.click();
        }
    });

    document.getElementById('registerForm').addEventListener('submit', function(event) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();
        const usernameError = document.getElementById('usernameError');
        const passwordError = document.getElementById('passwordError');

        let hasError = false;

        usernameError.style.display = 'none';
        passwordError.style.display = 'none';

        if (username === '') {
            usernameError.style.display = 'block';
            hasError = true;
        }
        if (password === '') {
            passwordError.style.display = 'block';
            hasError = true;
        }

        if (hasError) {
            event.preventDefault();
        }
    });
</script>
</body>
</html>
