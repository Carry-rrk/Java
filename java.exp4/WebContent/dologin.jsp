<!-- 2020-Spring rrk -->
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%! boolean flag = false;//标记用户名密码是否正确
	String name = null;
	String password = null;
%>
	<%
	 String string1 = null;//文件的读入与检查
	 String[] STR1 = null;
	 request.setCharacterEncoding("UTF-8");
	 name = request.getParameter("username");
	 password = request.getParameter("userpassword");
	 File file1 = new File("D:\\桌面\\Code\\Java\\FOUR EXP\\src\\user.txt");//绝对路径，更改环境要改
	 FileReader fileReader1 = new FileReader(file1);
	 BufferedReader bufferedReader1 = new BufferedReader(fileReader1);
	search: do{
		 string1 = bufferedReader1.readLine();
		 if(string1!=null){
			STR1 = string1.split("\t");
			 if(STR1[0].equals(name)&&STR1[1].equals(password)){
				 flag = true;
				 break search;
			 }
		 }
	 }while(string1!=null);
	 bufferedReader1.close();
	 fileReader1.close();
	%>
	<!-- 正确错误的相关处理 -->
	<%if(!flag){ %>
	<script>
	alert("用户名或密码错误");
	window.location.href="login.jsp"
	</script>
    <% }else{
     out.print("登录成功"+"<br/>");
     out.print(STR1[0]+",你好"+"<br/>");
    }%>
</body>
</html>