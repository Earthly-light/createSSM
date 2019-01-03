package com.service.impl;

import com.bean.Region;
import com.bean.User;
import com.dao.UserMapper;
import lombok.Data;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import com.service.UserService;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired

   UserMapper userMapper;
    @Override
    public List<User> getUserList() {
        System.out.println("找不到userMapper");
        List<User> list = userMapper.getUserList();
       // userMapper.getUserList2();
        System.out.println("找到userMapper");
        return  list;
    }

    @Override
    public List<Region> getZtreeList() {
        return userMapper.getZtreeList();
    }
}
