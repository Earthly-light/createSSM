package com.service;

import com.bean.UserInfo;

public interface RegisterService {
    UserInfo getUserInfoIsExists(UserInfo userInfo);

   public  Integer insertUser(UserInfo userInfo);
}
