package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TMenuExample;
import com.atguigu.atcrowdfunding.dao.TMenuMapper;
import com.atguigu.atcrowdfunding.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private TMenuMapper menuMapper;

    @Override
    public List<TMenu> listMenuParent() {

        List<TMenu> menuList = menuMapper.selectByExample(null);
        List<TMenu> parents = new ArrayList<>();
        Map<Integer, TMenu> map = new HashMap<>();

        menuList.forEach(parent->{
            if(parent.getPid() == 0){
                parents.add(parent);
                Integer id = parent.getId();
                map.put(id,parent);
            }
        });

        menuList.forEach(child->{
            if(child.getPid() != 0){
                Integer pid = child.getPid();
                TMenu parent = map.get(pid);
                parent.getChildren().add(child);
            }
        });


        return parents;
    }

    @Override
    public List<TMenu> listMenu() {
        return menuMapper.selectByExample(null);
    }

    @Override
    public void saveMenu(TMenu menu) {
        menuMapper.insertSelective(menu);
    }

    @Override
    public TMenu getMenuById(Integer id) {
        TMenu menu = menuMapper.selectByPrimaryKey(id);
        return menu;
    }

    @Override
    public void updateMenu(TMenu menu) {
        menuMapper.updateByPrimaryKeySelective(menu);
    }

    @Override
    public void deleteMenuById(Integer id) {
        menuMapper.deleteByPrimaryKey(id);
    }
}
