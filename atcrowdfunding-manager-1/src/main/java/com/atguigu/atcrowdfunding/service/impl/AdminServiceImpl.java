package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.dao.TAdminMapper;
import com.atguigu.atcrowdfunding.exception.LoginException;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.DateUtil;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private TAdminMapper adminMapper;

    @Override
    public TAdmin login(String loginacct, String userpswd) {

        TAdminExample example = new TAdminExample();

        example.createCriteria().andLoginacctEqualTo(loginacct);

        List<TAdmin> adminList = adminMapper.selectByExample(example);

        if(adminList == null || adminList.size() != 1){
            throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
        }
        TAdmin admin = adminList.get(0);
        if(!admin.getUserpswd().equals(MD5Util.digest(userpswd))){
            throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
        }

        return admin;
    }

    @Override
    public PageInfo<TAdmin> listAdmin(Map<String, Object> map) {
        Integer pageNo = (Integer) map.get("pageNo");
        Integer pageSize = (Integer) map.get("pageSize");
        String condition = (String) map.get("condition");

        PageHelper.startPage(pageNo,pageSize);
        TAdminExample example = new TAdminExample();

        if(!StringUtils.isEmpty(condition)){
            example.createCriteria().andLoginacctLike("%"+condition+"%");

            TAdminExample.Criteria c2 = example.createCriteria();
            c2.andUsernameLike("%"+condition+"%");

            TAdminExample.Criteria c3 = example.createCriteria();
            c3.andEmailLike("%"+condition+"%");

            example.or(c2);

            example.or(c3);

        }
        List<TAdmin> adminList = adminMapper.selectByExample(example);
        Iterator<TAdmin> iterator = adminList.iterator();
        PageInfo<TAdmin> pageInfo = new PageInfo<>(adminList,5);
        return pageInfo;
    }

    @Override
    public void saveAdmin(TAdmin admin) {

//        admin.setUserpswd(MD5Util.digest(Const.DEFALUT_PASSWORD));
        admin.setCreatetime(new BCryptPasswordEncoder().encode(Const.DEFALUT_PASSWORD));
        admin.setCreatetime(DateUtil.getFormatTime());

        adminMapper.insert(admin);
    }

    @Override
    public TAdmin getAdminById(Integer id) {
        TAdmin admin = adminMapper.selectByPrimaryKey(id);
        return admin;
    }

    @Override
    public void updateAdminById(TAdmin admin) {
        adminMapper.updateByPrimaryKeySelective(admin);
    }

    @Override
    public void deleteAdminById(Integer id) {
        adminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteBatch(String ids) {

        String[] strings = ids.split(",");
        List<Integer> list = new ArrayList<>();
        for (String string : strings) {
            Integer id = Integer.valueOf(string);
            list.add(id);
        }

        TAdminExample example = new TAdminExample();
        example.createCriteria().andIdIn(list);
        adminMapper.deleteByExample(example);
    }
}
