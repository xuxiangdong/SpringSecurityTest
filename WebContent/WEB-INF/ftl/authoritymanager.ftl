<@override name="popTitle">   
admin-title
</@override>
<@override name="style">
<link rel="stylesheet" href="${(rc.contextPath)}/resources/component/ztree/css/zTreeStyle/zTreeStyle.css" />
<link rel="stylesheet" href="${(rc.contextPath)}/resources/component/dropselect/css/bootstrap-dropselect.css" />
<style>

.panel-default {
    border-color: transparent;
}
  .panel-heading   {border-color: #dddddd; padding: 5px;   border-radius: 3px;
   }
   .rightBtn {float:right;}
   .advancedQuery {    
   width:300px;
   padding-top: 20px;
    padding-left: 20px;
    padding-right: 20px;}
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
			    padding: 20px;    
				padding-left: 5px;
    			padding-right: 5px;
			    overflow-x: hidden;
			    overflow-y: scroll; /*auto Scrollable contents if viewport is shorter than content. */
			    background-color: #f5f5f5;
			    border-right: 1px solid #eee;
			  }
			}
</style>
</@override>
<@override name="script">
	<script src="${(rc.contextPath)}/resources/component/ztree/js/jquery.ztree.core.js"></script>
	<script src="${(rc.contextPath)}/resources/component/ztree/js/jquery.ztree.excheck.js"></script>
	<script src="${(rc.contextPath)}/resources/module/admin/authoritymanager.js"></script>
	<script type="text/javascript">
	
	</script>
</@override>

<@override name="body">
		<div class="panel panel-default">
            <div class="panel-heading">
				<button type="button" class="btn btn-sm btn-primary" data-loading-text="执行中..." onclick="syn_to_users(this);">同步权限到用户</button>
				<button type="button" class="btn btn-sm btn-primary" data-loading-text="执行中..." onclick="syn_to_roles(this);">同步权限到角色</button>
				<button type="button" class="btn btn-sm btn-primary" data-loading-text="执行中..." onclick="delete_to_users(this);">删除用户的权限</button>
				<button type="button" class="btn btn-sm btn-primary" data-loading-text="执行中..." onclick="">删除角色的权限</button>
              <!--<span class="panel-title">Panel title</span>-->
              	<div class="dropdown rightBtn">
              		<button type="button" class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown">高级查询</button>
	              	<div class="dropdown-menu dropdown-menu-right advancedQuery" role="menu">
	              		<!--高级查询内容区-->
	              		<form role="form" class="form-horizontal">  
			                <div class="form-group">  
			                    <label class="col-md-2 control-label" for="name">Name</label>  
			                    <div class="col-md-10">  
			                        <input class="form-control" name="name" type="text" id="name" placeholder="Name" value="" />  
			                    </div>  
			                </div>
			                <div class="form-group">  
			                    <label class="col-md-2 control-label" for="name2">Name</label>  
			                    <div class="col-md-10">  
			                        <input class="form-control" name="name2" type="text" id="name2" placeholder="Name" value="" />  
			                    </div>  
			                </div>
			                 <div class="form-group">  
			                    <div class="col-md-offset-2 col-md-10">  
			                       <button type="button" class="btn btn-sm btn-primary">重置</button>
			                       <button type="button" class="btn btn-sm btn-primary">确定</button>
			                    </div>  
                			</div>  
            			</form>   
	              	</div>
              	</div>
            </div>
            <div class="panel-body">
            
					 <div class="container-fluid">
					      <div class="row">
						        <div class="col-sm-4 col-md-3 sidebar">
									<ul id="menumanager_tree_id" class="ztree"></ul>
								</div>
			        		  	<div class="col-sm-8 col-md-9 col-sm-offset-4 col-md-offset-3 main">
			        		  			<div id="toolbar">
			        		  				<strong>用户信息</strong>
       									</div>
			        		  			<table id="menumanager_users_tb"></table>
			        		  			<div id="toolbar2">
			        		  				<strong>角色信息</strong>
       									</div>
			        		  			<table id="menumanager_roles_tb"></table>
			        		  	</div>
		        		  </div>
		        	 </div>
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
  			Panel content
            </div>
 </div>
 </@override> 
<@extends name="base/bootstrap_template.ftl"/>