package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class RoleController {

    @Autowired
    private RoleService roleService;


    @ResponseBody
    @RequestMapping("/role/doAssignPermissionToRole")
    public String doAssignPermissionToRole(Integer roleId,Integer[] ids){
        roleService.saveRoleAndPermissionRelationship(roleId,ids);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/listPermissionByRoleId")
    public List<Integer> listPermissionByRoleId(Integer roleId){

        List<Integer> permissionIds = roleService.listPermissionByRoleId(roleId);
        return permissionIds;
    }


    @ResponseBody
    @RequestMapping("/role/deleteBatch")
    public String deleteRoleBatch(String str){
        roleService.deleteRoleBatch(str);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/delete")
    public String deleteRole(Integer id){
        roleService.deleteRoleById(id);
        return "ok";
    }


    @ResponseBody
    @RequestMapping("/role/doUpdate")
    public String updateRole(TRole role){

        roleService.updateRole(role);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/toUpdate")
    public TRole getRoleById(Integer id){
        TRole role = roleService.getRoleById(id);
        return role;
    }


    @ResponseBody
    @RequestMapping("/role/add")
    public String saveRole(TRole role){
        System.err.println(role);
        roleService.saveRole(role);
        return "ok";
    }

    @RequestMapping("/role/index")
    public String index() {
        return "role/index";
    }

    @ResponseBody
    @RequestMapping("/role/listPage")
    public PageInfo<TRole> listPage(@RequestParam(value = "pageNo", required = false, defaultValue = "1") Integer pageNo,
                                    @RequestParam(value = "pageSize", required = false, defaultValue = "2") Integer pageSize,
                                    @RequestParam(value = "condition", required = false, defaultValue = "") String condition) {

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("pageNo", pageNo);
        paramMap.put("pageSize", pageSize);
        paramMap.put("condition", condition);
        PageInfo<TRole> pageInfo = roleService.listRolePage(paramMap);
        return pageInfo;
    }

}
