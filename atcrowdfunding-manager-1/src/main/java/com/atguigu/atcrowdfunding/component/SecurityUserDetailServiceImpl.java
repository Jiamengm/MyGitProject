package com.atguigu.atcrowdfunding.component;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.dao.TAdminMapper;
import com.atguigu.atcrowdfunding.dao.TPermissionMapper;
import com.atguigu.atcrowdfunding.dao.TRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class SecurityUserDetailServiceImpl implements UserDetailsService {

    @Autowired
    private TAdminMapper adminMapper;

    @Autowired
    private TRoleMapper roleMapper;

    @Autowired
    private TPermissionMapper permissionMapper;

    @Override
    public UserDetails loadUserByUsername(String loginacct) throws UsernameNotFoundException {

        TAdminExample example = new TAdminExample();
        example.createCriteria().andLoginacctEqualTo(loginacct);
        List<TAdmin> list = adminMapper.selectByExample(example);

        if(list.isEmpty() || list.size() == 0){
            return null;
        }
        TAdmin admin = list.get(0);
        Integer id = admin.getId();

        List<TRole> roleList = roleMapper.listRoleByAdminId(id);

        List<TPermission> permissionList = permissionMapper.listPermissionByAdminId(id);

        Set<GrantedAuthority> authList = new HashSet<>();
        roleList.forEach(role -> {
            authList.add(new SimpleGrantedAuthority("ROLE_" + role.getName()));
        });
        permissionList.forEach(permission -> {
            authList.add(new SimpleGrantedAuthority(permission.getName()));
        });

        System.out.println("admin.getLoginacct() = " + admin.getLoginacct());
        System.out.println("authList = " + authList);

        User user = new TAdminUser(admin,authList);

        return user;
    }
}
