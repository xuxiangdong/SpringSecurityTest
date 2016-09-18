<!DOCTYPE html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Bootstrap In Practice - Landing Page Example</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Bootstrap -->
    <link href="resources/css/bootstrap.css" rel="stylesheet" >
    <script src="resources/js/jquery-1.9.1.js"></script>
    <script src="resources/js/angular.js"></script>
    <!-- <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet" />

    <link href="http://fonts.googleapis.com/css?family=Abel|Open+Sans:400,600" rel="stylesheet" /> -->
	
    <style> 

        /* http://css-tricks.com/perfect-full-page-background-image/     url(resources/images/2.jpg)*/
        html {
            background:  no-repeat center center fixed; 
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        body {
            padding-top: 200px;
			padding-left:200px;position:fixed;
            font-size: 16px;
            font-family: "Open Sans",serif;
            background: transparent;
        }

        h1 {
            font-family: "Abel", Arial, sans-serif;
            font-weight: 400;
            font-size: 40px;
        }

        /* Override B3 .panel adding a subtly transparent background */
        .panel {
            background-color: rgba(95, 95, 95, 0.35);
			
			
			width:380px;
        }
		.btn2,#password,#account {
			background-color: rgba(95, 95, 95, 0.15);
			
		}
        .margin-base-vertical {
            margin: 20px 0;
        }
		.title{margin-top:-30px;}
    </style>
	<script type="text/javascript">
	if(window != top)
	{
		top.location.href = location.href;
	}
	var error = "${(params.error)!""}";
	function one(){ 
		if(error === "true")
		{
			document.getElementById("errorinfo").innerHTML = "${(params.message)!}${(SPRING_SECURITY_LAST_EXCEPTION.message)!}";
		}
	}  
	window.onload = one ;  
	 document.onkeydown=keyDownSearch;  
     
	    function keyDownSearch(e) {    
	        // 兼容FF和IE和Opera    
	        var theEvent = e || window.event;    
	        var code = theEvent.keyCode || theEvent.which || theEvent.charCode;    
	        if (code == 13) {    
	            //具体处理
	            //$("#id_login").submit();
	            login();
	            return false;    
	        }    
	        return true;    
	    }
	    function login()
	    {
	    	var p = $("#id_login").serializeArray();
	    	$.post("/SpringSecurityTest/login",$("#id_login").serializeArray(),function(result){
	    		var r = JSON.parse(result);
	    		if(r.error == true)
	    		{
	    			document.getElementById("errorinfo").innerHTML = r.message;
	    		}
	    		else
	    		{
	    			window.location.href = r.redirecturl;
	    		}
	    	});
	    }
	</script>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3 panel panel-default">
			<div id="errorinfo" style="color: red;height: 20px; margin-bottom: -40px;"></div>
                <h2 class="margin-base-vertical" style="margin-button:" ><span class="glyphicon glyphicon-user">&nbsp;</span></h2>
				<h2 class="margin-base-vertical text-center title"  style="color: white;"><strong>欢迎登录${(test)!}</strong></h2>

              

                

               <form id="id_login" class="form-horizontal" role="form" name="f" action="/SpringSecurityTest/login" method="POST">
                    <div class="form-group " style="border:0px red solid">
								<label for="inputEmail3" class="col-sm-4 control-label"  style="color: white;">账号</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="j_username" value="" placeholder="请输入账号……">
								</div>
							</div>
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-4 control-label" style="color: white;">密码</label>
								<div class="col-sm-6">
									<input type="password" class="form-control" name="j_password" placeholder="请输入密码……">
								</div>
							</div>
							<div class="form-group">
								
								 <input type="checkbox" style="margin-left: 80px;" value="true" name="_spring_security_remember_me" />
								 <span  style="color: white;"> 两周之内不必登陆</span>
							</div>
                   
                    <p class="text-center">
                        <button type="button" onclick="login();" class="btn btn-primary">登&nbsp;&nbsp;&nbsp;&nbsp;录</button>
                    </p>
                    </span>
                </form>

               

            </div><!-- //main content -->
        </div><!-- //row -->
    </div> <!-- //container -->

</body>
</html>