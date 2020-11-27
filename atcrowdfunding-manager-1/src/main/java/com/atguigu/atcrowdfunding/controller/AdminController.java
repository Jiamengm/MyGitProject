package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageInfo;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminController {


    @Autowired
    private RoleService roleService;

    @Autowired
    private AdminService adminService;


    @RequestMapping("/admin/assignRole")
    public String assignRole(Model model, Integer id) {
        List<TRole> roleList = roleService.listAll();

        List<Integer> selfRoleIdList = roleService.listRoleIdByAdminId(id);

        List<TRole> assignList = new ArrayList<>();
        List<TRole> unAssignList = new ArrayList<>();
        model.addAttribute("assignList", assignList);
        model.addAttribute("unAssignList", unAssignList);

        roleList.forEach(role -> {
            if (selfRoleIdList.contains(role.getId())) {
                assignList.add(role);
            } else {
                unAssignList.add(role);
            }
        });

        return "admin/assignRole";
    }

    @RequestMapping("/admin/deleteBatch")
    public String deleteBatch(String ids, Integer pageNo) {

        adminService.deleteBatch(ids);
        return "redirect:/admin/index?pageNo=" + pageNo;
    }

    @RequestMapping("/admin/doDelete")
    public String deleteAdminById(Integer id, Integer pageNo, HttpServletResponse response) {
        adminService.deleteAdminById(id);

        return "redirect:/admin/index?pageNo=" + pageNo;
    }

    @RequestMapping("/admin/doUpdate")
    public String updateAdmin(TAdmin admin, Integer pageNo) {
        adminService.updateAdminById(admin);
        return "redirect:/admin/index?pageNo=" + pageNo;
    }


    @RequestMapping("/admin/toUpdate")
    public String toUpdate(Integer id, Model model) {
        TAdmin admin = adminService.getAdminById(id);
        model.addAttribute("admin", admin);
        return "admin/update";
    }


    @RequestMapping("/admin/doAdd")
    public String saveAdmin(TAdmin admin) {

        adminService.saveAdmin(admin);
        return "redirect:/admin/index?pageNo=" + Integer.MAX_VALUE;
    }

    @RequestMapping("/admin/toAdd")
    public String toAdd() {
        return "admin/add";
    }

    @RequestMapping("/admin/index")
    public String listPage(@RequestParam(value = "pageNo", required = false, defaultValue = "1") Integer pageNo,
                           @RequestParam(value = "pageSize", required = false, defaultValue = "5") Integer pageSize,
                           @RequestParam(value = "condition", required = false, defaultValue = "") String condition,
                           Model model) {

        Map<String, Object> map = new HashMap<>();
        map.put("pageNo", pageNo);
        map.put("pageSize", pageSize);
        map.put("condition", condition);

        PageInfo<TAdmin> pageInfo = adminService.listAdmin(map);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/index";
    }
}
