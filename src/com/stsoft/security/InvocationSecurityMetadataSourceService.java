package com.stsoft.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.AntUrlPathMatcher;
import org.springframework.security.web.util.UrlMatcher;
import org.springframework.stereotype.Service;

import com.stsoft.service.IUserService;

/*
 * 
 * 最核心的地方，就是提供某个资源对应的权限定义，即getAttributes方法返回的结果。
 * 注意，我例子中使用的是AntUrlPathMatcher这个path matcher来检查URL是否与资源定义匹配，
 * 事实上你还要用正则的方式来匹配，或者自己实现一个matcher。
 * 
 * 此类在初始化时，应该取到所有资源及其对应角色的定义
 * 
 * 说明：对于方法的spring注入，只能在方法和成员变量里注入，
 * 如果一个类要进行实例化的时候，不能注入对象和操作对象，
 * 所以在构造函数里不能进行操作注入的数据。
 */
@Service("InvocationSecurityMetadataSourceService")
public class InvocationSecurityMetadataSourceService implements FilterInvocationSecurityMetadataSource
{
    private final Logger logger = Logger.getLogger(this.getClass());
    
    private UrlMatcher urlMatcher = new AntUrlPathMatcher();
    
    private static Map<String, Collection<ConfigAttribute>> resourceMap = null;
    
    @Autowired
    private IUserService userService;
    
    // 加载所有资源与权限的关系
    public void loadResourceDefine()
        throws Exception
    {
        logger.info("InvocationSecurityMetadataSourceService.loadResourceDefine");
        this.resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
        
        // 通过数据库中的信息设置，resouce和role
        // for (TRole item : this.roleService.getAllRoles())
        // {
        // Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
        // ConfigAttribute ca = new SecurityConfig(item.getRoleName());
        // atts.add(ca);
        // List<TAction> tActionList = actionService.findByRoleID(item.getRoleId());
        // // 把资源放入到spring security的resouceMap中
        // for (TAction tAction : tActionList)
        // {
        // logger.info("获得角色：[" + item.getRoleName() + "]拥有的acton有：" + tAction.getActionUrl());
        // this.resourceMap.put(tAction.getActionUrl(), atts);
        // }
        // }
        // 从数据库中查询所有资源以及对应的权限
        HashMap<String, String> hm = userService.getSystemAllResource();
        // 通过硬编码设置，resouce和role
        resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
        Iterator iterator = hm.entrySet().iterator();
        while (iterator.hasNext())
        {
            Map.Entry entry = (Entry)iterator.next();
            Object key = entry.getKey();// 如：admin.jsp
            Object val = entry.getValue();// 如：ROLE_ADMIN
            
            Collection<ConfigAttribute> configAttributes =
                resourceMap.get(val.toString()) == null ? new ArrayList<ConfigAttribute>()
                    : resourceMap.get(val.toString());
            // Collection<ConfigAttribute> configAttributes = new ArrayList<ConfigAttribute>();
            // 以访问路径名封装为Spring的security Object
            ConfigAttribute configAttribute = new SecurityConfig(key.toString());
            configAttributes.add(configAttribute);
            resourceMap.put(val.toString(), configAttributes);
        }
        // Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
        //
        // ConfigAttribute ca = new SecurityConfig("admin");
        // atts.add(ca);
        // resourceMap.put("/jsp/admin.jsp", atts);
        // resourceMap.put("/swf/zara.html", atts);
        
    }
    
    // According to a URL, Find out permission configuration of this URL.
    public Collection<ConfigAttribute> getAttributes(Object object)
        throws IllegalArgumentException
    {
        logger.info("InvocationSecurityMetadataSourceService.getAttributes");
        // 将要反问的URL.
        String url = ((FilterInvocation)object).getRequestUrl();
        // 根据即将访问的URL，在所有URL资源中查找即将要访问的URL需要的权限。如果在系统中没有找到该路径，则返回NULL，跳转到404页面。
        Iterator<String> ite = resourceMap.keySet().iterator();
        while (ite.hasNext())
        {
            String resURL = ite.next();
            // 这段代码表示数据库内的需要验证的资源URL与当前请求的URL相匹配时进行验证
            String[] strs = url.split("\\?");
            if (urlMatcher.pathMatchesUrl(strs[0], resURL))
            {
                Collection<ConfigAttribute> returnCollection = resourceMap.get(resURL);
                return returnCollection;
            }
        }
        return null;
    }
    
    public boolean supports(Class<?> clazz)
    {
        return true;
    }
    
    public Collection<ConfigAttribute> getAllConfigAttributes()
    {
        return null;
    }
    
}