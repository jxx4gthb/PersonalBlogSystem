<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>登录页面</title>
    <meta charset="UTF-8">
    <meta name ="viewport" content="width=device-width, initial-scale-1.0">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <div class="form row" style="height: 300px;">
    <form class="form-horizontal col-md-offset-4" id="login_form" action="<%= request.getContextPath()%>/account?method=login" method="post">
        <h3 class="form-title" style="color: darkgrey">WHY ARE U SO SERIOUS?</h3>
        <div class="col-md-6">
            <div class="form-group">
                <i class="fa fa-user fa-lg"></i>
                <span style="color: red;font-size: 13px;margin-left: -17px;">${usernameError}</span>
                <input class="form-control required" required placeholder="WHAT'S YOUR NAME?" type="text" name="username" />
            </div>
            <div class="form-group">
                <i class="fa fa-lock fa-lg"></i>
                <font style="color: red;font-size: 13px;margin-left: -17px;">${passwordError}</font>
                <input class="form-control required" required placeholder="PASSWORD?" type="password" name="password"/>
            </div>
            <div class="form-group">
                <label class="radio-inline">
                    <input type="radio" name="type"  value="systemAdmin" class="radio-inline"> BLOG MANAGER
                </Label>
                <Label class="radio-inline">
                    <input type="radio" name="type" checked value="user" class="radio-inline"> USER
                </label>
            </div>
            <div class="form-group col-md-offset-9">
                <button type="submit" class="btn btn-success pull-left" name="submit">LOG IN</button>
                <button type="reset" class="btn btn-success pull-right" name="submit">RESET</button>
            </div>
        </div>
    </form>
    </div>
</div>
</body>
</html>