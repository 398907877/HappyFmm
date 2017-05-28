<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>挖矿分提现管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		
		<shiro:hasPermission name="financial:fclWithdraw:edit"><li ><a href="${ctx}/financial/fclWithdraw/form">挖矿分提现</a></li></shiro:hasPermission>
		<li  class="active"><a href="${ctx}/financial/fclWithdraw/">挖矿分提现记录</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="fclWithdraw" action="${ctx}/financial/fclWithdraw/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label><sys:treeselect id="user" name="user.id" value="${fclWithdraw.user.id}" labelName="user.name" labelValue="${fclWithdraw.user.name}" 
			title="用户" url="/sys/office/treeData?type=3" cssStyle="width:150px" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>转出编号</th>
				<th>转账金额</th>
				<th>创建时间</th>
			</tr>
			
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="fclWithdraw">
			<tr>
				<td>${fclWithdraw.user.name}</td>
				<td>${fclWithdraw.money}</td>
				<td>
					<fmt:formatDate value="${fclWithdraw.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>