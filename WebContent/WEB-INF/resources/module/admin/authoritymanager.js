var zNodes = [];
$(function() {
	/** ****加载表格****** */
	// 1.初始化Table
	var oTable = new TableInit();
	oTable.Init();

	// 2.初始化Button的点击事件
	var oButtonInit = new ButtonInit();
	oButtonInit.Init();

	// 1.初始化Table
	var oTable2 = new TableInit2();
	oTable2.Init();

	// 2.初始化Button的点击事件
	var oButtonInit2 = new ButtonInit2();
	oButtonInit2.Init();
	/** *获取tree** */
	$.post(path + '/adminManager/getMenuTree', {}, function(r) {
		if (r.status == 200) {
			zNodes = r.data;
		}
		var setting = {
			data : {
				key : {
					name : 'title',
					url : "url2"
				},
				simpleData : {
					idKey : "id",
					pIdKey : "parentid"
				}
			},
			check : {
				enable : true,
				chkStyle : "checkbox",
				chkboxType : {
					"Y" : "ps",
					"N" : "ps"
				}
			},
			callback : {
				onClick : function(event, treeId, treeNode) {
				}
			}
		};
		var treeObj = $.fn.zTree.init($("#menumanager_tree_id"), setting,
				zNodes);
		treeObj.expandAll(true);
	});
});
var TableInit = function() {
	var oTableInit = new Object();
	// 初始化Table
	oTableInit.Init = function() {
		$('#menumanager_users_tb').bootstrapTable({
			url : path + '/adminManager/getAllUsers', // 请求后台的URL（*）
			method : 'get', // 请求方式（*）
			toolbar : '#toolbar', // 工具按钮用哪个容器
			striped : true, // 是否显示行间隔色
			cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination : true, // 是否显示分页（*）
			sortable : false, // 是否启用排序
			sortOrder : "asc", // 排序方式
			queryParams : oTableInit.queryParams,// 传递参数（*）
			sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
			pageNumber : 1, // 初始化加载第一页，默认第一页
			pageSize : 10, // 每页的记录行数（*）
			pageList : [ 10, 15, 25, 50, 100 ], // 可供选择的每页的行数（*）
			search : true, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			strictSearch : true,
			showColumns : true, // 是否显示所有的列
			showRefresh : true, // 是否显示刷新按钮
			minimumCountColumns : 2, // 最少允许的列数
			clickToSelect : true, // 是否启用点击选中行
			//height : 500, // 行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "ID", // 每一行的唯一标识，一般为主键列
			showToggle : true, // 是否显示详细视图和列表视图的切换按钮
			cardView : false, // 是否显示详细视图
			detailView : true, // 是否显示父子表
			// showExport: true, //是否显示导出 （需要导入其他js文件才能生效）
			// exportDataType: "basic", //basic', 'all',
			// 'selected'.当前页、所有数据还是选中数据
			columns : [ {
				/* radio: true, */
				checkbox : true
			}, {
				field : 'username',
				title : '账号'
			}, {
				field : 'password',
				title : '密码'
			} ]
			// 注册加载子表的事件。注意下这里的三个参数！index：父表当前行的行索引。row：父表当前行的Json数据对象。$detail：当前行下面创建的新行里面的td对象。
			,
			onExpandRow : function(index, row, $detail) {
				oTableInit.InitSubTable(index, row, $detail);
			}
		});
	};

	// 得到查询的参数
	oTableInit.queryParams = function(params) {
		var temp = { // 这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
			limit : this.pageSize, // 页面大小
			offset : this.pageNumber
		// 页码
		};
		return temp;
	};
	// 初始化子表格(无线循环)
	oTableInit.InitSubTable = function(index, row, $detail) {
		var parentid = row.id;
		var cur_table = $detail
				.html(
						'<ul id="' + row.id + '_authority_id'
								+ '" class="ztree"></ul>').find('ul');
		
		var zNodes = $.extend(true,{},window.zNodes);//实现深度复制//[row.menus];
		var setting = {
			data : {
				key : {
					name : 'TITLE',
					// url : "URL",
					children : "CHILDREN"
				// ,checked: "isChecked"
				},
				simpleData : {
					idKey : "ID",
					pIdKey : "PARENTID"
				}
			},
			check : {
				enable : true,
				chkStyle : "checkbox",
				chkboxType : {
					"Y" : "ps",
					"N" : "ps"
				}
			},
			callback : {
				onClick : function(event, treeId, treeNode) {
				}
			}
		};
		var setting2 = {
				data : {
					key : {
						name : 'title',
						url : "url2",checked: "isChecked"
					},
					simpleData : {
						idKey : "id",
						pIdKey : "parentid"
					}
				},
				check : {
					enable : true,
					chkStyle : "checkbox",
					chkboxType : {
						"Y" : "ps",
						"N" : "ps"
					}
				},
				callback : {
					onClick : function(event, treeId, treeNode) {
					}
				}
			};
			var treeObj = $.fn.zTree.init(cur_table, setting2, zNodes);
			var nodes = treeObj.getNodesByFilter(filter); // 查找节点集合
			for(var i =0;i<nodes.length;i++)
			{
				for(var j =0;j<row.auths.length;j++)
				{
					if(nodes[i].authorityid==row.auths[j].authority)
					{
						nodes[i].isChecked=true;
					}
				}
				
			}
			treeObj.expandAll(true);
		//
	};
	return oTableInit;
};
function filter(node) {
	//console.log(node.title);
	//node.isChecked = true;
    return node;//(node.level == 2 && node.name.indexOf("test")>-1);
}

var ButtonInit = function() {
	var oInit = new Object();
	var postdata = {};

	oInit.Init = function() {
		// 初始化页面上面的按钮事件
	};

	return oInit;
};

/** 角色信息表格参数* */
var TableInit2 = function() {
	var oTableInit = new Object();
	// 初始化Table
	oTableInit.Init = function() {
		$('#menumanager_roles_tb').bootstrapTable({
			url : '/adminManager/getAllRoles', // 请求后台的URL（*）
			method : 'post', // 请求方式（*）
			toolbar : '#toolbar2', // 工具按钮用哪个容器
			striped : true, // 是否显示行间隔色
			cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination : true, // 是否显示分页（*）
			sortable : false, // 是否启用排序
			sortOrder : "asc", // 排序方式
			queryParams : oTableInit.queryParams,// 传递参数（*）
			sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
			pageNumber : 1, // 初始化加载第一页，默认第一页
			pageSize : 10, // 每页的记录行数（*）
			pageList : [ 10, 15, 25, 50, 100 ], // 可供选择的每页的行数（*）
			search : true, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			strictSearch : true,
			showColumns : true, // 是否显示所有的列
			showRefresh : true, // 是否显示刷新按钮
			minimumCountColumns : 2, // 最少允许的列数
			clickToSelect : true, // 是否启用点击选中行
			//height : 300, // 行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "ID", // 每一行的唯一标识，一般为主键列
			showToggle : true, // 是否显示详细视图和列表视图的切换按钮
			cardView : false, // 是否显示详细视图
			detailView : false, // 是否显示父子表
			// showExport: true, //是否显示导出 （需要导入其他js文件才能生效）
			// exportDataType: "basic", //basic', 'all',
			// 'selected'.当前页、所有数据还是选中数据
			columns : [ {
				checkbox : true
			}, {
				field : 'username',
				title : '账号'
			} ]
		});
	};

	// 得到查询的参数
	oTableInit.queryParams = function(params) {
		var temp = { // 这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
			limit : this.pageSize, // 页面大小
			offset : this.pageNumber, // 页码
		};
		return temp;
	};
	return oTableInit;
};

var ButtonInit2 = function() {
	var oInit = new Object();
	var postdata = {};

	oInit.Init = function() {
		// 初始化页面上面的按钮事件
	};

	return oInit;
};

function syn_to_users(_this) {
	$(_this).button('loading');
	// 获取用户表格中选中的数据
	var users = $("#menumanager_users_tb").bootstrapTable("getSelections");
	// 获取角色表格中选中的数据
	//var roles = $("#menumanager_roles_tb").bootstrapTable("getSelections");
	// 获取资源（菜单）树种选中的数据
	var nodes = $.fn.zTree.getZTreeObj("menumanager_tree_id").getCheckedNodes(
			true);
	if(users.length==0)
	{
		$(_this).button('reset');
		alert("请至少选择一个用户！");
		return;
	}
	if(nodes.length==0)
	{
		$(_this).button('reset');
		alert("请至少选择一个资源！");
		return;
	}
	var params = [];
	for(var j=0;j<users.length;j++)
	{
		var u = {};
//		u.userid = users[j].id;
//		u.menusids = [];
		u.user = users[j];
		u.menus = [];
		for(var i=0;i<nodes.length;i++)
		{
			var flag = true;
			for(var k=0;k<users[j].auths.length;k++)
			{
				if(users[j].auths[k].authority==nodes[i].authorityid)
				{
					flag = false;
				}
			}
			if(flag)
			{
				u.menus.push(nodes[i]);console.log(nodes[i].title+"===="+nodes[i].authorityid)
			}
		}
		params.push(u);
	}
	$.ajax({
		type:'POST',
		dataType:"text",
		contentType:'application/json;charset=GBK',
		url : path+'/adminManager/asyncAuthority',
		data:JSON.stringify(params),
		success:function(result)
		{
			if(result.success=='true')
			{
			}
			alert(result.message);
		},
		error:function(result)
		{
			alert(result.message);
		},
		complete:function(XMLHttpRequest,status)
		{
			$(_this).button('reset');
		}
	});
	
	
	
	
	
	
}
function syn_to_roles(_this) {
	$(_this).button('loading');
	// 获取用户表格中选中的数据
	//var users = $("#menumanager_users_tb").bootstrapTable("getSelections");
	// 获取角色表格中选中的数据
	var roles = $("#menumanager_roles_tb").bootstrapTable("getSelections");
	// 获取资源（菜单）树种选中的数据
	var nodes = $.fn.zTree.getZTreeObj("menumanager_tree_id").getCheckedNodes(
			true);
	if(roles.length==0)
	{
		$(_this).button('reset');
		alert("请至少选择一个角色！");
		return;
	}
	if(nodes.length==0)
	{
		$(_this).button('reset');
		alert("请至少选择一个资源！");
		return;
	}
}