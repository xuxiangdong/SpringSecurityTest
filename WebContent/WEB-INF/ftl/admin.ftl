<@override name="popTitle">   
admin-title
</@override>
<@override name="script">
	<script type="text/javascript">
		$(function () { 
				 $('#tabs').addtabs({monitor:'.topbar'});
				 addHomePage($('#00001C3E472EFED3C8B715581C7B67AC').find('a'));
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
			  /*display: none;*/
			}
			@media (min-width: 768px) {
			  .sidebar {
			    position: fixed;
			    top: 51px;
			    bottom: 0;
			    left: 0;
			    z-index: 1000;
			    display: block;
			    padding: 20px;    PADDING-LEFT: 5PX;
    PADDING-RIGHT: 5PX;
			    overflow-x: hidden;
			    overflow-y: scroll; /*auto Scrollable contents if viewport is shorter than content. */
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
			  /*padding: 5px;*/
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
		
		
		
		
		
		   html {
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        body {
            font-family: 'Microsoft Yahei', '微软雅黑', '宋体', \5b8b\4f53, Tahoma, Arial, Helvetica, STHeiti;
            margin: 0;
        }

        .main-nav {
            margin-left: 1px;
        }

            .main-nav.nav-tabs.nav-stacked > li {
            }

                .main-nav.nav-tabs.nav-stacked > li > a {
                    padding: 10px 8px;
                    font-size: 12px;
                    font-weight: 600;
                    color: #4A515B;
                    background: #E9E9E9;
                    background: -moz-linear-gradient(top, #FAFAFA 0%, #E9E9E9 100%);
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FAFAFA), color-stop(100%,#E9E9E9));
                    background: -webkit-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                    background: -o-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                    background: -ms-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                    background: linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9');
                    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9')";
                    border: 1px solid #D5D5D5;
                    border-radius: 4px;
                }

                    .main-nav.nav-tabs.nav-stacked > li > a > span {
                        color: #4A515B;
                    }

                .main-nav.nav-tabs.nav-stacked > li.active > a, .main-nav.nav-tabs.nav-stacked > li > a:hover {
                    color: #FFF;
                    background: #3C4049;
                    background: -moz-linear-gradient(top, #4A515B 0%, #3C4049 100%);
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#4A515B), color-stop(100%,#3C4049));
                    background: -webkit-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: -o-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: -ms-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049');
                    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049')";
                    border-color: #2B2E33;
                }

                    .main-nav.nav-tabs.nav-stacked > li.active > a, .main-nav.nav-tabs.nav-stacked > li > a:hover > span {
                        color: #FFF;
                    }

            .main-nav.nav-tabs.nav-stacked > li {
                margin-bottom: 4px;
            }

        .nav-header.collapsed > span.glyphicon-chevron-toggle:before {
            content: "\e114";
        }

        .nav-header > span.glyphicon-chevron-toggle:before {
            content: "\e113";
        }

        footer.duomi-page-footer {
            background-color: white;
        }

            footer.duomi-page-footer .beta-message {
                color: #a4a4a4;
            }

                footer.duomi-page-footer .beta-message a {
                    color: #53a2e4;
                }

            footer.duomi-page-footer .list-inline a, footer.authenticated-footer .list-inline li {
                color: #a4a4a4;
                padding-bottom: 30px;
            }




        footer.duomi-page-footer {
            background-color: white;
        }

            footer.duomi-page-footer .beta-message {
                color: #a4a4a4;
            }

                footer.duomi-page-footer .beta-message a {
                    color: #53a2e4;
                }

            footer.duomi-page-footer .list-inline a, footer.authenticated-footer .list-inline li {
                color: #a4a4a4;
                padding-bottom: 30px;
            }

        /*********************************************自定义部分*********************************************/
        .nav-tabs > li > a {padding: 5px 15px 3px 5px;}
        .nav-tabs > li > i:hover{border: 1px #428bca solid;}
        .secondmenu a {
            font-size: 12px;
            color: #4A515B;
            text-align: center;
            border-radius: 4px;
        }

        .secondmenu > li > a:hover {
            background-color: #6f7782;
            border-color: #428bca;
            color: #fff;
        }

        .secondmenu li.active {
            background-color: #6f7782;
            border-color: #428bca;
            border-radius: 4px;
        }

            .secondmenu li.active > a {
                color: #ffffff;
            }

        .navbar-static-top {
            background-color: #212121;
            margin-bottom: 5px;
        }

        .navbar-brand {
            /*background: url('http://static-res.ruyo.net/ruyo_net_w_32.png') no-repeat 10px 8px;*/
            display: inline-block;
            vertical-align: middle;
            padding-left: 50px;
            color: #fff;
        }

            .navbar-brand:hover {
                color: #fff;
            }


        .collapse.glyphicon-chevron-toggle, .glyphicon-chevron-toggle:before {
            content: "\e113";
        }

        .collapsed.glyphicon-chevron-toggle:before {
            content: "\e114";}	
            .tabs {    margin-left: -20px;
    margin-right: -20px;}		
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
	            <li><a href="${(rc.contextPath)!}/j_spring_security_logout">注销</a></li>
	            <li>
		              <img src="resources/images/2.jpg" style="height:35px;width:35px;    margin-top: 8px;margin-left: 8px;"class="img-circle"  alt="Generic placeholder thumbnail">
		             
				</li>
				 <li class="dropdown">
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">更多<span class="caret"></span></a>
	                <ul class="dropdown-menu">
	                  <li><a href="#">Action</a></li>
	                  <li><a href="#">Another action</a></li>
	                  <li><a href="#">Something else here</a></li>
	                  <li role="separator" class="divider"></li>
	                  <li class="dropdown-header">Nav header</li>
	                  <li><a href="#">Separated link</a></li>
	                  <li><a href="#">One more separated link</a></li>
	                </ul>
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
		         
				<#if menu??><#--menu为树形菜单的根节点-->
				<ul id="main-nav" class="main-nav nav nav-tabs nav-stacked" style="">
					<#list menu.CHILDREN as item>
						<li id="${(item.ID)!}" <#if (item.URL??) && (""!=item.URL)>url="${(item.URL)!}" data-leaf="true" data-addtab="${(item.ID)!}" title="${(item.TITLE)!}"</#if> >
	                        <a href="#<#if (item.CHILDREN?size > 0)>${item.ID}_href</#if>" <#if (item.CHILDREN?size > 0)>onclick="addHomePage(this);" class="nav-header collapsed" data-toggle="collapse" </#if> >
	                            ${(item.ICON)!}
	                            ${(item.TITLE)!}
	                            <#if (item.CHILDREN?size > 0)><span class="pull-right glyphicon glyphicon-chevron-toggle"></span></#if>
	                         </a>
	                            <#if (item.CHILDREN?size > 0) >
	                            	 <ul id="${item.ID}_href" class="nav nav-list secondmenu collapse" style="height: 0px;">
					                           <#list item.CHILDREN as item2>
												<li id="${(item2.id)!}" <#if (item2.URL??) && (""!=item2.URL)>url="${(item2.URL)!}"  data-leaf="true" data-addtab="${(item2.ID)!}" title="${(item2.TITLE)!}"</#if>>
					                            	<a <#if (item.CHILDREN?size > 0)>onclick="addHomePage(this);"</#if> href="#">
					                            		${(item2.ICON)!}
					                            		&nbsp;${(item2.TITLE)!}
					                            	</a>
					                            </li>
					                            </#list>
					                  </ul>
	                            </#if>			
	                        
	                    </li>
					</#list>
				</ul>
				</#if>
<#--


									 <ul id="main-nav" class="main-nav nav nav-tabs nav-stacked" style="">
					                    <li id="00001C3E472EFED3C8B715581C7B67AC" data-leaf="true" data-addtab="00001C3E472EFED3C8B715581C7B67AC" title="首页">
					                        <a href="#" onclick="addHomePage(this);">
					                            <i class="glyphicon glyphicon-th-large"></i>
					                            首页 		
					                        </a>
					                    </li>
					                   <li id="00001C3E472EFED3C8B715581C7B67AB" url="/home" data-leaf="false" data-addtab="00001C3E472EFED3C8B715581C7B67AB" title="系统管理">
					                        <a href="#systemSetting" onclick="addHomePage(this);" class="nav-header collapsed" data-toggle="collapse">
					                            <i class="glyphicon glyphicon-cog"></i>
					                            系统管理
					                            
					                            <span class="pull-right glyphicon glyphicon-chevron-toggle"></span>
					                        </a>
					                        <ul id="systemSetting" class="nav nav-list secondmenu collapse" style="height: 0px;">
					                            <li id="00001C3E472EFED3C8B715581C7B67AD" url="/userManager"  data-leaf="true" data-addtab="00001C3E472EFED3C8B715581C7B67AD" title="用户管理">
					                            	<a onclick="addHomePage(this);" href="#">
					                            		<i class="glyphicon glyphicon-user"> </i>
					                            		&nbsp;用户管理
					                            	</a>
					                            </li>
					                            <li id="00001C3E472EFED3C8B715581C7B67EE" url="/resourceManager"  data-leaf="true" data-addtab="00001C3E472EFED3C8B715581C7B67EE" title="资源管理">
					                            	<a onclick="addHomePage(this);"  href="#"><i class="glyphicon glyphicon-th-list"> </i>&nbsp;资源管理</a></li>
					                            <li id="00001C3E472EFED3C8B715581C7B67QQ" url="/roleManager"  data-leaf="true" data-addtab="00001C3E472EFED3C8B715581C7B67QQ" title="角色管理">
					                            <a onclick="addHomePage(this);"  href="#"><i class="glyphicon glyphicon-asterisk"> </i>&nbsp;角色管理</a></li>
					                            <li><a href="#"><i class="glyphicon glyphicon-th-list"> </i>&nbsp;菜单管理</a></li>
					                            <li><a href="#"><i class="glyphicon glyphicon-edit"> </i>&nbsp;修改密码</a></li>
					                            <li><a href="#"><i class="glyphicon glyphicon-eye-open"> </i>&nbsp;日志查看</a></li>
					                        </ul>
					                    </li>
					                    <li>
					                        <a href="#configSetting" class="nav-header" data-toggle="collapse">
					                            <i class="glyphicon glyphicon-credit-card"></i>
					                            配置管理	
					                                   <span class="pull-right glyphicon  glyphicon-chevron-toggle"></span>
					                        </a>
					                        <ul id="configSetting" class="nav nav-list secondmenu collapse in">
					                            <li class="active"><a href="#"><i class="glyphicon glyphicon-globe"></i>&nbsp;全局缺省配置</a></li>
					                            <li><a href="#"><i class="glyphicon glyphicon-star-empty"></i>&nbsp;未开通用户配置</a></li>
					                            <li><a href="#"><i class="glyphicon glyphicon-star"></i>&nbsp;退订用户配置</a></li>
					                            <li><a href="#"><i class="glyphicon glyphicon-text-width"></i>&nbsp;试用用户配置</a></li>
					                            <li><a href="#"><i class="glyphicon glyphicon-ok-circle"></i>&nbsp;开通用户配置</a></li>
					                        </ul>
					                    </li>
					
					                    <li>
					                        <a href="#disSetting" class="nav-header" data-toggle="collapse">
					                            <i class="glyphicon glyphicon-globe"></i>
					                            分发配置
												 <span class="pull-right glyphicon glyphicon-chevron-toggle"></span>
					                        </a>
					                        <ul id="disSetting" class="nav nav-list secondmenu collapse in">
					                            <li><a href="#"><i class="glyphicon glyphicon-th-list"></i>&nbsp;分发包配置</a></li>
					                        </ul>
					                    </li>
					
					                    <li>
					                        <a href="#dicSetting" class="nav-header" data-toggle="collapse">
					                            <i class="glyphicon glyphicon-bold"></i>
					                            字典配置
					                            <span class="pull-right glyphicon glyphicon-chevron-toggle"></span>
					                        </a>
					                        <ul id="dicSetting" class="nav nav-list secondmenu collapse in">
					                            <li><a href="#"><i class="glyphicon glyphicon-text-width"></i>&nbsp;关键字配置</a></li>
					                        </ul>
					                    </li>
					                    <li>
					                        <a href="#">
					                            <i class="glyphicon glyphicon-fire"></i>
					                            关于系统
					                            <span class="badge pull-right">1</span>
					                        </a>
					                    </li>
					
					                </ul>


-->
























		          
		        </div>
		        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		        <!--<ol class="breadcrumb" style="margin-bottom:0px;"><li>系统管理</li><li>用户管理</li></ol>-->
		        <!--
			          <h4 class="page-header" style=" position: fixed;top: 10px;padding-top:20px;width: 100%;background-color: #f5f5f5;">权限管理</h4>
			         
			          <div class="row placeholders" > -->
			          		<div id="topbar" class="col-md-12">
			          		
			          		<div id="tabs" class="tabs">
			          			
				                <!-- Nav tabs -->
				                <ul class="nav nav-tabs" role="tablist">
				                   <!-- <li role="presentation" id="tab_home" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a><i class="close-tab glyphicon glyphicon-remove" style="display: none;"> </i></li>    
				                   -->
									<li ><a id="close_all" role="tab"><i class="glyphicon glyphicon-remove" style="display: block;height:20px;"></i></a></li>  
				                </ul>
				                <!-- Tab panes -->
				                <div class="tab-content">
				                                       
				                </div>
				
				            </div>
			          		
			          		</div>
			          		
			          		
			          		
			          		
			          		
			          	
			          <!--</div>-->
		         </div>
		    </div>
		</div>			
	<#-- <footer style=" position: fixed;bottom: 0;width: 100%;text-align:center;background-color: #f5f5f5;">
	      <div class="container">
	        <p style="margin: 20px 0;font-size: 12px;">© 杭州三汇信息技术有限公司</p>
	      </div>
    </footer>-->
	<script type="text/javascript">
		var opt = {
			target:null,
			url:"http://localhost:8080/SpringSecurityTest/upload/"
			,type:"POST"
			,dataType:"json"
			,success:function(){
			alert(111);
			}};
		var f = $("#uploadfiledemo");
		function tc(username)
		{
		var p = {};
		p.username = username;
			$.ajax({
			type : 'POST',
			dataType : "text",
			contentType : "application/json;charset=gbk",
			url : path + '/test',
			data : JSON.stringify(p),
			success:function(msg)
		        {
		        alert("success");
		        },
		    error:function(msg){
		    	alert("error");
		        }
		});	
		}
		
		function addHomePage(_this)
		{
			
			/*getPath(rMenu,$(_this).parent().attr('id'));
			menuPath.shift();
			for(var i=0;i<menuPath.length;i++)
			{
				console.info(menuPath[i].label);
			}*/
			if($(_this).parent().attr('data-leaf')=='true')
			{
			 Addtabs.add({
				            id: $(_this).parent().attr('data-addtab'),
				            title: $(_this).parent().attr('title') ? $(_this).parent().attr('title') : '',
				            //content: 'content',
				            url: path+($(_this).parent().attr('url')?$(_this).parent().attr('url'):'/home'),
				            ajax: false,
				            iframeUse:true
        				});
        	}
		}
		function getAllMenu(u,parentid)
		{
			var x = [];
			var lis = $(u).children('li');
			for(var i = 0 ;i<lis.length;i++)
			{
				var l = $(lis[i]);
				var n = {};
				n.parentid = parentid;
				n.id = l.attr('id');
				n.label = l.attr('title');
				if(l.children('ul').length>0)
				{
					n.children = getAllMenu(l.children('ul'),n.id);
				}
				else
				{
					n.children = [];
				}
				x.push(n);
			}
			return x;
		}
		var menuPath = [];
			var rootChildren = getAllMenu($("#main-nav"),'rootid');
			var rMenu = {};rMenu.parentid=undefined;rMenu.id ='rootid';rMenu.label = undefined;rMenu.children = rootChildren;
		function getPath(rootNode,id)
		{
			console.info(rootNode.id);
			menuPath.push(rootNode);
			if(id==rootNode.id)
			{
				return;
			}
			else if(rootNode.children == undefined || rootNode.children.length==0)
			{
				menuPath.pop();
				return ;
			}
			else 
			{
				for(var i =0;i<rootNode.children.length;i++)
				{
					getPath(rootNode.children[i],id);
				}
				menuPath.pop();
				return ;
			}
		}
	</script>
 </@override> 
<@extends name="base/bootstrap_template.ftl"/>