<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="xxd">
	<title><@block name="popTitle" >bootstrap_title</@block></title>
	<link rel="icon" href="${(rc.contextPath)}/resources/images/favicon.ico">  
	<link href="${(rc.contextPath)}/resources/css/bootstrap.css" rel="stylesheet" >
	<link href="${(rc.contextPath)}/resources/css/bootstrap-addtabs.css" rel="stylesheet" >
	<link href="${(rc.contextPath)}/resources/css/bootstrap-table.css" rel="stylesheet" >
	
	<script src="${(rc.contextPath)}/resources/js/jquery-1.9.1.js"></script>
	 <script src="${(rc.contextPath)}/resources/js/core.js"></script>
	 <!--<script src="${(rc.contextPath)}/resources/js/bootstrap/ie10-viewport-bug-workaround.js"></script>-->
	 <script src="${(rc.contextPath)}/resources/js/jquery.form.js"></script>
     <script src="${(rc.contextPath)}/resources/js/angular.js"></script>
	 <script src="${(rc.contextPath)}/resources/js/bootstrap/bootstrap.js"></script>
	 <script src="${(rc.contextPath)}/resources/js/bootstrap/bootstrap-addtabs.js"></script>
	 <script src="${(rc.contextPath)}/resources/js/bootstrap/bootstrap3-validation.js" type="text/javascript" ></script>  
	 <script src="${(rc.contextPath)}/resources/js/bootstrap/bootstrap-table.js"></script>
	 <script src="${(rc.contextPath)}/resources/js/bootstrap/bootstrap-table-zh-CN.js"></script>
	 <script>
	 var path = '${(rc.contextPath)}';
	 </script>
	<@block name="script" >
		
	</@block>
	<@block name="style" >
		
	</@block>
</head>
<body>

	<@block name="body" >
		<h1>base body</h1>
	</@block>
	
</body>
</html>