package com.service.impl;

import com.bean.UserInfo;
import com.dao.RegisterMapper;
import com.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegisterServiceImpl implements RegisterService {
    @Autowired
    RegisterMapper registerMapper;
    @Override
    public UserInfo getUserInfoIsExists(UserInfo userInfo) {
        return registerMapper.getUserInfoIsExists(userInfo);
    }

    @Override
    public Integer insertUser(UserInfo userInfo) {
        Integer flag =  registerMapper.insertUser(userInfo);

        return flag;
    }
}
