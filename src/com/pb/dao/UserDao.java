package com.pb.dao;

import com.pb.entity.User;

import java.util.List;

public interface UserDao {
    public List<User> list();
    public Integer save(User user);
    public Integer delete(Integer id);

    public User findByUsername(String username);
}
