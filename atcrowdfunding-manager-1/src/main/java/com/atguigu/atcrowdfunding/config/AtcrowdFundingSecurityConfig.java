package com.atguigu.atcrowdfunding.config;

import com.atguigu.atcrowdfunding.component.SecurityUserDetailServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class AtcrowdFundingSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    SecurityUserDetailServiceImpl securityUserDetailServiceImpl;




    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(securityUserDetailServiceImpl).passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests().antMatchers("/static/**","/login.jsp").permitAll()
                .anyRequest().authenticated();


        //授权登录页
        http.formLogin().loginPage("/login.jsp")
                .loginProcessingUrl("/login")
                .usernameParameter("loginacct")
                .passwordParameter("userpswd")
                .defaultSuccessUrl("/main").permitAll();


        //授权注销
        http.logout().logoutSuccessUrl("/login.jsp")
                .logoutUrl("/logout");


        //授权无权访问异常处理
        http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
            @Override
            public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AccessDeniedException e) throws IOException, ServletException {
                String header = httpServletRequest.getHeader("X-Requested-With");
                if (StringUtils.isEmpty(header)){
                    //处理同步请求
                    httpServletRequest.getRequestDispatcher("/WEB-INF/jsp/error403.jsp").forward(httpServletRequest,httpServletResponse);
                }else {
                    httpServletResponse.getWriter().write("403");
                }
            }
        });
        http.csrf().disable();
    }


}
