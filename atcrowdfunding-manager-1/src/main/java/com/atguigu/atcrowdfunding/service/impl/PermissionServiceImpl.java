package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.dao.TPermissionMapper;
import com.atguigu.atcrowdfunding.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private TPermissionMapper permissionMapper;


    @Override
    public List<TPermission> listPermission() {
        List<TPermission> permissionList = permissionMapper.selectByExample(null);
        return permissionList;
    }

    @Override
    public void savePermission(TPermission permission) {
        permissionMapper.insertSelective(permission);
    }

    @Override
    public TPermission getPermissionById(Integer id) {

        return permissionMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updatePermission(TPermission permission) {
        permissionMapper.updateByPrimaryKeySelective(permission);
    }

    @Override
    public void deletePermissionById(Integer id) {
        permissionMapper.deleteByPrimaryKey(id);
    }
}
