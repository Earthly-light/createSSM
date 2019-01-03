package com.controller;


import com.bean.UserInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/registerController")
public class RegisterController {

    @Autowired
    RegisterService registerService;

    @RequestMapping(value ="/register",produces = "application/json;charset=utf-8",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String login(HttpServletRequest request, UserInfo userInfo) throws Exception{
        HttpSession session = request.getSession();
        ObjectMapper mapper = new ObjectMapper();

        if(StringUtils.isEmpty(userInfo.getUserName())){
            userInfo.setCode("1");
            userInfo.setMsg("用户名不能为空");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }
        if(StringUtils.isEmpty(userInfo.getUserName())){
            userInfo.setCode("2");
            userInfo.setMsg("密码不能为空");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }
        if(StringUtils.isEmpty(userInfo.getSecondPassword())){
            userInfo.setCode("7");
            userInfo.setMsg("二次密码不能为空");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;

        }
        if(!userInfo.getSecondPassword().equals(userInfo.getPassword())){
            userInfo.setCode("8");
            userInfo.setMsg("两次输入密码不同，请重新输入");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }
        UserInfo userInfo1 = registerService.getUserInfoIsExists(userInfo);

        if(userInfo1 !=null ){
            userInfo.setCode("3");
            userInfo.setMsg("该账户已注册");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }

        if(userInfo1==null){
            //可以注册

           Integer  flag =  registerService.insertUser(userInfo);
           if(flag == 1){
               userInfo.setCode("4");
               String jsonlist = mapper.writeValueAsString(userInfo);
               return jsonlist;
           }else{
               userInfo.setCode("5");
               String jsonlist = mapper.writeValueAsString(userInfo);
               return jsonlist;
           }
        }
        userInfo.setCode("6");
        userInfo.setMsg("业务异常");
        String jsonlist = mapper.writeValueAsString(userInfo);
        return jsonlist;
    }


    @RequestMapping(value ="",method = {RequestMethod.POST,RequestMethod.GET}, produces = "text/html;charset=UTF-8")
    public String index() throws Exception{
        System.out.println("tiaooooo");
        return  "redirect:index.jsp";
    }
}
