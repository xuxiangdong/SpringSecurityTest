package com.stsoft.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.stsoft.util.Utility;

/**
 * 在security的配置文件中配置了authentication-success-handler-ref，那么，form-login中的配置
 * default-target-url="/admin.jsp"
 * 就无效了
 * 
 * @author 徐向东
 * @version [V1.00, 2016年4月8日]
 * @see [相关类/方法]
 * @since V1.00
 */
public class LoginSucessHandle implements AuthenticationSuccessHandler
{
    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse, Authentication authentication)
        throws IOException, ServletException
    {
        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
        String path = httpservletrequest.getContextPath();
        String basePath = httpservletrequest.getScheme() + "://" + httpservletrequest.getServerName() + ":" + httpservletrequest.getServerPort() + path + "/";
        String redirecturl = "";
//        if (roles.contains("111"))
//        {
            redirecturl = basePath + "admin";
            // 根据不同角色跳转到不同页面地址(或者访问controller，返回ModelAndView)
            //httpservletresponse.sendRedirect(basePath + "admin");
            //return;
//        }
//        else if (roles.contains("222"))
//        {
//            redirecturl = basePath + "index";
//        }
        //httpservletresponse.sendRedirect(basePath + "index");
        
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("error", false);
        result.put("redirecturl", redirecturl);
        httpservletresponse.getOutputStream().write(Utility.tojson(result).getBytes("UTF-8"));
    }
    
}
