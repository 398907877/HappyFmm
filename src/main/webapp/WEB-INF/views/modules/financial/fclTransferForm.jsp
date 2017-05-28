<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>积分转账管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	var user = "";	
	$(document).ready(function() {
			//$("#name").focus();
			
				$.ajax({ 
					type: "post", 
					url : "${ctx}/sys/user/infoData", 
					dataType:'json',
					data: {}, 
					success: function(json){
						user = json;
					}
				}); 
			
			$("#inputForm").validate({
				rules: {
					intonumberId: {remote: "${ctx}/financial/fclTransfer/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					intonumberId: {remote: "该用户不存在"},
				},
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
		
		function changeType(){
			var transType = $("#transType").val();
			var transMoney = $("transMoney").val();
			$("#transMoney").val("");
			if(transType == "1"){
				var jhf = user.jhf;
				$("#tMoney").val(jhf);
				if(parseInt(jhf)<parseInt(transMoney)){
					alert("用户激活分不足，无法转账！")
				}
				$("#transMoney").removeClass("money");
				$("#transMoney").addClass("transMoney");
			}else {
				var qzf = user.qzf;
				if(parseInt(qzf) < parseInt(transMoney)){
					alert("用户权证分不足，无法转账！");
					$("#transMoney").attr("readonly",true);
				}
				$("#transMoney").removeClass("transMoney");
				$("#transMoney").addClass("money");
			}
		}
		
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		
		<li class="active"><a href="${ctx}/financial/fclTransfer/form?id=${fclJhTransfer.id}">积分转账<shiro:hasPermission name="financial:fclTransfer:edit"></shiro:hasPermission><shiro:lacksPermission name="financial:fclTransfer:edit">查看</shiro:lacksPermission></a></li>
	<li><a href="${ctx}/financial/fclTransfer/">积分转账记录</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="fclTransfer" action="${ctx}/financial/fclTransfer/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">转账类型：</label>
			<div class="controls" style="width:230px">
				<form:select path="transType" class="input-xlarge required" style="width:220px" onchange="changeType()" id="transType">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('fcl_transfer')}" itemLabel="label" itemValue="value" htmlEscape="false" style="width:220px"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">转入编号:</label>
			<div class="controls">
				<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				<form:input path="intonumberId" htmlEscape="false" maxlength="50" class="required userName"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">转账金额：</label>
			<div class="controls">
				<form:input path="transMoney" htmlEscape="false" maxlength="64" class="input-xlarge required transMoney" style="width:206px" id="transMoney"/>
				<span class="help-inline"><font color="red">*</font> </span>
				<span id="tMoney"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="255" class="input-xxlarge " style="width:206px"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="financial:fclTransfer:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>