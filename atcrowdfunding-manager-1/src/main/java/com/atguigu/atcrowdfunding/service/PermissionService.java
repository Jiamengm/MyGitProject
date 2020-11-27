package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TPermission;

import java.util.List;

public interface PermissionService {
    List<TPermission> listPermission();

    void savePermission(TPermission permission);

    TPermission getPermissionById(Integer id);

    void updatePermission(TPermission permission);

    void deletePermissionById(Integer id);
}
