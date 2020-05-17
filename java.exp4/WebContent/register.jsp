<!-- 2020-Spring rrk -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册系统</title>
</head>
<body>
<div align="center">
<!-- 标题及注册页面 -->
    <h1 align="center" style="color: dimgray"> 欢迎进入注册系统 </h1>
    <form action="doRegister.jsp" name="register" onsubmit="return judge(this)">
	  	用户名: <input type="text" name="username"><br>
	 	密码: <input type="password" name="userpassword"><br>
	 	性别：
        <input type="radio"  style="vertical-align:middle;margin-top:-2px;margin-bottom:1px;" name="userGender" id="boy" value="男"/>男
        <input type="radio"  style="vertical-align:middle;margin-top:-2px;margin-bottom:1px;" name="userGender" id="girl" value="女"/>女<br>
	  <input type="submit" value="注册">
	</form> 
</div>
<!-- 判断是否空 -->
<script>
	function judge(register){
		if(register.username.value=="" || register.userpassword.value==""){
			alert("用户名或密码不能为空");
			return false;
		}else if(document.getElementById("boy").checked!=true && document.getElementById("girl").checked!=true){
			alert("性别不为空");
			return false;
		}else{
			return true;
		}
	}
</script>
</body>
</html>