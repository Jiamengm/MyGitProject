package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.bean.TRolePermission;
import com.atguigu.atcrowdfunding.bean.TRolePermissionExample;
import com.atguigu.atcrowdfunding.dao.TAdminRoleMapper;
import com.atguigu.atcrowdfunding.dao.TRoleMapper;
import com.atguigu.atcrowdfunding.dao.TRolePermissionMapper;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {


    @Autowired
    private TRoleMapper roleMapper;

    @Autowired
    private TAdminRoleMapper adminRoleMapper;

    @Autowired
    private TRolePermissionMapper rolePermissionMapper;

    @Override
    public PageInfo<TRole> listRolePage(Map<String, Object> paramMap) {
        Integer pageNo = (Integer) paramMap.get("pageNo");
        Integer pageSize = (Integer) paramMap.get("pageSize");
        String condition = (String) paramMap.get("condition");

        PageHelper.startPage(pageNo, pageSize);

        TRoleExample example = new TRoleExample();
        if (!StringUtils.isEmpty(condition)) {
            example.createCriteria().andNameLike("%" + condition + "%");
        }

        List<TRole> roleList = roleMapper.selectByExample(example);
        PageInfo<TRole> pageInfo = new PageInfo<>(roleList,5);
        return pageInfo;
    }

    @Override
    public void saveRole(TRole role) {
        roleMapper.insertSelective(role);
    }

    @Override
    public TRole getRoleById(Integer id) {

        TRole role = roleMapper.selectByPrimaryKey(id);
        return role;
    }

    @Override
    public void updateRole(TRole role) {
        roleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void deleteRoleById(Integer id) {
        roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteRoleBatch(String str) {
        String[] strings = str.split(",");
        List<Integer> ids = new ArrayList<>();
        for (String string : strings) {
            Integer id = Integer.valueOf(string);
            ids.add(id);
        }
        TRoleExample example = new TRoleExample();
        example.createCriteria().andIdIn(ids);
        roleMapper.deleteByExample(example);
    }

    @Override
    public List<TRole> listAll() {
        List<TRole> roleList = roleMapper.selectByExample(null);
        return roleList;
    }

    @Override
    public List<Integer> listRoleIdByAdminId(Integer id) {
        List<Integer> roleIds = adminRoleMapper.listRoleIdByAdminId(id);
        return roleIds;
    }

    @Override
    public void saveAdminAndRoleRelationship(Integer adminId, Integer[] roleId) {
        adminRoleMapper.saveAdminAndRoleRelationship(adminId,roleId);
    }

    @Override
    public void deleteAdminAndRoleRelationship(Integer adminId, Integer[] roleId) {
        adminRoleMapper.deleteAdminAndRoleRelationship(adminId,roleId);
    }

    @Override
    public List<Integer> listPermissionByRoleId(Integer roleId) {
        return rolePermissionMapper.listPermissionByRoleId(roleId);
    }

    @Override
    public void saveRoleAndPermissionRelationship(Integer roleId, Integer[] ids) {
        TRolePermissionExample example = new TRolePermissionExample();
        example.createCriteria().andRoleidEqualTo(roleId);
        rolePermissionMapper.deleteByExample(example);
        if(ids != null && ids.length != 0){
            rolePermissionMapper.saveRoleAndPermissionRelationship(roleId,ids);
        }
    }
}
