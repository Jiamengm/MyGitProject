package com.atguigu.atcrowdfunding.component;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.Set;

public class TAdminUser extends User {

    TAdmin admin;

    Set<GrantedAuthority> authorList;


    public TAdminUser(TAdmin admin, Set<GrantedAuthority> authorList){
//        super(admin.getLoginacct(),admin.getUserpswd(),authList);
        super(admin.getLoginacct(),admin.getUserpswd(),true,true,
                true,true,authorList);
        this.admin = admin;
        this.authorList = authorList;

    }

    public TAdmin getAdmin() {
        return admin;
    }

    public void setAdmin(TAdmin admin) {
        this.admin = admin;
    }

    public Set<GrantedAuthority> getAuthorList() {
        return authorList;
    }

    public void setAuthorList(Set<GrantedAuthority> authorList) {
        this.authorList = authorList;
    }
}
