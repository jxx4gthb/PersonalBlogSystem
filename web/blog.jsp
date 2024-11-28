<%--
  Created by IntelliJ IDEA.
  User: awsomeone
  Date: 2023/12/21
  Time: 04:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${user.name}的个人博客</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .post {
            max-width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-height: 800px; /* 设置图片框的最大高度 */
            overflow-y: auto;
        }

        .user-info {
            padding: 15px;
            display: flex;
            align-items: center;
        }

        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .user-info .username {
            font-weight: bold;
        }

        .post-text {
            padding: 0 15px;
            margin-top: 10px;
        }

        .post-img {
            width: 100%;
            max-height: 800px;
            object-fit: cover;
            border-bottom: black 1px solid;
        }
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
    </style>
</head>
<body onload="checkLoginStatus()" style="background-image: url(${user.background});background-size: 100% auto;">
    <div class="overlay" onclick="closePopups()"></div>
    <h1>${user.name}，欢迎回来！</h1>
    <a href="account?method=logout">退出</a>
    <button onclick="togglePopup('upload')">上传图片</button>
    <button onclick="togglePopup('background')">更改背景图片</button>
    <div class="popup" id="backgroundPopup">
    <form id="uploadform-background" action="blog?method=background" method="post" enctype="multipart/form-data" >
        <h3>更改背景图片</h3>
        <input id="backgroundInput" type="file" name="pic"/>
        <input  type="text" name="name" value="${user.name}" hidden>
        <input  type="text" name="username" value="${user.username}" hidden>
        <button type="submit" onclick="backgroundalert()">更改背景图片</button>
    </form>
    </div>
    <div class="popup" id="uploadPopup">
    <form id="uploadform" action="blog?method=pic" method="post" enctype="multipart/form-data">
        <%--multipart/form-data:二进制文件格式--%>
        <h3>上传图片</h3>
        <input type="text" required name="title" placeholder="说点什么吧！"/>
        <br>
        <input id="uploadpic" type="file" name="pic" />
        <input  type="text" name="user" value="${user.username}" hidden>
        <input type="submit" value="提交" onclick="changePic">
    </form>
    </div>
    <div class="post">

    </div>
<script>
    function checkLoginStatus() {
        // 发送异步请求检查登录状态
        fetch('http://localhost:8090/project_war_exploded/checklogin', {
            method: 'GET'
        })
            .then(response => {
                if (response.redirected) {
                    // 如果服务器重定向到登录页面，就跳转到登录页面
                    window.location.href = response.url;
                } else {
                    // 在这里处理用户已登录的情况，可以执行其他操作
                    console.log("User is logged in.");
                }
            })
            .catch(error => {
                console.error('Error checking login status:', error);
            });
    }
</script>
<script>
    document.addEventListener('DOMContentLoaded',function (){
        var uploadform = document.querySelector('#uploadform');
        uploadform.addEventListener('submit',function (e){
            e.preventDefault();
            const uploadpic = document.querySelector('#uploadpic');
            if (uploadpic.files.length > 0) {
                uploadform.submit();
        }else{
                alert('请选择图片文件');
            }

        })
    })
    document.addEventListener('DOMContentLoaded',function (){
        var uploadform = document.querySelector('#uploadform-background');
        uploadform.addEventListener('submit',function (e){
            e.preventDefault();
            const uploadpic = document.querySelector('#backgroundInput');
            if (uploadpic.files.length > 0) {
                uploadform.submit();
            }else{
                alert('请选择图片文件');
            }

        })
    })


</script>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<script>

    function backgroundalert(){
        alert("更改背景图片成功!点击确定后生效！")
    }


    $(function () {
        $.ajax({
            url:"http://localhost:8090/project_war_exploded/pic",
            type:"get",
            dataType:"json",
            data:{method:"piclist"},
            success:function(data){
                console.log(data)
                $.each(data,function (index,picList){
                    let div =
                        '    <div class="user-info">\n' +
                        '        <div class="username">' + picList.upuser + '</div>\n' +
                        '    </div>\n' +
                        '    <div class="post-text">\n' +
                        '        <p>' + picList.picname + '</p>\n' +
                        '    </div>\n' +
                        '    <img class="post-img" src="' + picList.picurl + '" alt="Post Image">\n' +
                        '    <form action="pic?method=deletepic" method="post">\n' +
                        '        <input type="text" name="id" value='+picList.id+' hidden>\n'
                    if (picList.upuser != "${user.username}"){
                        div +=
                        '    </form>\n'
                    }else {
                        div +=
                        '    <button type="submit" class="delete-button" >删除</button>\n'+
                        '    </form>\n'
                    }
                    $(".post").append(div)
                })
            },
            error:function(){
                alert("请求失败");
            }
        })
    })

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
</script>

</body>
</html>