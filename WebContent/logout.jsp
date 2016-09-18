<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String realPath = request.getRealPath("/");
%>
<script type="text/javascript">
    function goto()
    {
        window.location.href = '<%=basePath %>';
    }
</script>
</head>
<body>
<h1>注销成功</h1>
<button class="button" id="add123" onclick="goto();">重新登录</button>
</body>
</html>