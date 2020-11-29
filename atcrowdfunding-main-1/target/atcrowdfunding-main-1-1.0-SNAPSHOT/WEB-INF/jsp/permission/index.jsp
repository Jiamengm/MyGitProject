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
        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 菜单树</h3>
        </div>
        <div class="panel-body">
        <hr style="clear:both;">
        <div class="table-responsive">
        <ul id="treeDemo" class="ztree"></ul>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>





    <!-- 添加模态框 -->
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
    <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="addModalLabel">添加许可</h4>
    </div>
    <div class="modal-body">
    <div class="form-group">
    <label >许可名称</label>
    <input type="hidden" name="pid">
    <input type="text" class="form-control"  name="name" placeholder="请输入许可名称">
    </div>
    <div class="form-group">
    <label >许可图标</label>
    <input type="text" class="form-control"  name="icon" placeholder="请输入许可图标">
    </div>
    <div class="form-group">
    <label >许可标题</label>
    <input type="text" class="form-control"  name="title" placeholder="请输入许可标题">
    </div>
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
    </div>
    </div>
    </div>
    </div>



        <!-- 修改模态框 -->
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
    <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
    aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="updateModalLabel">修改菜单</h4>
    </div>
    <div class="modal-body">
    <div class="form-group">
    <label >许可名称</label>
    <input type="hidden" name="id">
    <input type="text" class="form-control" name="name" placeholder="请输入许可名称">
    </div>
    <div class="form-group">
    <label >许可图标</label>
    <input type="text" class="form-control" name="icon" placeholder="请输入许可图标">
    </div>
    <div class="form-group">
    <label >许可标题</label>
    <input type="text" class="form-control" name="title" placeholder="请输入许可标题">
    </div>
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
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
        loadData();
        });

        function loadData() {

            var setting = {
                data: {
                        simpleData: {
                                enable: true,
                                pIdKey: "pid"
                        },
                        key: {
                            url: "xUrl",
                            name:"title"
                    }
                 },
                view:{
                         addDiyDom: customeIcon,//显示自定义图标
                        addHoverDom: addHoverDom, //显示按钮
                        removeHoverDom: removeHoverDom //移除按钮
                }
            };
        $.get("${PATH}/permission/loadTree",{},function(result) {
            result.push({"id":0,"title":"系统权限","icon":"glyphicon glyphicon-th-list"}
            )
            $.fn.zTree.init($("#treeDemo"), setting, result);

            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            treeObj.expandAll(true);


        });
        }
        function customeIcon(treeId,treeNode) {
            $("#"+treeNode.tId+"_ico").removeClass();//.addClass();
            $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")
        }
        function addHoverDom(treeId,treeNode) {
            var aObj = $("#"+treeNode.tId+"_a");
            aObj.attr("href", "javascript:;");
            aObj.attr("onclick", "return false");

            if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
            var s = '<span id="btnGroup'+treeNode.tId+'">';
            if ( treeNode.level == 0 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="add('+treeNode.id+')"  >  <i class="fa fa-fw fa-plus rbg "></i></a>';
            } else if ( treeNode.level == 1 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="toUpdate('+treeNode.id+')"  title="修改权限信息">  <i class="fa fa-fw fa-edit rbg "></i></a>';
            if (treeNode.children.length == 0) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="delPermission('+treeNode.id+')" >  <i class="fa fa-fw fa-times rbg "></i></a>';
            }
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="add('+treeNode.id+')"  >  <i class="fa fa-fw fa-plus rbg "></i></a>';
            } else if ( treeNode.level == 2 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="toUpdate('+treeNode.id+')" title="修改权限信息">  <i class="fa fa-fw fa-edit rbg "></i></a>';
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="delPermission('+treeNode.id+')" >  <i class="fa fa-fw fa-times rbg "></i></a>';
            }
             
            s += '</span>';
            aObj.after(s);
        }
        function removeHoverDom(treeId,treeNode) {
            $("#btnGroup"+treeNode.tId).remove();

        }

        function add(id) {
            $("#addModal input[name='pid']").val(id);
            $("#addModal").modal({
                show:true,
                backdrop:"static",
                keyboard:false
            });
        }

        $("#saveBtn").click(function() {
            var pid = $("#addModal input[name='pid']").val();
            var name = $("#addModal input[name='name']").val();
            var icon = $("#addModal input[name='icon']").val();
            var title = $("#addModal input[name='title']").val();

            $.post("${PATH}/permission/add",{pid:pid,name:name,icon:icon,title:title},function(result) {
                if(result == 'ok'){
                   $("#addModal").modal("hide");
                   layer.msg("添加成功",{icon:6});
                    $("#addModal input[name='pid']").val("");
                    $("#addModal input[name='name']").val("");
                    $("#addModal input[name='icon']").val("");
                    $("#addModal input[name='title']").val("");
                   loadData();
                }else{
                    $("#addModal").modal("hide");
                    layer.msg("添加失败",{icon:5});
                }
             });

         });

        function toUpdate(id) {
            $("#updateModal").modal({
                show:true,
                backdrop:"static",
                keyboard:false
        });
            $.get("${PATH}/permission/toUpdate",{id:id},function(result) {
                $("#updateModal input[name='id']").val(result.id);
                $("#updateModal input[name='name']").val(result.name);
                $("#updateModal input[name='icon']").val(result.icon);
                $("#updateModal input[name='title']").val(result.title);
             });
         }

         $("#updateBtn").click(function() {
            var id = $("#updateModal input[name='id']").val();
            var name = $("#updateModal input[name='name']").val();
            var icon = $("#updateModal input[name='icon']").val();
            var title = $("#updateModal input[name='title']").val();

            <%--$.post("${PATH}/permission/add",{pid:pid,name:name,icon:icon},function(result) {--%>
            $.post("${PATH}/permission/doUpdate",{id:id,name:name,icon:icon,title:title},function(result){
                if(result == 'ok'){
                    $("#updateModal").modal("hide");
                    layer.msg("修改成功",{icon:6});
                    loadData();
                }else{
                    $("#updateModal").modal("hide");
                    layer.msg("修改失败",{icon:5});
                }
            });
         });
        function delPermission(id) {
            layer.confirm("您确定要删除这条数据吗?", {btn: ["确定", "取消"], icon: 3},
                function (index) {
                    $.post("${PATH}/permission/delPermission",{id:id},function(result) {
                        if (result == "ok") {
                            layer.msg("删除成功", {icon: 6});
                            loadData();
                        } else {
                            layer.msg("删除失败", {icon: 5});
                        }
                    });
                    layer.close(index);
                }, function (index) {
                    layer.close(index);
                })
        }
        </script>

        </body>
        </html>


