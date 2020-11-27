package com.atguigu.atcrowdfunding.controller;


import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class PermissionController {

    @Autowired
    private PermissionService permissionService;


    @RequestMapping("/permission/index")
    public String index(){
        return "permission/index";
    }


    @ResponseBody
    @RequestMapping("/permission/loadTree")
    public List<TPermission> loadTree(){
        List<TPermission> list = permissionService.listPermission();
        return list;
    }

    @ResponseBody
    @RequestMapping("/permission/add")
    public String addPermission(TPermission permission){

        permissionService.savePermission(permission);

        return "ok";
    }



    @ResponseBody
    @RequestMapping("/permission/toUpdate")
    public TPermission toUpdate(Integer id){

        TPermission permission = permissionService.getPermissionById(id);

        return permission;
    }

    @ResponseBody
    @RequestMapping("/permission/doUpdate")
    public String doUpdate(TPermission permission){
        permissionService.updatePermission(permission);
        return "ok";
    }



    @ResponseBody
    @RequestMapping("/permission/delPermission")
    public String delPermission(Integer id){
        permissionService.deletePermissionById(id);
        return "ok";
    }

}
