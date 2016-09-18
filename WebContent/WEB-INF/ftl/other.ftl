<@override name="popTitle">   
other-title
</@override>
<@override name="script">
	<script type="text/javascript">
		$(function () { 
        $('#myTab a:last').tab('show');//初始化显示哪个tab 
      
        $('#myTab a').click(function (e) { 
          e.preventDefault();//阻止a链接的跳转行为 
          $(this).tab('show');//显示当前选中的链接及关联的content 
        }); 
      }); 
	</script>
</@override>
<@override name="style">
	<style type="text/css">
		body {
			 	padding-top: 50px;
			 }
			 .sub-header {
		  padding-bottom: 10px;
		  border-bottom: 1px solid #eee;
		}
		.navbar-fixed-top {
		  border: 0;
		}
		.sidebar {
			  display: none;
			}
			@media (min-width: 768px) {
			  .sidebar {
			    position: fixed;
			    top: 51px;
			    bottom: 0;
			    left: 0;
			    z-index: 1000;
			    display: block;
			    padding: 20px;
			    overflow-x: hidden;
			    overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
			    background-color: #f5f5f5;
			    border-right: 1px solid #eee;
			  }
			}
			
			/* Sidebar navigation */
			.nav-sidebar {
			  margin-right: -21px; /* 20px padding + 1px border */
			  margin-bottom: 20px;
			  margin-left: -20px;
			}
			.nav-sidebar > li > a {
			  padding-right: 20px;
			  padding-left: 20px;
			}
			.nav-sidebar > .active > a,
			.nav-sidebar > .active > a:hover,
			.nav-sidebar > .active > a:focus {
			  color: #fff;
			  background-color: #428bca;
			}
			
			
			/*
			 * Main content
			 */
			
			.main {
			  padding: 20px;
			}
			@media (min-width: 768px) {
			  .main {
			    /*padding-right: 40px;
			    padding-left: 40px;
			    */
			  }
			}
			.main .page-header {
			  /*margin-top: 0;*/
			}
			
			
			/*
			 * Placeholder dashboard ideas
			 */
			
			.placeholders {
			  margin-bottom: 40px;
			  padding-top: 35px;
			  text-align: center;
			  padding-left: 10px;
			}
			.placeholders h4 {
			  margin-bottom: 0;
			}
			.placeholder {
			  margin-bottom: 20px;
			}
			.placeholder img {
			  display: inline-block;
			  border-radius: 50%;
			}
					
	</style>
</@override>
<@override name="body">  
	    <nav class="navbar navbar-inverse navbar-fixed-top">
	      <div class="container-fluid">
	        <div class="navbar-header">
	          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	          </button>
	          <a class="navbar-brand" href="#">基础框架平台</a>
	        </div>
	        <div id="navbar" class="navbar-collapse collapse">
	          <ul class="nav navbar-nav navbar-right">
	            <li><a href="#">Dashboard</a></li>
	            <li><a href="#">设置</a></li>
	            <li><a href="#">Profile</a></li>
	            <li><a href="#">帮助</a></li>
	            <li>
		              <img src="resources/images/2.jpg" style="margin-bottom:-30px;height:35px;width:35px;border-radius:50%;"  alt="Generic placeholder thumbnail">
		             
				</li>
	          </ul>
	          <form class="navbar-form navbar-right">
	            <input type="text" class="form-control" placeholder="Search...">
	          </form>
	        </div>
	      </div>
	    </nav>
	
	
	
	
	
		 <div class="container-fluid">
		      <div class="row">
		        <div class="col-sm-3 col-md-2 sidebar">
		          <ul class="nav nav-sidebar">
		            <li class="active"><a href="#">权限管理</a></li>
		            <li><a href="#">菜单管理</a></li>
		            <li><a href="#">角色管理</a></li>
		            <li><a href="#">用户管理</a></li>
		          </ul>
		          
		        </div>
		        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			          <h4 class="page-header" style=" position: fixed;top: 10px;padding-top:20px;width: 100%;background-color: #f5f5f5;">权限管理</h4>
			          <div class="row placeholders" >
			          		<ul class="nav nav-tabs" id="myTab"> 
						      <li class="active"><a href="#home">Home</a></li> 
						      <li><a href="#profile">Profile</a></li> 
						      <li><a href="#messages">Messages</a></li> 
						      <li><a href="#settings">Settings</a></li> 
						    </ul> 
						       
						    <div class="tab-content"> 
						      <div class="tab-pane active" id="home">aaaaaaaaaaaaaaaaaaaaaa<i class="fa fa-camera-retro fa-lg"></i></div> 
						      <div class="tab-pane" id="profile">bbbbbbbbbbbbbbb</div> 
						      <div class="tab-pane" id="messages">ccccccccccccc</div> 
						      <div class="tab-pane" id="settings">dddddddddddddddddd</div> 
						    </div> 
			          </div>
		         </div>
		    </div>
		</div>			
	 <footer style=" position: fixed;bottom: 0;width: 100%;text-align:center;background-color: #f5f5f5;">
	      <div class="container">
	        <p style="margin: 20px 0;font-size: 12px;">© 杭州三汇信息技术有限公司</p>
	      </div>
    </footer>
	
</@override>  
	
<@extends name="base/bootstrap_template.ftl"/>
	