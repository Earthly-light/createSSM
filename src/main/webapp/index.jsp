<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Insert title here</title>
    <%--<script type="javascript" src="<%=basePath%>js/jquery-3.2.1.js"></script>--%>

    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <%--<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>--%>


    <style type="text/css">
        .modal{top:30%;}

    </style>
    <script type="text/javascript">

        $(function(){
            $("#body").css("background-image","url("+"<%=basePath%>"+"/images/9.jpg)");
            //$("#body").css("background-repeat","no-repeat");
            // background-repeat:no-repeat
            totaladd();	//定时时触发的函数
            setInterval(totaladd,3000);//设置定时1000=1秒
            //登陆模态框的触发
            $('#loginButton').click(function(){
                $('#userName').val('');
                $('#password').val('');
                $('#checkCode').val('');
                $('#message').css("display","none");
                $('#message').html("");
                getCheckCode();
            })
            //注册模态框的触发
            $('#registerButton').click(function(){
                $('#register_userName').val('');
                $('#register_password').val('');
                $('#register_checkCode').val('');
                $('#register_message').css("display","none");
                $('#register_message').html("");
                getCheckCode_register();
            })
            //密码样式修改 待做
            $('#show_login').click(function(){
                $('#password').addAttr('type','text');
                $('#password').css('display','none');
            })


        })
        function totaladd(){
            var  num = Math.floor(Math.random()*8);
            var  moveheight = num *1080;
            var str = "0px "+moveheight+"px"
            $("#body").css("background-position",str);
        }


    </script>
    <script type="text/javascript">

        //用于刷新验证码
        function getCheckCode() {
            document.getElementById("checkCodeImage").src = document.getElementById("checkCodeImage").src + "?nocache=" + new Date().getTime();
        }
        //注册模态框刷新验证码           document.getElementById("register_checkCodeImage").src = document.getElementById("register_checkCodeImage").src + "?nocache=" + new Date().getTime();
        function getCheckCode_register() {
            document.getElementById("register_checkCodeImage").src = document.getElementById("register_checkCodeImage").src + "?nocache=" + new Date().getTime();
        }

        //模态框页面 点击登录 校验验证码
        function check() {
            var userName = $('#userName').val();
            var password = $('#password').val();
            var vcode = $('#checkCode').val();
            if(userName==""){
                getCheckCode();
                $('#message').css("display","block");
                $('#message').html("用户名不能为空");
                return;
            }
            if(password==""){
                console.log('检验')
                getCheckCode();
                $('#message').css("display","block");
                $('#message').html("密码不能为空");
                return;
            }
            if(vcode==""){
                getCheckCode();
                $('#message').css("display","block");
                $('#message').html("验证码不能为空");
                return;
            }
            $.ajax({
                url: "<%=basePath%>loginController/checkCode",
                type: 'GET',
                data: {
                    signcode: vcode,
                },
                dataType:"json",
                xhrFields: {
                    withCredentials: true
                },
                success: function (data) {
                    console.log("校验验证码返回值为data=="+data)
                   if("1"==data){
                       getCheckCode();
                       $('#message').css("display","block");
                       $('#message').html("验证码不能为空");
                       return;
                   }
                    if("2"==data){
                        getCheckCode();
                        $('#message').css("display","block");
                        $('#message').html("操作异常，请重新登录");
                        return;
                    }
                    if("4"==data){
                        getCheckCode();
                        $('#message').css("display","block");
                        $('#message').html("验证码不正确");
                        return;
                    }
                    if("3"==data){
                        $('#message').css("display","none");
                        $('#message').html("");
                        login(userName,password);
                    }
                }
            })
        }

        //模态框页面 点击注册 校验验证码
        function register_check() {
            var userName = $('#register_userName').val();
            var password = $('#register_password').val();
            var secondPassword = $('#register_second_password').val();
            var vcode = $('#register_checkCode').val();
            if(userName==""){
                getCheckCode_register();
                $('#register_message').css("display","block");
                $('#register_message').html("用户名不能为空");
                return;
            }
            if(password==""){
                console.log('检验')
                getCheckCode_register();
                $('#register_message').css("display","block");
                $('#register_message').html("密码不能为空");
                return;
            }
            if(secondPassword==""){
                console.log('检验')
                getCheckCode_register();
                $('#register_message').css("display","block");
                $('#register_message').html("请再次输入密码");
                return;
            }
            if(vcode==""){
                getCheckCode_register();
                $('#register_message').css("display","block");
                $('#register_message').html("验证码不能为空");
                return;
            }
            $.ajax({
                url: "<%=basePath%>loginController/checkCode",
                type: 'GET',
                data: {
                    signcode: vcode,
                },
                dataType:"json",
                xhrFields: {
                    withCredentials: true
                },
                success: function (data) {
                    console.log("校验验证码返回值为data=="+data)
                    if("1"==data){
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("验证码不能为空");
                        return;
                    }
                    if("2"==data){
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("操作异常，请重新登录");
                        return;
                    }
                    if("4"==data){
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("验证码不正确");
                        return;
                    }
                    if("3"==data){
                        $('#register_message').css("display","none");
                        $('#register_message').html("");
                        register(userName,password,secondPassword);
                    }
                }
            })
        }
/**登录校验用户名和密码*/
        function login(userName,password){
            $.post("<%=basePath%>loginController/login",
                {
                    userName: userName,
                    password:password,
                },
                function(data){
                    if(data.code=="1"){
                        console.log("用户名为空")
                        getCheckCode();
                        $('#message').css("display","block");
                        $('#message').html("用户名为空");

                    }
                    if(data.code=="2"){
                        console.log("密码为空")
                        getCheckCode();
                        $('#message').css("display","block");
                        $('#message').html("密码为空");
                    }

                    if(data.code=="3"){
                        console.log("用户名不存在")
                        getCheckCode();
                        $('#message').css("display","block");
                        $('#message').html("用户名不存在");
                    }
                    if(data.code=="4"){
                        console.log("用户名和密码不正确")
                        getCheckCode();
                        $('#message').css("display","block");
                        $('#message').html("用户名和密码不正确");
                    }
                    if(data.code=="6"){
                        console.log("业务异常")
                        getCheckCode();
                        $('#message').css("display","block");
                        $('#message').html("业务异常");
                    }
                    if(data.code=="5"){
                        console.log("登录成功")
                        window.location.href="<%=basePath%>loginController/tiao";
                    }
            })
        }

        /**注册校验用户名和密码*/
        function register(userName,password,secondPassword){
            $.post("<%=basePath%>registerController/register",
                {
                    userName: userName,
                    password:password,
                    secondPassword:secondPassword
                },
                function(data){
                    if(data.code=="1"){
                        console.log("用户名不能为空")
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("用户名不能为空");

                    }
                    if(data.code=="2"){
                        console.log("密码不能为空")
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("密码不能为空");
                    }
                    if(data.code=="7"){
                        console.log("二次输入密码为空")
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("二次输入密码为空");
                    }
                    if(data.code=="8"){
                        console.log("二次输入密码为空")
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("两次输入密码不同，请重新输入");
                    }
                    if(data.code=="3"){
                        console.log("该账户已注册")
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("该账户已注册");
                    }

                    if(data.code=="6" || data.code=="5"){
                        console.log("业务异常")
                        getCheckCode_register();
                        $('#register_message').css("display","block");
                        $('#register_message').html("业务异常");
                    }
                    if(data.code=="4"){
                        console.log("注册成功")
                       // window.location.href="<%=basePath%>registerController/";
                        $("#myModalRegister").modal('hide');
                        $("#myModal").modal('show');  //手动开启

                    }
                })
        }
    </script>

</head>
<body id="body">
    <div class="container">
        <div id="userButton"   style="width: 200px;height: 50px;width: 15%;float: left">
            <span id="loginButton" data-toggle="modal" data-target="#myModal" class="btn btn-default btn-lg glyphicon glyphicon-log-in"> 用户登录</span>
        </div>

        <div id="registerUserButton"   style="width: 200px;height: 50px;width: 15%;float: left;">
            <span id="registerButton" data-toggle="modal" data-target="#myModalRegister" class="btn btn-default btn-lg glyphicon glyphicon-user"> 用户注册</span>
        </div>

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel">
                           登录
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div id="logon" style="display: block">
                            <div class="input-group" style="padding-bottom: 10px">
                                <span class="input-group-addon" >用户名</span>
                                <input id="userName" type="text" class="form-control" placeholder="请输入用户名" aria-describedby="basic-addon1">

                            </div>
                            <div class="input-group" style="padding-bottom: 10px">
                                <span class="input-group-addon">密&emsp;码</span>
                                <input  id="password" type="password" class="form-control" placeholder="请输入密码"  aria-describedby="basic-addon1" style="display:block;z-index:9;float: left" >
                                <span id="show_login" class="glyphicon glyphicon-eye-close" style="display:block;z-index:10;float: left;margin-left: -5%;margin-top: 2%"></span>
                                <span id="hide_login" class="glyphicon glyphicon-eye-open" style="display:none;z-index:10;float: left;margin-left: -5%;margin-top: 2%"></span>
                            </div>
                            <div class="input-group"  style="padding-bottom: 10px">
                                <span class="input-group-addon" >验证码</span>
                                <%--nocache=" + new Date().getTime()--%>
                                <input id="checkCode" type="text" class="form-control " placeholder="请输入图形验证码" aria-describedby="basic-addon1" style="width:50%">
                                <img id="checkCodeImage" src="<%=basePath%>loginController/getCheckCode"  alt="图片加载失败" onclick="getCheckCode()" style="width: 100px;height: 30px;margin-left: 5%" >
                            </div>
                            <div class="input-group" >
                                <span id="message" class="bg-info" style="display: none" aria-describedby="basic-addon1" ></span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button onclick="check()" type="button" class="btn btn-primary">
                            登录
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>

        <div class="modal fade" id="myModalRegister" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="registerAccount">
                            注册
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div id="register" style="display: block">
                            <div class="input-group" style="padding-bottom: 10px">
                                <span class="input-group-addon" >用户名</span>
                                <input id="register_userName" type="text" class="form-control" placeholder="请输入用户名" aria-describedby="basic-addon1">

                            </div>
                            <div class="input-group" style="padding-bottom: 10px">
                                <span class="input-group-addon">密&emsp;码</span>
                                <input  id="register_password" type="text" class="form-control" placeholder="请输入密码" aria-describedby="basic-addon1">
                            </div>
                            <div class="input-group" style="padding-bottom: 10px">
                                <span class="input-group-addon">密&emsp;码</span>
                                <input  id="register_second_password" type="text" class="form-control" placeholder="请输入密码" aria-describedby="basic-addon1">
                            </div>
                            <div class="input-group"  style="padding-bottom: 10px">
                                <span class="input-group-addon" >验证码</span>
                                <input id="register_checkCode" type="text" class="form-control " placeholder="请输入图形验证码" aria-describedby="basic-addon1" style="width:50%">
                                <img id="register_checkCodeImage" src="<%=basePath%>loginController/getCheckCode"  alt="图片加载失败" onclick="getCheckCode_register()" style="width: 100px;height: 30px;margin-left: 5%" >
                            </div>
                            <div class="input-group" >
                                <span id="register_message" class="bg-info" style="display: none" aria-describedby="basic-addon1" ></span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button onclick="register_check()" type="button" class="btn btn-primary">
                            注册
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>

    </div>


</body>
</html>
