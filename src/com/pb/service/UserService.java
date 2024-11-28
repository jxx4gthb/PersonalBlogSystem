package com.pb.service;

import com.pb.dto.UserDto;
import com.pb.entity.User;

import java.util.List;

public interface UserService {
    public List<User> list();
    public void save(User user);
    public void delete(Integer id);
    public UserDto login(String username, String password);

}
