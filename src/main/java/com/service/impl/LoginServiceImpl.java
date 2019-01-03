package com.service.impl;

import com.bean.UserInfo;
import com.dao.LoginMapper;
import com.dao.UserMapper;
import com.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    LoginMapper loginMapper;
    @Override
    public UserInfo getUserInfoIsExists(UserInfo userInfo){
        UserInfo userInfo1 = loginMapper.getUserInfoIsExists(userInfo);
        return userInfo1;
    };

}
