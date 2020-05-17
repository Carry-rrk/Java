<!-- 2020-Spring rrk -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录系统</title>
</head>
<body>
<div align="center" >
<h1 align="center" style="color: dimgray"> 欢迎进入登录系统 </h1>
	<!-- 标题以及注册界面 -->
	<form name = "login" action="dologin.jsp" onsubmit="return judge(this)" >
	  	用户名: <input type="text" name="username"><br>
	 	密码: <input type="password" name="userpassword"><br>
	  <input type="submit" value="登录">
	  <input type = "button" value = "注册" onclick = "window.location.href = 'register.jsp'">
	</form> 
</div>
<!-- 下面的js函数用于判断输入框是否为空 -->
<script>
	function judge(login){
		if(login.username.value=="" || login.userpassword.value==""){
			alert("用户名或密码不能为空");
			return false;
		}else{
			return true;
		}
	}
</script>
</body>
</html>