<!-- 2020-Spring rrk -->
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册成功</title>
</head>
<body>
<%! boolean flag = true ;
	String name = null;
	String password = null;
	String gender = null;
%>
	<%
	flag =true;//重设flag
	 String string1 = null;//文件读入检用户名是否重复
	 String[] STR1 = null;
	 request.setCharacterEncoding("UTF-8");
	 name = request.getParameter("username");
	 password = request.getParameter("userpassword");
	 gender = request.getParameter("userGender");
	 File file1 = new File("D:\\桌面\\Code\\Java\\FOUR EXP\\src\\user.txt");//绝对路径，更改环境要改
	 FileReader fileReader1 = new FileReader(file1);
	 BufferedReader bufferedReader1 = new BufferedReader(fileReader1);
	search: do{
		 string1 = bufferedReader1.readLine();
		 if(string1!=null){
			STR1 = string1.split("\t");
			 if(STR1[0].equals(name)){
				 flag = false;
				 break search;
			 }
		 }
	 }while(string1!=null);
	 bufferedReader1.close();
	 fileReader1.close();
	%>
	<!-- 不重复即写入，重复返回注册页面 -->
	<%if(!flag){%>
	<script>
	alert("用户名已存在");
	window.location.href="register.jsp"
	</script>
	<%
	}else{
	FileWriter fileWriter1 = new FileWriter(file1,true);
	PrintWriter pWriter = new PrintWriter(fileWriter1);
	pWriter.println(name+"\t"+password+"\t"+gender);
	pWriter.flush();
	pWriter.close();
	fileWriter1.close();%>
	<script>
	alert("注册成功");
	window.location.href="login.jsp"
	</script>
	<%}%>
</body>
</html>