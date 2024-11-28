package com.pb.controller;
import com.pb.dto.SystemAdminDto;
import com.pb.dto.UserDto;
import com.pb.service.SystemAdminService;
import com.pb.service.UserService;
import com.pb.service.impl.SyetemAdminServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {
    private SystemAdminService systemAdminService = new SyetemAdminServiceImpl();
    private UserService userService = new com.pb.service.impl.UserServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        switch (method){
            case "login":
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String type = req.getParameter("type");
                switch (type){
                    case "systemAdmin":
                        SystemAdminDto systemAdminDto = this.systemAdminService.login(username,password);
                        switch (systemAdminDto.getCode()){
                            case -1:
                                req.setAttribute("usernameError","WRONG NAME!");
                                req.getRequestDispatcher("login.jsp").forward(req,resp);
                                break;
                            case -2:
                                req.setAttribute("passwordError","WRONG PASSWORD!");
                                req.getRequestDispatcher("login.jsp").forward(req,resp);
                                break;
                            case 0:
                                //跳转至成功界面
                                HttpSession session = req.getSession();
                                session.setAttribute("systemAdmin",systemAdminDto.getSystemAdmin());
//                                session.setMaxInactiveInterval(30);
                                resp.sendRedirect("blogadmin.jsp");
                                break;
                        }
                        break;
                    case "user":
                        UserDto userDto = this.userService.login(username,password);
                        switch (userDto.getCode()){
                            case -1:
                                req.setAttribute("usernameError","WRONG NAME!");
                                req.getRequestDispatcher("login.jsp").forward(req,resp);
                                break;
                            case -2:
                                req.setAttribute("passwordError","WRONG PASSWORD!");
                                req.getRequestDispatcher("login.jsp").forward(req,resp);
                                break;
                            case 0:
                                //跳转至成功界面
                                HttpSession session = req.getSession();
//                                session.setMaxInactiveInterval(30);
                                session.setAttribute("user",userDto.getUser());
                                resp.sendRedirect("blog.jsp");
                                break;
                        }


                        break;
                }
                break;
            case "logout":
                req.getSession().invalidate();
                resp.sendRedirect("login.jsp");
        }

    }
}
