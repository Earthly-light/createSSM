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
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/zTreeStyle/zTreeStyle.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.css">
    <%--<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>--%>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.2.1.js"></script>

    <script type="text/javascript">
        $(function(){
            $("#body2").css("background-image","url("+"<%=basePath%>"+"/images/9.jpg)");

            totaladd();	//定时时触发的函数
            setInterval(totaladd,3000);//设置定时1000=1秒

        })
        function totaladd(){
            var  num = Math.floor(Math.random()*7);
            var  moveheight = num *1040;
            var str = "0px "+moveheight+"px"
            $("#body2").css("background-position",str);
        }

    </script>
</head>
<body id="body2">
<div >

</div>

</body>
</html>
