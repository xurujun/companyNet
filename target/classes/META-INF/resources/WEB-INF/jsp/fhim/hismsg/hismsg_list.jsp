<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<link rel="stylesheet" href="plugins/fhim/dist/css/layui.css">
<link rel="stylesheet" href="assets/css/style.css">
<style>
body .layim-chat-main{height: auto;}
</style>
</head>
<body>
	<div class="layim-chat-main">
	  <ul id="LAY_view"></ul>
	</div>
	<div id="LAY_page" style="margin: 0 10px;"></div>

	<textarea title="消息模版" id="LAY_tpl" style="display:none;">
		<!-- 开始循环 -->	
		<c:choose>
			<c:when test="${not empty varList}">
				<c:forEach items="${varList}" var="var" varStatus="vs">
					<c:if test="${pd.USERNAME == var.USERNAME }">
				    <li class="layim-chat-mine"><div class="layim-chat-user"><img src="${var.PHOTO}"><cite><i>${var.CTIME}</i>${var.NAME}</cite></div><div class="layim-chat-text">{{ layui.layim.content('${var.CONTENT}') }}</div></li>
					</c:if>
					<c:if test="${pd.USERNAME != var.USERNAME }">
				    <li><div class="layim-chat-user"><img src="${var.PHOTO}"><cite>${var.NAME}<i>${var.CTIME}</i></cite></div><div class="layim-chat-text">{{ layui.layim.content('${var.CONTENT}') }}</div></li>
					</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
					<td colspan="100" style="color: black;">没有聊天记录</td>
			</c:otherwise>
		</c:choose>
	</textarea>

	<form action="hismsg/himsglist" method="post" name="Form" id="Form">
	<input type="hidden" name="id" id="id" value="${pd.id }" />
	<input type="hidden" name="type" id="type" value="${pd.type }" />
	</form>
	<div class="page-header position-relative">
	<table style="width:100%;">
		<tr>
			<c:if test="${'friend' == pd.type }">
			<td style="padding-left: 30px;"><button class="layui-btn layui-btn-xs" onclick="allmsg('${pd.id }','${pd.type }');">记录管理</button></td>
			</c:if>
			<td style="color: black;float: right;padding-right: 15px;padding-top: 13px;">${page.pageStrSimplify}</td>
		</tr>
	</table>
	</div>
<!-- 页面底部js¨ -->
<!-- ace scripts -->
<script src="plugins/fhim/dist/layui.js"></script>
<script>
layui.use(['layim', 'laypage'], function(){
  var layim = layui.layim
  ,laytpl = layui.laytpl
  ,$ = layui.jquery
  ,res = { };
  var html = laytpl(LAY_tpl.value).render({
    data: res.data
  });
  $('#LAY_view').html(html);
});

//打开消息管理窗口
function allmsg(id,type){
	parent.layer.open({
	    type: 2,
	    title: '聊天记录管理',
	    shadeClose: true,
	    shade: false,
	    maxmin: true, //开启最大化最小化按钮
	    area: ['1200px', '600px'],
	    content: '<%=basePath%>hismsg/list?id='+id+'&type='+type
	  });
}
</script>
</body>
</html>