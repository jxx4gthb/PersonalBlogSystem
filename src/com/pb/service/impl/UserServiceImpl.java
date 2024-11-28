package com.pb.service.impl;

import com.pb.dao.UserDao;
import com.pb.dao.impl.UserDaoImpl;
import com.pb.dto.UserDto;
import com.pb.entity.User;
import com.pb.service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDao userDao = new UserDaoImpl();

    @Override
    public List<User> list() {
        return this.userDao.list();
    }

    @Override
    public void save(User user) {
        Integer save = this.userDao.save(user);
        if (save != 1) throw new RuntimeException("用户添加失败");
    }

    @Override
    public void delete(Integer id) {
        Integer delete = this.userDao.delete(id);
        if (delete != 1) throw new RuntimeException("用户删除失败");
    }

    @Override
    public UserDto login(String username, String password) {
        //通过username查询数据库
        //结果为空，username错误
        //不为空，再判断password是否正确
        User user = this.userDao.findByUsername(username);
        UserDto userDto = new UserDto();
        if (user == null){
            userDto.setCode(-1);  //username does not exist
        } else {
            if (!user.getPassword().equals(password)){
                userDto.setCode(-2);  //wrong password
            }else{
                userDto.setCode(0); //login successfully
                userDto.setUser(user);
            }
        }
        return userDto;
    }
}
