<%--
  Created by IntelliJ IDEA.
  User: awsomeone
  Date: 2023/12/20
  Time: 23:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style>
        .action-buttons {
            width: 97%;
            position: fixed;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(255, 255, 255, 0.8);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            z-index: 1; /* 确保按钮显示在表格上方 */
        }
        button {
            margin: 0 10px;
        }
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            z-index: 2;
        }
        form {
            display: flex;
            flex-direction: column;
            width: 200px;
        }
        form input {
            margin-top: 10px;
        }
        /* 背景遮罩 */
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 60px;
        }

        /* Style the table header */
        .user-table th {
            background-color: #f2f2f2; /* Set background color for header */
            border: 1px solid #ddd; /* Add borders to header cells */
            padding: 8px;
            text-align: left;
        }

        /* Style the table rows */
        .user-table td {
            border: 1px solid #ddd; /* Add borders to cells */
            padding: 8px;
        }

        /* Alternate row colors for better readability */
        .user-table tbody tr:nth-child(even) {
            background-color: #f9f9f9; /* Set background color for even rows */
        }
    </style>
</head>
<body>
    <div class="action-buttons">
        <button onclick="togglePopup('delete')">删除用户</button>
        <button onclick="togglePopup('edit')">修改用户</button>
        <button onclick="togglePopup('add')">添加用户</button>
    </div>
    <div class="overlay" onclick="closePopups()"></div>

    <div class="table-container">
        <table class="user-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>密码</th>
                <th>姓名</th>
                <th>性别</th>
                <th>联系电话</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="user">
                <tr>
                <td class="userID">${user.id}</td>
                <td class="userName">${user.username}</td>
                <td>${user.password}</td>
                <td>${user.name}</td>
                <td>${user.gender}</td>
                <td>${user.telephone}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="popup" id="deletePopup">
        <h3>删除用户</h3>
        <form action="user?method=delete" method="post">
            <label for="id1">用户ID</label>
            <input type="text" name="id" required id="id1">
            <input type="submit" value="删除">
        </form>
    </div>

    <div class="popup" id="addPopup">
        <h3>增加用户</h3>
        <form action="user?method=save" method="post">
            <label for="username3">用户名</label>
            <input type="text" name="username" required id="username3">
            <label for="password3">密码</label>
            <input type="text" name="password" id="password3">
            <label for="name3">姓名</label>
            <input type="text" name="name" id="name3">
            <label for="gender3">性别</label>
            <input type="text" name="gender" id="gender3">
            <label for="telephone3">联系电话</label>
            <input type="text" name="telephone" id="telephone3">
            <input type="submit" value="添加">
        </form>
    </div>

    <script>
        function togglePopup(action) {
            var popup = document.getElementById(action + 'Popup');
            var overlay = document.querySelector('.overlay');
            if (popup.style.display === 'block') {
                popup.style.display = 'none';
                overlay.style.display = 'none';
            } else {
                popup.style.display = 'block';
                overlay.style.display = 'block';
            }
        }

        function closePopups() {
            var popups = document.querySelectorAll('.popup');
            var overlay = document.querySelector('.overlay');
            popups.forEach(function(popup) {
                popup.style.display = 'none';
            });
            overlay.style.display = 'none';
        }

        document.addEventListener('DOMContentLoaded', function () {
            var deleteForm = document.querySelector('#deletePopup form');
            var addForm = document.querySelector('#addPopup form');
            addForm.addEventListener('submit', function (event) {
                // 阻止表单默认提交行为
                event.preventDefault();

                // 获取输入的用户名
                var username = document.querySelector('#username3').value;

                // 检查用户名是否存在于页面中
                if (checkUsernameExists(username)) {
                    // 如果存在，显示错误消息或采取其他适当的操作
                    alert('用户名已存在！');
                } else {
                    // 如果不存在，可以继续提交表单
                    addForm.submit();
                }
            });
            deleteForm.addEventListener('submit', function (event) {
                // 阻止表单默认提交行为
                event.preventDefault();

                // 获取输入的用户ID
                var userId = document.querySelector('#id1').value;

                // 检查用户ID是否存在于页面中
                if (checkUserIdExists(userId)) {
                    // 如果存在，可以继续提交表单
                    deleteForm.submit();
                } else {
                    // 如果不存在，显示错误消息或采取其他适当的操作
                    alert('用户ID不存在！');
                }
            });

            function checkUserIdExists(userId) {
                // 在这里实现检查用户ID是否存在的逻辑
                // 可以遍历页面中的元素，比如用户列表，检查是否有匹配的用户ID
                // 如果存在返回 true，否则返回 false
                // 示例代码：
                var userElements = document.querySelectorAll('.userID');
                for (var i = 0; i < userElements.length; i++) {
                    console.log(userElements[i].textContent)
                    if (userElements[i].textContent === userId) {

                        return true;
                    }
                }
                return false;
            }

            function checkUsernameExists(username) {
                // 在这里实现检查用户名是否存在的逻辑
                var userElements = document.querySelectorAll('.userName');
                for (var i = 0; i < userElements.length; i++) {
                    if (userElements[i].textContent === username) {
                        return true;
                    }
                }
                return false;
            }
        });

    </script>
</body>
</html>
