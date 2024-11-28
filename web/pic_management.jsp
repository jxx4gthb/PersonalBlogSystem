<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <style>
    .post {
      display: table;
      width: 100%;
    }

    .post-item {
      display: table-row;
    }

    .user-info, .post-text, .post-img, .delete-button {
      display: table-cell;
      padding: 8px;
      border: 1px solid #ddd; /* 为了更好的可视化效果添加边框 */
    }

    form {
      display: table-cell;
      padding: 8px;
      border: 1px solid #ddd; /* 为了更好的可视化效果添加边框 */
    }

    img {
      max-width: 100px; /* 限制图片宽度 */
      max-height: 100px; /* 限制图片高度 */
    }
  </style>
</head>
<body>
<div class="post">
  <div class="post-item table-header">
    <div class="user-info">用户名</div>
    <div class="post-text">文字</div>
    <div class="post-img">图片</div>
    <div class="delete-button">操作</div>
  </div>
</div>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<script>
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
                  '<div class="post-item">' +
                  '    <div class="user-info">' +
                  '        <div class="username">' + picList.upuser + '</div>' +
                  '    </div>' +
                  '    <div class="post-text">' +
                  '        <p>' + picList.picname + '</p>' +
                  '    </div>' +
                  '    <div class="post-img">' +
                  '        <img src="' + picList.picurl + '" alt="Post Image">' +
                  '    </div>' +
                  '    <form action="pic?method=admindel" method="post">' +
                  '        <input type="text" name="id" value='+picList.id+' hidden>' +
                  '        <button type="submit" class="delete-button" >删除</button>' +
                  '    </form>' +
                  '</div>';
          $(".post").append(div)
        })
      },
      error:function(){
        alert("请求失败");
      }
    })
  })
</script>
</body>
</html>
