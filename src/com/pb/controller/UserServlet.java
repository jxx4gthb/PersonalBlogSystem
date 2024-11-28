package com.pb.controller;

import com.pb.dto.UserDto;
import com.pb.entity.User;
import com.pb.service.UserService;
import com.pb.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String method = req.getParameter("method");
        switch (method){
            case "list":
                req.setAttribute("list",this.userService.list());
                req.getRequestDispatcher("user_management.jsp").forward(req,resp);
//                resp.sendRedirect("user_management.jsp");
                break;
            case "save":
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String name = req.getParameter("name");
                String gender = req.getParameter("gender");
                String telephone = req.getParameter("telephone");
                this.userService.save(new User(username,password,name,gender,telephone));
                resp.sendRedirect("user?method=list");
                break;
            case "delete":
                Integer id = Integer.parseInt(req.getParameter("id"));
                this.userService.delete(id);
                resp.sendRedirect("user?method=list");
                break;

        }

    }
}
