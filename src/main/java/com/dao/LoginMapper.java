package com.dao;

import com.bean.UserInfo;
import org.springframework.stereotype.Repository;

@Repository
public interface LoginMapper {

    public UserInfo getUserInfoIsExists( UserInfo userInfo);
}
