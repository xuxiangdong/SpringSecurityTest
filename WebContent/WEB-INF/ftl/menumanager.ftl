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
			
			
			
			.dropselect > li > a,
			.dropselect > .dropselect-list > li > a {
				 			padding: inherit;
				    		display: -webkit-inline-box;
				}
				.dropdown-menu > .dropselect-list
				{ 
					    padding-top: 10px;
    					padding-bottom: 10px;
				}	
</style>
</@override>
<@override name="script">
	<script src="${(rc.contextPath)}/resources/component/ztree/js/jquery.ztree.core.js"></script>
	<script src="${(rc.contextPath)}/resources/component/dropselect/js/bootstrap-dropselect.js"></script>
	<script type="text/javascript">
		$(function () { 
		/*****表单校验初始化*****/
		$("#modal_menumanager_dialog").validation(function(obj, params) {
				//console.info(params);
				//console.info(obj.name);
				if (obj.name == 'mail') {
					/*
					 * $.post("/verifymail",{mail :$(obj).val()},function(data){
					 * params.err = !data.success; params.msg = data.msg; });
					 */
				}
			}, {

				validRules : [{
							name : 'required',
							validate : function(value) {
								return ($.trim(value) == '');
							},
							defaultMsg : '请输入内容'
						},
						// {name: 'number', validate: function(value) {return
						// (!/^[0-9]\d*$/.test(value));}, defaultMsg: '请输入数字。'},
						 {
							name : 'mymobile',
							validate : function(value) {
								return (!/^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/
										.test(value));
							},
							defaultMsg : '请输入正确的手机号'
						}, {
							name : 'myID',
							validate : function(value) {
								return (!/^\d{17}[\d|X|x]$/.test(value));
							},
							defaultMsg : '请输入正确的身份证号'
						},{
							name : 'length255',
							validate : function(value) {
								var v = value.replace(/[^\x00-\xff]/g, "xx");
								if(v.length > 255){
									return true;
								}else{
									return false;
								}
//								return (value.replace(/[^\x00-\xff]/g, "xx").test(value));
							},
							defaultMsg : '输入长度不允许超过255个字符'
						},{
							name : 'length50',
							validate : function(value) {
								var v = value.replace(/[^\x00-\xff]/g, "xx");
								if(v.length > 50){
									return true;
								}else{
									return false;
								}
//								return (value.replace(/[^\x00-\xff]/g, "xx").test(value));
							},
							defaultMsg : '输入长度不允许超过50个字符'
						},{
							name : 'length100',
							validate : function(value) {
								var v = value.replace(/[^\x00-\xff]/g, "xx");
								if(v.length > 100){
									return true;
								}else{
									return false;
								}
//								return (value.replace(/[^\x00-\xff]/g, "xx").test(value));
							},
							defaultMsg : '输入长度不允许超过100个字符'
						},{
							name : 'length20',
							validate : function(value) {
								var v = value.replace(/[^\x00-\xff]/g, "xx");
								if(v.length > 20){
									return true;
								}else{
									return false;
								}
//								return (value.replace(/[^\x00-\xff]/g, "xx").test(value));
							},
							defaultMsg : '输入长度不允许超过20个字符'
						},{
							name : 'length1000',
							validate : function(value) {
								var v = value.replace(/[^\x00-\xff]/g, "xx");
								if(v.length > 1000){
									return true;
								}else{
									return false;
								}
//								return (value.replace(/[^\x00-\xff]/g, "xx").test(value));
							},
							defaultMsg : '输入长度不允许超过1000个字符'
						},{
				            	  name : 'timeCheck',
				            	  validate : function(value) {
				            	  		if($.trim(value)==''){
				            	  			return false;
				            	  		}else{
				            	  			var v = ( !/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29) (?:[01]\d|2[0-3])(?::[0-5]\d){2}$/.test(value));
				            	  			if(v==true){
				            	  				return true;
				            	  			}
				            	  		}
				            	  		return false;
				            	  },
				            	  defaultMsg : '输入日期不正确'
				            }
				],

				reqmark : false,
				icon : false
			});
		
		/***获取tree***/
		var zNodes =[];
		$.post(path+'/adminManager/getMenuTree',{},function(r){
					var zNodes = [];
					if(r.status==200)
					{
						zNodes = r.data;
					}
					var setting = {data: {  
									        key: {   name:'title',url:"url2" }  
									        ,simpleData:{
									        idKey:"id",
									        pIdKey:"parentid"
									        }
									    }
									,callback:{onClick:function(event, treeId, treeNode){
									var appElement = document.querySelector('[ng-controller=MainCtrl]');//获得绑定controllerdom节点
									var $scope = angular.element(appElement).scope().update(treeNode); //获得$scope对象
									}}  
							    };
					var treeObj = $.fn.zTree.init($("#menumanager_tree_id"),setting, zNodes);
					treeObj.expandAll(true);
					var setting2 = {data: {  
									        key: {   name:'title',url:"url2" }  
									        ,simpleData:{
									        idKey:"id",
									        pIdKey:"parentid"
									        }
									    }
									,callback:{onClick:function(event, treeId, treeNode){
									var appElement = document.querySelector('[ng-controller=MainCtrl2]');//获得绑定controllerdom节点
									var $scope = angular.element(appElement).scope().update(treeNode); //获得$scope对象
									}}  
							    };
					var treeObj2 = $.fn.zTree.init($("#dropselect"),setting2, zNodes);
					treeObj2.expandAll(true);
					initSelect();
			});
			
			
			
			//bootstrap-select
			function initSelect()
			{
				$test = $('#dropselect').dropselect({
		        onchange: function(e) {
		          if (typeof e.selectedItem != 'undefined') {
		            var item = e.selectedItem;
		            if (item.value == 'destroy') {
		              e.destroy();
		            } else {
		              $('#dropselect-label').html(item.value);
		            }
		          } else {
		            $('#dropselect-label').html('Click Me!');
		          }
		        },
		        filter: true,
		        clear: false,
		        icons:false,
		        width:'inherit'
		  		});
			}
			
			
      	}); 
      	
      	/*************************angular.js测试***************************/
      	var app=angular.module("app",[]);
		app.controller('MainCtrl', function($scope, $http, $sce) {
		    $scope.user = { name: "Fox" };
			$scope.update = function (data) {
					    $scope.user = data;
					    $scope.user.icon =
					    ((typeof data.icon=='string')&&(data.icon.constructor==String))?
					     $sce.trustAsHtml($scope.user.icon): $scope.user.icon;
					    $scope.$apply();
					}
		      
		    });
			app.controller('MainCtrl2', function($scope, $http, $sce) {
			var treeObj = $.fn.zTree.getZTreeObj("menumanager_tree_id");
		    $scope.update = function (data) {
					    $scope.selectParentNode = data;
					    $scope.$apply();
					}
		    }); 
		    
		    function menumanager_open_dialog()
		    {
			    //var appElement = document.querySelector('[ng-controller=TestCtrl]');//获得绑定controllerdom节点
						
			    $('#modal_menumanager_dialog').modal({backdrop: 'static', keyboard: false});
		    }
		    function menumanager_addMenu(_this)
		    {
		    		$(_this).button('loading');
					 if ($("#modal_menumanager_dialog").valid() == true) 
					 {
						var param = {};
						var data = $("#modal_menumanager_add_form_id").serializeArray();
						for (var i = 0; i < data.length; i++) 
						{
							param[data[i].name] = data[i].value;
						}
						var treeObj2 = $.fn.zTree.getZTreeObj("dropselect");
						var parents = treeObj2.getSelectedNodes()
						if(parents.length==0)
						{
							alert("请选择一个父菜单！");
							return;
						}
						param.parentid = parents[0].id; 
						$.post(path+'/adminManager/addMenu',param,function(r)
						{
							if(r.success=='true')
							{
								var treeObj = $.fn.zTree.getZTreeObj("menumanager_tree_id");
								treeObj.refresh();
								var treeObj2 = $.fn.zTree.getZTreeObj("dropselect");
								treeObj2.refresh();
							}
							$("#modal_menumanager_dialog").modal("hide");
							alert(r.message);
						}).always(function() {
					    $(_this).button('reset');
						});
						
						return false;
					} else {
					//页面校验失败
					 $(_this).button('reset');
					}
			 }
		    /****************************test**************************************/
	</script>
</@override>

<@override name="body"><div  ng-app="app">
		<div class="panel panel-default">
            <div class="panel-heading">
				<button type="button" class="btn btn-sm btn-primary" onclick="menumanager_open_dialog();">添加</button>
				<button type="button" class="btn btn-sm btn-primary">修改</button>
				<button type="button" class="btn btn-sm btn-primary" onclick="menumanager_delete();">删除</button>
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
		        		  		



								     
									<div ng-controller="MainCtrl" class="table-responsive">
									  <table class="table  table-bordered">
									    	 <thead>
											    <tr>
											        <th>名称</th>
											        <th>父菜单</th>
											        <th>URL</th>
											        <th>图标</th>
											    </tr>
											    </thead>
											 <tbody>
											    <tr id="tr-id-1" class="tr-class-1">
											        <td ng-bind="user.title"></td>
											        <td ng-bind="user.parentid"></td>
											        <td ng-bind="user.url"></td>
											        <td ng-bind-html="user.icon"></td>
											    </tr>
											  </tbody>
									  </table>
									</div>














		        		  	</div>
		        		  </div>
		        	 </div>

  Panel content
            </div>
          </div>
          
          
          
          
          
          	<!-- 添加用户信息模态框 -->
			<div  id="modal_menumanager_dialog" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
				<div class="modal-dialog">
	    			<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h5 class="modal-title" id="myModalLabel">添加菜单</h5>
						 </div>
	 					<div class="modal-body" style="">
	 						 <form id="modal_menumanager_add_form_id" role="form" class="form-horizontal" method="post">  
	 						 	<div class="form-group">  
				                    <label class="col-md-2 control-label" for="menutitle">父级菜单</label>  
				                    <div class="col-md-10 ">  
				                       	<a class="navbar-brand" href="#" class="dropdown-toggle" data-toggle="dropdown" style="padding: 0px 0px;    height: inherit;">
												<div class="input-group" ng-controller="MainCtrl2">
												  <input type="text" class="form-control" placeholder="请选择父菜单..." value="{{selectParentNode.title}}" readonly style="cursor: pointer;">
												  <span class="input-group-btn">
													<button class="btn btn-default" type="button"><span class="caret"></span></button>
												  </span>
												</div>
										 </a>
										 <ul class="dropdown-menu ztree col-md-10" id="dropselect" role="menu" style="top:34px;left: inherit;" ></ul>
										 <!--<ul class="dropdown-menu" id="dropselect" role="menu" style="top:34px;left: inherit;">
									          	<li class="dropdown-header">Nav header</li>
									            <li><a href="#">Select Me!</a></li>
									            <li>
									              <a href="#">
									                <strong>Heading</strong><br />
									                <small class="text-muted">Content description here...</small>
									              </a>
									            </li>
									            <li>
									              <a href="#">
									                <i class="glyphicon glyphicon-arrow-right"></i> Goto Project!
									              </a>
									            </li>
									            <li data-value="selected_value" selected><a href="#">Selected default</a></li>
									            <li data-value="something_value"><a href="#">Something else here</a></li>
									            <li class="divider"></li>
									            <li><a href="#">Separated link</a></li>
									            <li class="devider"></li>
									            <li data-value="destroy"><a href="#">Destroy me!</a></li>
									     </ul>-->


























				                    </div>  
				                </div> 
				                <div class="form-group">  
				                    <label class="col-md-2 control-label" for="title">标题</label>  
				                    <div class="col-md-10 ">  
				                        <input class="form-control span12" name="title" type="text" id="title" placeholder="请输入标题……"  check-type="required"  />  
				                    </div>  
				                </div>  
				                <div class="form-group">  
				                    <label class="col-md-2 control-label" for="URL">URL</label>  
				                    <div class="col-md-10">  
				                        <input class="form-control span12" name="URL" type="text" id="URL" placeholder="请输入URL……"  check-type="required"  />  
				                    </div>  
				                </div> 
				                <div class="form-group">  
				                    <label class="col-md-2 control-label" for="icon">图标</label>  
				                    <div class="col-md-10">  
				                        <input class="form-control span12" name="icon" type="text" id="icon" placeholder="请输入icon……"  check-type="required"  />  
				                    </div>  
				                </div> 
				              </form>
	 						
	 						
	 						
						</div>
						 <div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-primary" data-loading-text="Loading..." onclick="menumanager_addMenu(this);">确定</button>
						 </div>
					</div>
				</div>
			</div><!-- 添加用户信息模态框div结束 -->
 </div></@override> 
<@extends name="base/bootstrap_template.ftl"/>