package com.pb.dao;

import com.pb.entity.Pic;
import com.pb.entity.User;
import com.pb.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PicDao {
    public List<Pic> list() {
        Connection connection = JDBCUtil.getConnection();
        String sql = "select * from blog";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Pic> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()){
                Integer id = resultSet.getInt(1);
                String upuser = resultSet.getString(2);
                String picurl = resultSet.getString(3);
                String picname = resultSet.getString(4);
                list.add(new Pic(id,upuser,picurl,picname));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            JDBCUtil.release(connection,statement,resultSet);
        }
        return list;
}


    public void delete(Integer id) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "delete from blog where id = "+id;
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            JDBCUtil.release(connection,statement,null);
        }
    }
}
