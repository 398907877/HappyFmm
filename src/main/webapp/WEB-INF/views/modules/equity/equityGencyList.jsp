<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>欢乐豆提现管理</title>
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
		
		<shiro:hasPermission name="equity:equityGency:edit"><li><a href="${ctx}/equity/equityGency/form">应急快售</a></li></shiro:hasPermission>
		<li class="active"><a href="${ctx}/equity/equityGency/">应急快售记录</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="equityGency" action="${ctx}/equity/equityGency/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>提现登录名：</label>
				<form:input path="loginName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>提现登录名</th>
				<th>提现姓名</th>
				<th>提现欢乐豆</th>
				<th>提现金额</th>
				<th>创建时间</th>
			</tr>
			
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="equityGency">
			<tr>
				<td>${equityGency.user.loginName}</td>
				<td>${equityGency.user.name}</td>
				<td>${equityGency.happyfood}</td>
				<td>${equityGency.money}</td>
				<td>
					<fmt:formatDate value="${equityGency.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>