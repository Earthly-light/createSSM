package com.service;

import com.bean.Region;
import com.bean.User;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

public interface UserService {

    List<User> getUserList();

    List<Region> getZtreeList();
}
