package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping("/menu/index")
    public String index(){
        return "menu/index";
    }


    @ResponseBody
    @RequestMapping("/menu/loadTree")
    public List<TMenu> listTree(){
        List<TMenu> menuList = menuService.listMenu();
        return menuList;
    }

    @ResponseBody
    @RequestMapping("/menu/add")
    public String addMenu(TMenu menu){

        menuService.saveMenu(menu);

        return "ok";
    }



    @ResponseBody
    @RequestMapping("/menu/toUpdate")
    public TMenu toUpdate(Integer id){

        TMenu menu = menuService.getMenuById(id);

        return menu;
    }

    @ResponseBody
    @RequestMapping("/menu/doUpdate")
    public String doUpdate(TMenu menu){
        menuService.updateMenu(menu);
        return "ok";
    }



    @ResponseBody
    @RequestMapping("/menu/delMenu")
    public String delMenu(Integer id){
        menuService.deleteMenuById(id);
        return "ok";
    }

}
