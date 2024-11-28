package com.pb.service.impl;

import com.pb.dao.SystemAdminDao;
import com.pb.dao.impl.SystemAdminDaoImpl;
import com.pb.dto.SystemAdminDto;
import com.pb.entity.SystemAdmin;
import com.pb.service.SystemAdminService;

public class SyetemAdminServiceImpl implements SystemAdminService {
    private SystemAdminDao systemAdminDao = new SystemAdminDaoImpl();
    @Override
    public SystemAdminDto login(String username, String password) {
        //通过username查询数据库
        //结果为空，username错误
        //不为空，再判断password是否正确
        SystemAdmin systemAdmin = this.systemAdminDao.findByUsername(username);
        SystemAdminDto systemAdminDto = new SystemAdminDto();
        if (systemAdmin == null){
            systemAdminDto.setCode(-1);  //username does not exist
        } else {
            if (!systemAdmin.getPassword().equals(password)){
                systemAdminDto.setCode(-2);  //wrong password
            }else{
                systemAdminDto.setCode(0); //login successfully
                systemAdminDto.setSystemAdmin(systemAdmin);
            }
        }
        return systemAdminDto;
    }
}
