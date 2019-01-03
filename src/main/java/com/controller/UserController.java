package com.controller;

import com.bean.Region;
import com.bean.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.service.UserService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value="/userController")
public class UserController {


    @Autowired
    UserService userService;
    //private  ObjectMapper mapper = new ObjectMapper();
   @ResponseBody
    @RequestMapping(value ="/say",produces = "application/json;charset=utf-8",method = {RequestMethod.POST,RequestMethod.GET})
    public String say() throws Exception{
        //UserService userService = new UserServiceImpl();
        System.out.println("Hello world");
        List<User> list = userService.getUserList();
        System.out.println("controller list"+list);
        System.out.println("zhenbuhao");
        //String jsonStr = mapper.writeValueAsString(list);
        ObjectMapper mapper = new ObjectMapper();

            String jsonlist = mapper.writeValueAsString(list);
            System.out.println("jsonlist.toString()"+jsonlist.toString());


        return  jsonlist;

    }



    //getZtreeList

    @ResponseBody
    @RequestMapping(value ="/getZtreeList",produces = "application/json;charset=utf-8",method = {RequestMethod.POST,RequestMethod.GET})
    public String getZtreeList() throws Exception{

        List<Region> list = userService.getZtreeList();
        ObjectMapper mapper = new ObjectMapper();

        String jsonlist = mapper.writeValueAsString(list);
        System.out.println("jsonlist.toString()"+jsonlist.toString());


        return  jsonlist;

    }

}
