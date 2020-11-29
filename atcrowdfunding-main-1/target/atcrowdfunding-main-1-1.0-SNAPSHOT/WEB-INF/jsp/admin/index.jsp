<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/jsp/common/css.jsp" %>
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        table tbody tr:nth-child(odd) {
            background: #F4F4F4;
        }

        table tbody td:nth-child(even) {
            color: #C00;
        }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form id="searchForm" class="form-inline" role="form" style="float:left;"
                          action="${PATH}/admin/index" method="post">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input value="${param.condition}" name="condition" class="form-control has-success"
                                       type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="searchBtn" type="button" class="btn btn-warning"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button id="deleteBatchBtn" type="button" class="btn btn-danger"
                            style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="window.location.href='${PATH}/admin/toAdd'"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="checkAll" type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list}" var="admin" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <c:if test="${admin.id == 1}">
                                        <td><input disabled type="hidden"></td>
                                    </c:if>
                                    <c:if test="${admin.id != 1}">
                                        <td><input type="checkbox" adminId="${admin.id}"></td>
                                    </c:if>
                                    <td>${admin.loginacct}</td>
                                    <td>${admin.username}</td>
                                    <td>${admin.email}</td>
                                    <td>
                                        <c:if test="${admin.id == 1}">
                                            <button disabled type="button" class="btn btn-success btn-xs"><i
                                                    class=" glyphicon glyphicon-check"></i></button>
                                            <button disabled type="button" class="btn btn-primary btn-xs"><i
                                                    class=" glyphicon glyphicon-pencil"></i></button>
                                            <button disabled type="button" class="btn btn-danger btn-xs"><i
                                                    class=" glyphicon glyphicon-remove"></i></button>
                                        </c:if>
                                        <c:if test="${admin.id != 1}">
                                            <button onclick="window.location = '${PATH}/admin/assignRole?id=${admin.id}'" type="button" class="btn btn-success btn-xs"><i
                                                    class=" glyphicon glyphicon-check"></i></button>
                                            <button onclick="window.location='${PATH}/admin/toUpdate?id=${admin.id}&pageNo=${pageInfo.pageNum}'"
                                                    type="button" class="btn btn-primary btn-xs"><i
                                                    class=" glyphicon glyphicon-pencil"></i></button>
                                            <button onclick="deleteAdmin(${admin.id},'${admin.loginacct}')"
                                                    type="button" class="btn btn-danger btn-xs"><i
                                                    class=" glyphicon glyphicon-remove"></i></button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <c:if test="${pageInfo.isFirstPage}">
                                            <li class="disabled"><a href="#">上一页</a></li>
                                        </c:if>
                                        <c:if test="${!pageInfo.isFirstPage}">
                                            <li>
                                                <a href="${PATH}/admin/index?pageNo=${pageInfo.pageNum-1}&condition=${param.condition}">上一页</a>
                                            </li>
                                        </c:if>
                                        <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                                            <c:if test="${num == pageInfo.pageNum}">
                                                <li class="active"><a href="#">${num}<span
                                                        class="sr-only">(current)</span></a></li>
                                            </c:if>
                                            <c:if test="${num != pageInfo.pageNum}">
                                                <li>
                                                    <a href="${PATH}/admin/index?pageNo=${num}&condition=${param.condition}">${num}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${pageInfo.isLastPage}">
                                            <li class="disabled"><a href="#">下一页</a></li>
                                        </c:if>
                                        <c:if test="${!pageInfo.isLastPage}">
                                            <li>
                                                <a href="${PATH}/admin/index?pageNo=${pageInfo.pageNum+1}&condition=${param.condition}">下一页</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/jsp/common/js.jsp" %>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });

        $("#searchBtn").click(function () {
            $("#searchForm").submit();

        });
    });

    function deleteAdmin(id, loginacct) {
        layer.confirm("您确定要删除[" + loginacct + "吗?", {btn: ["确定", "取消"], icon: 3},
            function (index) {
                window.location = "${PATH}/admin/doDelete?pageNo=${pageInfo.pageNum}&id=" + id;
                layer.close(index);
            }, function (index) {
                layer.close(index);
            })
    }

    $("#checkAll").click(function () {
        var checkAllStatus = this.checked;
        $("tbody input[type='checkbox']").prop("checked", checkAllStatus);
    });

    $("#deleteBatchBtn").click(function () {
        var $selectCheckboxArray = $("tbody input[type='checkbox']:checked");
        if ($selectCheckboxArray.length == 0) {
            layer.msg("请选择要删除的数据", {time: 2000, icon: 5});
            return false;
        }
        layer.confirm("确定要删除这些数据吗", {btn: ["确定", "取消"], icon: 3},
            function (index) {
                var array = new Array();
                var str = "";
                $.each($selectCheckboxArray, function (i, e) {
                    var adminId = $(e).attr("adminId");
                    array.push(adminId);
                });
                str = array.join(",");
                window.location="${PATH}/admin/deleteBatch?pageNo=${pageInfo.pageNum}&ids="+str;
                layer.close(index);
            }, function (index) {
                layer.close(index);
            })
    });
</script>
</body>
</html>


