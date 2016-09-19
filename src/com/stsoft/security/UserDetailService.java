package com.stsoft.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.stsoft.controller.LoginSucessHandle;
import com.stsoft.entity.User;
import com.stsoft.service.IUserService;

@Service
public class UserDetailService implements UserDetailsService
{
    private static final Logger logger = Logger.getLogger(UserDetailService.class);
    
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private IUserService userService;
    
    public UserDetails loadUserByUsername(String username)
        throws UsernameNotFoundException, DataAccessException
    {
        logger.info("UserDetailService.loadUserByUsername");
        Collection<GrantedAuthority> auths = new ArrayList<GrantedAuthority>();
        User user = /* userManager */userService.search(username);
        // 如果根据用户输入的用户名，查找不到用户信息，那么就表示该用户不存在，抛出用户名未发现异常
        if (user == null)
        {
            String message = "用户" + username + "不存在";
            logger.error(message);
            throw new UsernameNotFoundException(message);
        }
        
        // 如果用户名和密码正确，那么就找出当前用户的所有权限（包括用户绑定的权限，用户组的权限，用户角色的权限等等）
        HashMap<String, Object> currentAllResource = userService.searchAllAuthroityByUser(username);
        for (Map.Entry<String, Object> resource : currentAllResource.entrySet())
        {
            GrantedAuthorityImpl grantedAuthorityImpl = new GrantedAuthorityImpl(resource.getKey().toString());
            auths.add(grantedAuthorityImpl);
        }
        // 用户账号是否没有过期
        boolean accountNonExpired = true;
        // 用户凭据是否没有过期
        boolean credentialsNonExpired = true;
        // 用户账号是否没有锁定
        boolean accountNonLocked = true;
        UserDetails userdetails =
            new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
                user.isEnabled(), accountNonExpired, credentialsNonExpired, accountNonLocked, auths);
        return userdetails;
    }
    
    public JdbcTemplate getJdbcTemplate()
    {
        return jdbcTemplate;
    }
    
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate)
    {
        this.jdbcTemplate = jdbcTemplate;
    }
    
}