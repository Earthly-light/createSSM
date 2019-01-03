package com.dao;


import com.bean.UserInfo;
import org.springframework.stereotype.Repository;

@Repository
public interface RegisterMapper {

    UserInfo getUserInfoIsExists(UserInfo userInfo);

    Integer insertUser(UserInfo userInfo);
}
