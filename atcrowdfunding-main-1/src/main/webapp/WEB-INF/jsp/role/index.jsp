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
    <link rel="stylesheet" href="${PATH}/static/ztree/zTreeStyle.css">
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
                    <form id="searchForm" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input value="${param.condition}" id="condition" class="form-control has-success"
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
                    <button id="addBtn" type="button" class="btn btn-primary" style="float:right;"
                    ><i
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
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">

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

<!-- Modal 添加-->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="addModalLabel">添加</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>名称</label>
                    <input type="text" name="name" class="form-control" placeholder="请输入角色名称">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="saveBtn" type="button" class="btn btn-primary">添加</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal 修改-->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="updateModalLabel">修改</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>名称</label>
                    <input type="text" name="name" class="form-control" placeholder="请输入角色名称">
                    <input type="hidden" name="id">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal 给角色分配许可-->
<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="assignModalLabel">给角色分配许可</h4>
            </div>
            <div class="modal-body">
                <ul id="treeDemo" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="assignBtn" type="button" class="btn btn-primary">分配</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/jsp/common/js.jsp" %>
<script type="text/javascript" src="${PATH}/static/ztree/jquery.ztree.all-3.5.min.js"></script>
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
        loadData(1);
    });

    //定义全局变量json
    var json = {
        pageNo: 1,
        pageSize: 2
    }

    //加载数据
    function loadData(pageNo) {
        json.pageNo = pageNo;
        $.ajax({
            type: "post",
            url: "${PATH}/role/listPage",
            data: json,
            success: function (result) {

                json.pages = result.pages;

                showData(result.list);

                showNav(result);
            }
        });
    }

    //显示数据
    function showData(list) {
        var content = '';
        $.each(list, function (i, e) {
            content += '<tr>';
            content += '    <td>' + (i + 1) + '</td>';
            content += '	<td><input roleId="' + e.id + '" type="checkbox"></td>';
            content += '    <td>' + e.name + '</td>';
            content += '    <td>';
            content += '		<button roleId ="'+ e.id +'" type="button" class="permissionModalPopBtn btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
            content += '		<button type="button" roleId="' + e.id + '"class="updateClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
            content += '		<button type="button" roleName="' + e.name + '" roleId="' + e.id + '" class="deleteClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
            content += '	</td>';
            content += '</tr>';
        });

        $("tbody").html(content);
    };

    //显示分页条
    function showNav(page) {
        var nav = '';
        if (page.isFirstPage) {
            nav += '<li class="disabled"><a href="#">上一页</a></li>'
        } else {
            nav += '<li><a onclick="loadData(' + page.prePage + ')">上一页</a> </li>';
        }
        $.each(page.navigatepageNums, function (i, e) {
            if (e == page.pageNum) {
                nav += '<li class="active"><a href="#">' + e + '<span class="sr-only">(current)</span></a></li>';
            } else {
                nav += '<li><a onclick="loadData(' + e + ')" >' + e + '</a> </li>';
            }
        });
        if (page.isLastPage) {
            nav += '<li class="disabled"><a href="#">下一页</a></li>'
        } else {
            nav += '<li><a onclick="loadData(' + page.nextPage + ')">下一页</a> </li>';
        }

        $(".pagination").html(nav);
    }

    //查询
    $("#searchBtn").click(function () {
        json.condition = $("#condition").val();
        loadData(1);
    });

    //-------------------以下为添加的代码------------------------
    //弹出模态框
    $("#addBtn").click(function () {
        $("#addModal input[name='name']").val("");
        $("#addModal").modal({
            show: true,
            backdrop: "static",
            keyboard: false
        });
    });
    $("#saveBtn").click(function () {
        //获取数据
        var data = $("#addModal input[name='name']").val();
        $.post("${PATH}/role/add", {name: data}, function (result) {
            if (result == 'ok') {
                $("#addModal").modal('hide');
                layer.msg("添加成功", {icon: 6});
                loadData(json.pages + 1);
            } else {
                $("#addModal").modal('hide');
                layer.msg("添加失败", {icon: 5});
            }
        });
    });

    //----------------------以下为修改的代码---------------------

    //数据回显
    $("tbody").on("click", ".updateClass", function () {
        $("#updateModal").modal({
            show: true,
            backdrop: "static",
            keyboard: false
        })
        var data = $(this).attr("roleId");
        $.get("${PATH}/role/toUpdate", {id: data}, function (result) {
            $("#updateModal input[name='name']").val(result.name);
            $("#updateModal input[name='id']").val(result.id);
        });
    });

    //数据修改提交
    $("#updateBtn").click(function () {
        var name = $("#updateModal input[name='name']").val();
        var id = $("#updateModal input[name='id']").val();
        $.post("${PATH}/role/doUpdate", {id: id, name: name}, function (result) {
            if (result == 'ok') {
                $("#updateModal").modal('hide');
                layer.msg("修改成功", {icon: 6});
                loadData(json.pages);
            } else {
                $("#updateModal").modal('hide');
                layer.msg("修改失败", {icon: 5});
            }
        });
    });

    //-------------------以下是删除的代码-----------------------
    $("tbody").on("click", ".deleteClass", function () {
        var name = $(this).attr("roleName");
        var id = $(this).attr("roleId");
        layer.confirm("确定要删除[" + name + "]吗?", {btn: ["确定", "取消"], icon: 3},
            function (index) {
                $.post("${PATH}/role/delete", {id: id}, function (result) {
                    if (result == "ok") {
                        layer.msg("删除成功", {icon: 6});
                        loadData(json.pageNo);
                    } else {
                        layer.msg("删除失败", {icon: 5});
                    }
                })
                layer.close(index);
            }, function (index) {
                layer.close(index);
            });
    });
    //-------------------以下是批量删除的代码-----------------------
    //批量删除
    $("#checkAll").click(function () {
        var checkAllStatus = $(this).prop("checked");
        $("tbody input[type='checkbox']").prop("checked", checkAllStatus);
    });
    $("tbody").on("change","input[type='checkbox']",function () {
        var checkedArray = $("tbody input[type='checkbox']");
        $.each(checkedArray,function (i, e) {
            if(!$(e).checked){
                $("#checkAll").prop("checked",false);
                return false;
            }
        });
    })
    $("#deleteBatchBtn").click(function () {
        var checkedArray = $("tbody input[type='checkbox']:checked");
        if (checkedArray.length == 0) {
            layer.msg("请选择要删除的数据", {icon: 5});
            return false;
        }
        layer.confirm("确定要删除这些数据吗?", {btn: ["确定", "取消"], icon: 3},
            function (index) {
                layer.close(index);
                var array = new Array();
                var str = '';
                $.each(checkedArray, function (i, e) {
                    var id = $(e).attr("roleId");
                    array.push(id);
                });
                str = array.join(",");
                $.post("${PATH}/role/deleteBatch", {str: str}, function (result) {
                    if (result == "ok") {
                        layer.msg("删除成功", {icon: 6});
                        loadData(json.pageNo);
                        $("#checkAll").prop("checked", false);
                    } else {
                        layer.msg("删除失败", {icon: 5});
                    }
                })
            }, function (index) {
                layer.close(index);
                return false;
            });
    });


    //角色添加权限
    var roleId = null;
    $("tbody").on("click",".permissionModalPopBtn",function () {
        roleId = $(this).attr("roleId");
        // alert(roleId);
        initTree();

        $("#assignModal").modal({
            show:true,
            backdrop:"static",
            keyboard:false
        });

    });
    function initTree() {
        var setting ={
            data:{
                simpleData:{
                    enable:true,
                    pIdKey:"pid"
                },
                key:{
                    url:"xUrl",
                    name:"title"
                }
            },
            view:{
                addDiyDom: function(treeId,treeNode){
                    $("#"+treeNode.tId+"_ico").removeClass();
                    $("#"+treeNode.tId+"_span").before('<span class="'+treeNode.icon+'"></span>');
                }
            },
            check: {
                enable: true
            }
        };
        //1.加载数据
        $.get("${PATH}/permission/loadTree",function (result) {
            var tree = $.fn.zTree.init($("#treeDemo"), setting, result);
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            treeObj.expandAll(true);


            //2.回显数据,把已经分配的许可id查询出来
            $.get("${PATH}/role/listPermissionByRoleId",{roleId:roleId},function (result) {
                console.log(result);
                $.each(result,function (i,e) {
                    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    var node = treeObj.getNodeByParam("id", e, null);
                    treeObj.checkNode(node, true, false);
                })
            });
        });
    };
    //分配许可
    $("#assignBtn").click(function () {
        var rid = roleId;
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getCheckedNodes(true);

        var str = "roleId=" + rid;
        $.each(nodes,function (i, e) {
            var permissionId = e.id;
            str += "&";
            str += "ids=" + permissionId;
        });
        $.ajax({
            url:"${PATH}/role/doAssignPermissionToRole",
            type:"post",
            data:str,
            success:function (result) {
                if("ok"==result){
                    $("#assignModal").modal('hide');
                    layer.msg("分配成功");
                }else{
                    layer.msg("分配失败");
                };
            }
        });
    });

</script>

</body>
</html>


