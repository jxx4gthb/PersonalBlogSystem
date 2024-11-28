package com.pb.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/checklogin")
public class CheckLoginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取当前的Session，如果没有Session或者Session中没有保存用户信息，说明用户没有登录
        HttpSession session = request.getSession(false);

        if (session != null) {

        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
