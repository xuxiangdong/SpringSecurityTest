<@override name="popTitle">   
admin-title
</@override>
<@override name="script">
	<script type="text/javascript">
		
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
            <div class="panel-heading">
				<button type="button" class="btn btn-sm btn-primary">添加</button>
				<button type="button" class="btn btn-sm btn-primary">修改</button>
				<button type="button" class="btn btn-sm btn-primary">删除</button>
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
            

<h5>当前在线用户信息rolemanager</h5>
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
            </div>
          </div>
 </@override> 
<@extends name="base/bootstrap_template.ftl"/>