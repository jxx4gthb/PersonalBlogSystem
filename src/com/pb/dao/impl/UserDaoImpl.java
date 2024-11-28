package com.pb.dao.impl;

import com.pb.dao.UserDao;
import com.pb.entity.SystemAdmin;
import com.pb.entity.User;
import com.pb.util.JDBCUtil;

import javax.persistence.criteria.CriteriaBuilder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {

    @Override
    public List<User> list() {
        Connection connection = JDBCUtil.getConnection();
        String sql = "select * from user";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<User> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()){
                int id = resultSet.getInt(1);
                String username = resultSet.getString(2);
                String password = resultSet.getString(3);
                String name = resultSet.getString(4);
                String gender = resultSet.getString(5);
                String telephone = resultSet.getString(6);
                list.add(new User(id,username,password,name,gender,telephone));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            JDBCUtil.release(connection,statement,resultSet);
        }
        return list;
    }

    @Override
    public Integer save(User user) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "insert into user(username,password,name,gender,telephone) values(?,?,?,?,?)";
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1,user.getUsername());
            statement.setString(2,user.getPassword());
            statement.setString(3,user.getName());
            statement.setString(4,user.getGender());
            statement.setString(5,user.getTelephone());
            result = statement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            JDBCUtil.release(connection,statement,null);
        }
        return result;
    }

    @Override
    public Integer delete(Integer id) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "delete from user where id ="+id;
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            result = statement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            JDBCUtil.release(connection,statement,null);
        }
        return result;
    }

    @Override
    public User findByUsername(String username) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "select * from user where username ='"+username+"'";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        User user = null;
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            if (resultSet.next()){
                username = resultSet.getString(2);
                String password = resultSet.getString(3);
                String name = resultSet.getString(4);
                String background = resultSet.getString(7);
                return new User(username,password,name,background);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            JDBCUtil.release(connection,statement,null);
        }
        return null;
    }

    public int saveBackground(User user) throws SQLException{
        String sql = "update user set bgurl = ? where username = ?";
        PreparedStatement statement = JDBCUtil.getConnection().prepareStatement(sql);
        statement.setString(1,user.getBackground());
        statement.setString(2,user.getUsername());
        return statement.executeUpdate();
    }
}
