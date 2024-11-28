package com.pb.controller;
import com.pb.dao.BlogDao;
import com.pb.dao.UserDao;
import com.pb.dao.impl.UserDaoImpl;
import com.pb.entity.Blog;
import com.pb.entity.User;
import com.pb.util.FileUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

@WebServlet("/blog")
public class BlogServlet extends HttpServlet{
    private BlogDao blogDao = new BlogDao();
    private UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String method = req.getParameter("method");
        Blog blog = new Blog();
        User user = new User();
        boolean multipartContent = ServletFileUpload.isMultipartContent(req);
        if(multipartContent){
            //实例化上传组件
            DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
            //用工厂对象实例化上传组件
            ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
            //通过上传组件解析请求变成所有的类目 FileItem
            List<FileItem> list = null;
            try {
                list = servletFileUpload.parseRequest(req);
            } catch (FileUploadException e) {
                throw new RuntimeException(e);
            }
            Iterator<FileItem> itemIterator = list.listIterator();
            while(itemIterator.hasNext()){
                FileItem fileItem = itemIterator.next();
                if(fileItem.isFormField()){
                    //普通表单项
                    String fieldName = fileItem.getFieldName(); //获取普通文本域的内容
                    if("title".equals(fieldName))
                        blog.setTitle(fileItem.getString("UTF-8"));
                    if ("user".equals(fieldName))
                        blog.setUser(fileItem.getString("UTF-8"));
                    if ("name".equals(fieldName))
                        user.setName(fileItem.getString("UTF-8"));
                    if ("username".equals(fieldName))
                        user.setUsername(fileItem.getString("UTF-8"));
                }else {
                    //抽象文件
                    File file = new File(fileItem.getName()); //文件全路径名
                    String uploadfilename = FileUtil.subname(file.getName()); //文件名
                    //上传的包含地址的文件对象
                    String filepath = "/Users/awsomeone/IdeaProjects/project_test/img";
                    File uploadFile = new File(filepath,uploadfilename);
                    String url = "http://localhost:8088/"+uploadfilename;
                    switch (method){
                        case "pic":
                            blog.setPic(url);
                            res.sendRedirect("blog.jsp");
                            break;
                        case "background":
                            user.setBackground(url);
                            HttpSession session = req.getSession();
//                            session.setMaxInactiveInterval(30);
                            session.setAttribute("user",user);
                            res.sendRedirect("blog.jsp");
                    }

                    try {
                        fileItem.write(uploadFile);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                }
            }

            try {
                switch (method){
                    case "pic":
                        blogDao.saveBlog(blog);
                        break;
                    case "background":
                        userDao.saveBackground(user);
                        break;
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        }
    }
}
