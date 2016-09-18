<@override name="popTitle">   
admin-title
</@override>
<@override name="script">
	<script type="text/javascript">
		$(function(){
			/*保证模态框每次都从服务器获取新数据内容*/
			$("#modal_usermanager_add").on("hidden.bs.modal", function() {
			    $(this).removeData("bs.modal");  
			});  
			$("#modal_usermanager_add_form_id").validation(function(obj, params) {
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

				reqmark : true,
				icon : false
			});
			});
		function usermanager_add()
		{
			//$('#modal_usermanager_add').empty();
			//$('#modal_usermanager_add').append(html);
			$('#modal_usermanager_add').modal({
						backdrop: 'static',
						keyboard: false});
		}
		function usermanager_addUser(_this)
		{
			$(_this).button('loading');
			if ($("#modal_usermanager_add").valid() == true) {
			var param = {};
			var data = $("#modal_usermanager_add_form_id").serializeArray();
			for (var i = 0; i < data.length; i++) {
				param[data[i].name] = data[i].value;
			}
			$.post(path+'/userOperate',param,function(r){
			if(r.status==200)
			{
				$("#tb_departments").bootstrapTable("refresh");
			}
			$("#modal_usermanager_add").modal("hide");
			alert(r.message);
			}).always(function() {
			    $(_this).button('reset');
			});
				
				return false;
			} else {
			$(_this).button('reset');
			}
		}
		
	function usermanager_delete()
		{
		var param = $("#tb_departments").bootstrapTable("getSelections");
		if(!param || param.length==0)
		{
			alert("请选择要删除的数据！");
			return;
		}
		$.ajax({
			type:'POST',
			dataType:"text",
			contentType:'application/json;charset=GBK',
			url : path+'/deleteUserByUserId',
			data:JSON.stringify(param),
			success:function(result)
			{
				if(result.status==200)
				{
					$("#tb_departments").bootstrapTable("refresh");
				}
				$("#modal_usermanager_add").modal("hide");
				alert(result.message);
			},
			error:function(result)
			{
				alert("请求失败！失败信息："+result);
			}
		});
			
		}	
		
	$(function () {

    //1.初始化Table
    var oTable = new TableInit();
    oTable.Init();

    //2.初始化Button的点击事件
    var oButtonInit = new ButtonInit();
    oButtonInit.Init();

});


var TableInit = function () {
    var oTableInit = new Object();
    //初始化Table
    oTableInit.Init = function () {
        $('#tb_departments').bootstrapTable({
            url: 'getAllUsers',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: oTableInit.queryParams,//传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10,15, 25, 50, 100],        //可供选择的每页的行数（*）
            search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
           // height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
           // showExport: true,                     //是否显示导出 （需要导入其他js文件才能生效）
		//	exportDataType: "basic",              //basic', 'all', 'selected'.当前页、所有数据还是选中数据
            columns: [{
                checkbox: true
            }, {
                field: 'username',
                title: '账号'
            }, {
                field: 'password',
                title: '密码'
            }]
        });
    };

    //得到查询的参数
    oTableInit.queryParams = function (params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            limit: this.pageSize,   //页面大小
            offset: this.pageNumber,  //页码
            departmentname: $("#txt_search_departmentname").val(),
            statu: $("#txt_search_statu").val()
        };
        return temp;
    };
    return oTableInit;
};


var ButtonInit = function () {
    var oInit = new Object();
    var postdata = {};

    oInit.Init = function () {
        //初始化页面上面的按钮事件
    };

    return oInit;
};
		
	</script>
</@override>
<@override name="style">
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
</style>
</@override>
<@override name="body">
		<div class="panel panel-default">
            <div class="panel-heading bg-success">
				<button type="button" class="btn btn-sm btn-primary" onclick="usermanager_add();">添加用户</button>
				<button type="button" class="btn btn-sm btn-primary">修改用户</button>
				<button type="button" class="btn btn-sm btn-primary" onclick="usermanager_delete();">删除用户</button>
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
			                        <input class="form-control span10" name="name2" type="text" id="name2" placeholder="Name" value="" />  
			                    </div>  
			                </div>
			                 <div class="form-group">  
			                    <div class="col-md-offset-2 col-md-10 form-actions">  
			                       <button type="button" class="btn btn-sm btn-primary">重置</button>
					       		   <button type="button" class="btn btn-sm btn-primary" data-loading-text="Loading...">确定</button>
			                    </div>  
                			</div>  
            			</form>   
	              	</div>
              	</div>
            </div>
            <div class="panel-body">
            

<h5>当前在线用户信息</h5>
<div role="tabpanel" class="tab-pane active" id="home">
		 <table class="table table-striped">
              <thead>
                <tr>
                  <th>username</th>
                  <th>sessionId</th>
                  <th>expired</th>
                  <th>lastRequest</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody>
              	<#list sessionInfos as sessionInfo>
                <tr>
                  <td>${(sessionInfo.principal.username)!}</td>
                  <td>${(sessionInfo.sessionId)!}</td>
                  <td>${((sessionInfo.expired)?string('true','false'))!}</td>
                  <td>${(sessionInfo.lastRequest)?string("yyyy-MM-dd HH:mm:ss zzzz")!}</td>
                  <td><button type="button" onclick="tc('${(sessionInfo.principal.username)!}');" class="btn btn-primary">踢出</button></td>
                </tr>
                </#list>
               </tbody>
             </table>
</div> 


  Panel content
   <div id="toolbar" class="btn-group">
            <button id="btn_add" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="btn_delete" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
        </div>
<table id="tb_departments"></table>
  
  
            </div>
          </div>
          
          	<!-- 添加用户信息模态框 -->
			<div id="modal_usermanager_add" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
				<div class="modal-dialog">
	    			<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h5 class="modal-title" id="myModalLabel">添加用户</h5>
						 </div>
	 					<div class="modal-body" style="">
	 						 <form id="modal_usermanager_add_form_id" role="form" class="form-horizontal" method="post">  
				                <div class="form-group">  
				                    <label class="col-md-2 control-label" for="username">账号</label>  
				                    <div class="col-md-10 ">  
				                        <input class="form-control span12" name="username" type="text" id="username" placeholder="Name"  check-type="required"  />  
				                    </div>  
				                </div>  
				                <div class="form-group">  
				                    <label class="col-md-2 control-label" for="exampleInputPassword1">密码</label>  
				                    <div class="col-md-10">  
				                        <input type="password" name="password" class="form-control input-block-level" id="exampleInputPassword1" placeholder="Password">  
				                    </div>  
				                </div>  
				              </form>
	 						
	 						
	 						
						</div>
						 <div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-primary" onclick="usermanager_addUser(this);">确定</button>
							<button type="button" class="btn btn-primary" data-loading-text="Loading..." onclick="usermanager_addUser(this);">确定2</button>
						 </div>
					</div>
				</div>
			</div>
 </@override> 
<@extends name="base/bootstrap_template.ftl"/>