package com.controller;


import com.bean.UserInfo;
import com.common.CheckCodeUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.LoginService;
import com.service.UserService;
import com.sun.net.httpserver.Authenticator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
@RequestMapping(value="/loginController")
public class LoginController {

    @Autowired
    LoginService loginService;

    @RequestMapping("/getCheckCode")
    public void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CheckCodeUtils verificationCode = new CheckCodeUtils();
        //获取验证码图片
        BufferedImage image = verificationCode.getImage();
        //获取验证码内容
        String text = verificationCode.getText();
        // randomCode用于保存随机产生的验证码，以便用户登录后进行验证。
        StringBuffer randomCode = new StringBuffer();
        randomCode.append(text);
        // 将验证码保存到Session中。
        HttpSession session = request.getSession();
        session.setAttribute("signcode", randomCode.toString());
        System.out.println("session-signcode==>"+randomCode.toString());
        // 禁止图像缓存。
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");
        // 将图像输出到Servlet输出流中。
        ServletOutputStream sos = response.getOutputStream();
        ImageIO.write(image, "jpeg", sos);
        sos.flush();
        sos.close();
    }

    /**
     * 验证图片验证码
     * @param request
     * @param signcode
     * @return
     */
    @RequestMapping("/checkCode")
    @ResponseBody
    public String check(HttpServletRequest request, String signcode) {
        HttpSession session = request.getSession();
        /**session中的验证码*/
        String signcodeSession = (String) session.getAttribute("signcode");
        /**前端传来的验证码*/

        if ("".equals(signcode) || signcode==null) {
            return "1";
        }
        if ("".equals(signcodeSession) || signcodeSession==null) {
            return "2";
        }
        //验证的时候不区分大小写
        if (signcode.equalsIgnoreCase(signcodeSession)) {
            System.out.println("校验验证码结束");
            return "3";
        }

        return "4";
    }

    @RequestMapping(value ="/login",produces = "application/json;charset=utf-8",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String login(HttpServletRequest request, UserInfo userInfo) throws Exception{
        HttpSession session = request.getSession();
        ObjectMapper mapper = new ObjectMapper();

        if(StringUtils.isEmpty(userInfo.getUserName())){
            userInfo.setCode("1");
            userInfo.setMsg("用户名为空");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }
        if(StringUtils.isEmpty(userInfo.getUserName())){
            userInfo.setCode("2");
            userInfo.setMsg("密码为空");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }
        UserInfo userInfo1 = loginService.getUserInfoIsExists(userInfo);

        if(userInfo1 ==null ){
            userInfo.setCode("3");
            userInfo.setMsg("用户名不存在");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }
        if(!userInfo.getPassword().equals(userInfo1.getPassword())){
            userInfo.setCode("4");
            userInfo.setMsg("密码不正确");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }
        if(userInfo.getUserName().equals(userInfo1.getUserName()) && userInfo1.getPassword().equals(userInfo.getPassword())){
            userInfo.setCode("5");
            userInfo.setMsg("登录成功");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
        }
            userInfo.setCode("6");
            userInfo.setMsg("业务异常");
            String jsonlist = mapper.writeValueAsString(userInfo);
            return jsonlist;
    }

    @RequestMapping(value ="/tiao",method = {RequestMethod.POST,RequestMethod.GET}, produces = "text/html;charset=UTF-8")
    public String tiao() throws Exception{
        System.out.println("tiaooooo");
        return  "success";
    }
}