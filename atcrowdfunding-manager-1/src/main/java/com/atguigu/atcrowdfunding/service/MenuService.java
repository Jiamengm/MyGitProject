package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TMenu;

import java.util.List;

public interface MenuService {
    List<TMenu> listMenuParent();

    List<TMenu> listMenu();

    void saveMenu(TMenu menu);

    TMenu getMenuById(Integer id);

    void updateMenu(TMenu menu);

    void deleteMenuById(Integer id);
}
