<%--
  Created by IntelliJ IDEA.
  User: awsomeone
  Date: 2023/12/20
  Time: 22:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>权限设置</title>
  <link rel="stylesheet" href="css/sidetop.css">
  <link rel="stylesheet" href="font/iconfont.css">
</head>
<body onload="checkLoginStatus()">
<div class="container">
  <div class="sidecollar">
    <div class="logo">
      <a href="https://www.csu.edu.cn"><img src="img/logo.png" alt=""></a>
    </div>
    <ul class="item" type="none" id="navigation">
      <li><a href="blank.html" target="frame1"><span class="iconfont icon-home"></span>首页</a></li>
      <li><a href="content.html" target="frame1"><span class="iconfont icon-a-ziyuan45"></span>内容管理</a></li>
      <li class="selected" ><a href="user?method=list" target="frame1"><span class="iconfont icon-haoyoutuijie"></span>用户管理</a></li>
      <li><a href="pic_management.jsp" target="frame1"><span class="iconfont icon-ziyuan"></span>图片管理</a></li>
      <li><a href="blank.html" target="frame1"><span class="iconfont icon-guanggaoguanli"></span>广告管理</a></li>
      <li><a href="blank.html" target="frame1"><span class="iconfont icon-zizhutuiguang"></span>图库</a></li>
      <li><a href="blank.html" target="frame1"><span class="iconfont icon-kefu"></span>留言管理</a></li>
      <li><a href="blank.html" target="frame1"><span class="iconfont icon-shezhi"></span>设置</a></li>
    </ul>
  </div>
  <div class="top">
    <img src="img/head.jpg" alt="head" class="head">
    <p>早上好${systemAdmin.name}，欢迎来到后台管理系统！</p>
    <form action="#" method="get" class="search">
      <input type="text" placeholder="搜索">
      <button ><span class="iconfont icon-sousuo"></span></button>
    </form>
    <a href="#" class="helpexit"><span class="iconfont icon-bangzhuyushuoming"></span>帮助</a>
    <a href="account?method=logout" class="helpexit">退出</a>
  </div>
  <iframe frameborder="0" class="content" name="frame1" src="user?method=list"></iframe>
</div>
<script>
  var items = document.querySelectorAll('.item li');

  items.forEach(function(item) {
    item.addEventListener('click', function() {
      items.forEach(function(item) {
        item.classList.remove('selected');
        var span = item.querySelector('span');
        var a = item.querySelector('a');
        if (span) {
          span.style.color = 'black';
        }
        if (a) {
          a.style.color = 'black';
        }
      });

      this.classList.add('selected');
      var span = this.querySelector('span');
      var a = this.querySelector('a');
      if (span) {
        span.style.color = 'white';
      }
      if (a) {
        a.style.color = 'white';
      }
    });
  });
</script>
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
</body>
</html>
