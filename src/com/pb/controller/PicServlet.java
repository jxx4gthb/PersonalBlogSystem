package com.pb.controller;

import com.pb.dao.PicDao;
import com.pb.entity.Pic;
import com.pb.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/pic")
public class PicServlet extends HttpServlet {
    private PicDao picDao = new PicDao();


    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if ("piclist".equals(method)) {
            writePicList(response);
        }
        if ("deletepic".equals(method)) {
            deletepic(request, response);
            response.sendRedirect("blog.jsp");
        }
        if ("admindel".equals(method)) {
            deletepic(request, response);
            response.sendRedirect("pic_management.jsp");
        }
    }

    private void deletepic(HttpServletRequest request, HttpServletResponse response) {
        Integer id = Integer.parseInt(request.getParameter("id"));
        try {
            picDao.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void writePicList(HttpServletResponse response) throws IOException {
        List<Pic> PicList = null;
        try {
            PicList = picDao.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("application/json;charset=UTF-8");
        StringBuffer stringBuffer = new StringBuffer("[");
        for ( int i = 0; i < PicList.size(); i++ ) {
            Pic pic = PicList.get(i);
            stringBuffer.append("{");
            stringBuffer.append("\"id\":\""+pic.getId()+"\",");
            stringBuffer.append("\"upuser\":\""+pic.getUpuser()+"\",");
            stringBuffer.append("\"picurl\":\""+pic.getPicurl()+"\",");
            stringBuffer.append("\"picname\":\""+pic.getPicname()+"\"");
            stringBuffer.append("}");
            if(i<PicList.size()-1){
                stringBuffer.append(",");
            }
        }
        stringBuffer.append("]");
        PrintWriter writer = response.getWriter();
        writer.println(stringBuffer.toString());
    }

}
