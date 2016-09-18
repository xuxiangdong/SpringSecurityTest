<@override name="popTitle">   
admin-title
</@override>
<@override name="script">
	<script type="text/javascript">
	</script>
</@override>
<@override name="style">
</@override>
<@override name="body">
<div role="tabpanel" class="tab-pane active" id="home">
											<form id="uploadfiledemo" name="uploadfile" method="Post"  enctype="multipart/form-data">
												file1:<input type="file" name="myFile"/>
												<br />
												file2:<input type="file" name="myFile"/>
												<br />
												 <button type="submit" class="btn btn-primary">上传<span class="caret"></span></button>
											</form>
											<i class="fa fa-lg fa-fw fa-home"></i>
											<hr />
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
 </@override> 
<@extends name="base/bootstrap_template.ftl"/>