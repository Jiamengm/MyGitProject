package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface RoleService {


    PageInfo<TRole> listRolePage(Map<String, Object> paramMap);

    void saveRole(TRole role);

    TRole getRoleById(Integer id);

    void updateRole(TRole role);

    void deleteRoleById(Integer id);

    void deleteRoleBatch(String str);

    List<TRole> listAll();

    List<Integer> listRoleIdByAdminId(Integer id);
}
