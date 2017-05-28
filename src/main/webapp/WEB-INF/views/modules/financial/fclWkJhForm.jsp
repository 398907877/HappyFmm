<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>挖矿分转换管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		
		function getUserInfo(){
			$.ajax({ 
				type: "post", 
				url : "${ctx}/sys/user/infoData", 
				dataType:'json',
				data: {}, 
				success: function(json){
					var wkf = json.wkf;
					if(wkf == 0){
						alert("用户挖矿分为零，无法转换！");
						$("#money").attr("readonly",true);
					}
				}
			}); 
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		
		<li class="active"><a href="${ctx}/financial/fclWkJh/form?id=${fclWkJh.id}">挖矿分转换<shiro:hasPermission name="financial:fclWkJh:edit"></shiro:hasPermission><shiro:lacksPermission name="financial:fclWkJh:edit">查看</shiro:lacksPermission></a></li>
		<li><a href="${ctx}/financial/fclWkJh/">挖矿分转换记录</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="fclWkJh" action="${ctx}/financial/fclWkJh/save" method="post" class="form-horizontal"><%--
		<form:hidden path="email" htmlEscape="false" maxlength="255" class="input-xlarge"/>
		<sys:ckfinder input="email" type="files" uploadPath="/mytask" selectMultiple="false"/> --%>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">转换类型：</label>
			<div class="controls" style="width:220px">
				<form:select path="changetype" class="input-xlarge required" style="width:210px" onchange="getUserInfo()">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('fcl_wk_change')}" itemLabel="label" itemValue="value" htmlEscape="false" style="width:210px"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>	
		<div class="control-group">
			<label class="control-label">转换金额:</label>
			<div class="controls">
				<input name="money"  maxlength="50" class="nput-xlarge required money" id="money"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<textarea name="remarks"  rows="3" maxlength="200" class="input-xlarge"/></textarea>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="financial:fclWkJh:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
		
</body>
</html>