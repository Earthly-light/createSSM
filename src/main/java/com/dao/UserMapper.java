package com.dao;

import com.bean.Region;
import com.bean.User;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface UserMapper {
    public List<User> getUserList();
    public void getUserList2();

    List<Region> getZtreeList();
}
