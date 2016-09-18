package com.stsoft.security;

import org.apache.log4j.Logger;

import java.util.Collection;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * 
 * 这个 AccessDecisionManager 被AbstractSecurityInterceptor调用，它用来作最终访问控制的决定。
 * 
 * @author 徐向东
 * @version [V1.00, 2016年4月8日]
 * @see [相关类/方法]
 * @since V1.00
 */
public class AccessDecisionManager implements org.springframework.security.access.AccessDecisionManager
{
    private static final Logger logger = Logger.getLogger(AccessDecisionManager.class);
    
    /**
     * 
     * 如果有访问某个资源需要同时拥有两个或两个以上权限的情况，这时候就要通过自定义AccessDecisionVoter来实现了 重写方法
     * 
     * @param authentication 当前用户的信息（如用户基本信息、角色权限信息等）
     * @param object 需要访问的URL地址
     * @param configAttributes 用户需要访问的URL所需的权限(如果为null，那么代表用户将要访问的路径不许任何权限)
     * @throws AccessDeniedException
     * @throws InsufficientAuthenticationException
     * @see org.springframework.security.access.AccessDecisionManager#decide(org.springframework.security.core.Authentication,
     *      java.lang.Object, java.util.Collection)
     */
    public void decide(Authentication authentication, Object object, Collection<ConfigAttribute> configAttributes)
        throws AccessDeniedException, InsufficientAuthenticationException
    {
        logger.info("AccessDecisionManager.decide");
        
        if (authentication.getPrincipal() instanceof UserDetails) {
            org.springframework.security.core.userdetails.User user =
                (org.springframework.security.core.userdetails.User)authentication.getPrincipal();
            logger.info("访问资源的用户为" + ((org.springframework.security.core.userdetails.User)authentication.getPrincipal()).getUsername());
        }
        else {
            logger.info("访问资源的用户为" + authentication.getPrincipal().toString());
        }
        
        if (configAttributes == null)
        {
            // 如果该路径没有设置权限，那么就拒绝用户访问
            // throw new AccessDeniedException("该路径没有设置任何权限！");
            // 如果访问资源不需要任何权限则直接通过
            return;
        }
        
        // 遍历configAttributes看用户是否有访问资源的权限
        for (ConfigAttribute configAttribute : configAttributes)
        {
            logger.info("needRole is：" + configAttribute.getAttribute());
            String needRole = ((SecurityConfig)configAttribute).getAttribute();
            // ga 为用户所被赋予的权限。 needRole 为访问相应的资源应该具有的权限。
            for (GrantedAuthority ga : authentication.getAuthorities())
            {
                logger.info("/t授权信息是：" + ga.getAuthority());
                if (needRole.equals(ga.getAuthority()))
                {
                    // ga is user's role.
                    return;
                }
            }
        }
        throw new AccessDeniedException("没有权限");
    }
    
    /**
     * 
     * 在启动的时候被AbstractSecurityInterceptor调用，来决定AccessDecisionManager是否可以执行传递ConfigAttribute。
     * 
     * @param attribute
     * @return
     * @see org.springframework.security.access.AccessDecisionManager#supports(org.springframework.security.access.ConfigAttribute)
     */
    public boolean supports(ConfigAttribute attribute)
    {
        return true;
    }
    
    /**
     * supports(Class)方法被安全拦截器实现调用，包含安全拦截器将显示的AccessDecisionManager支持安全对象的类型。
     * 
     * 重写方法
     * 
     * @param clazz
     * @return
     * @see org.springframework.security.access.AccessDecisionManager#supports(java.lang.Class)
     */
    public boolean supports(Class<?> clazz)
    {
        return true;
    }
}