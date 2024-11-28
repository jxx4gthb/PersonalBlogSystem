package com.pb.dao;

import com.pb.entity.Blog;
import com.pb.entity.User;
import com.pb.util.JDBCUtil;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BlogDao {
    public int saveBlog(Blog blog) throws SQLException {
        String sql ="insert into blog(upuser,picurl,picname) values(?,?,?)";
        PreparedStatement statement = JDBCUtil.getConnection().prepareStatement(sql);
        statement.setString(1, blog.getUser());
        statement.setString(3, blog.getTitle());
        statement.setString(2, blog.getPic());
        return statement.executeUpdate();
    }



}
