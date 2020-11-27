package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface AdminService {
    TAdmin login(String loginacct, String userpswd);

    PageInfo<TAdmin> listAdmin(Map<String, Object> map);

    void saveAdmin(TAdmin admin);

    TAdmin getAdminById(Integer id);

    void updateAdminById(TAdmin admin);

    void deleteAdminById(Integer id);

    void deleteBatch(String ids);
}
