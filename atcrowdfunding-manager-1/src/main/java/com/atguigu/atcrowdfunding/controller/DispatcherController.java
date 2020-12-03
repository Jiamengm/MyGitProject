package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.dao.TMenuMapper;
import com.atguigu.atcrowdfunding.exception.LoginException;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.service.MenuService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class DispatcherController {

    Logger logger = LoggerFactory.getLogger(DispatcherController.class);

    @Autowired
    private AdminService adminService;

    @Autowired
    private MenuService menuService;



//    @RequestMapping("/logout")
//    public String logout(HttpSession session){
//        TAdmin admin = (TAdmin) session.getAttribute("admin");
//        if(admin != null){
//            session.invalidate();
//        }
//        return "redirect:/login.jsp";
//    }

    @RequestMapping("/main")
    public String main(HttpSession session) {

        List<TMenu> parentList = (List<TMenu>) session.getAttribute("parentList");

        if (parentList == null) {
            parentList = menuService.listMenuParent();
            session.setAttribute("parentList",parentList);
        }
        System.out.println("parentList = " + parentList);
        return "main";
    }

//    @RequestMapping("/login")
//    public String login(String loginacct, String userpswd,
//                        HttpSession session,
//                        Model model) {
//        System.out.println("loginacct = " + loginacct);
//        System.out.println("userpswd = " + userpswd);
//
//        try {
//            TAdmin admin = adminService.login(loginacct, userpswd);
//            session.setAttribute("admin", admin);
//            logger.debug("登录成功：loginacct=" + loginacct);
//            return "redirect:/main";
//        } catch (LoginException e) {
////            e.printStackTrace();
//            model.addAttribute("message", e.getMessage());
//            logger.error("loginacct=" + loginacct + "登录失败");
//            return "forward:/login.jsp";
//        } catch (Exception e) {
////            e.printStackTrace();
//            model.addAttribute("message", "系统异常");
//            logger.error("loginacct=" + loginacct + "登录,系统异常");
//            return "forward:/login.jsp";
//        }
//    }


}
