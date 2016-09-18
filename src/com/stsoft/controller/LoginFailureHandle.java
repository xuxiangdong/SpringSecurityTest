package com.stsoft.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.stsoft.util.Utility;

/**
 * 在security的配置文件中配置了authentication-success-handler-ref，那么，form-login中的配置
 * default-target-url="/admin.jsp" 就无效了
 * 
 * @author 徐向东
 * @version [V1.00, 2016年4月8日]
 * @see [相关类/方法]
 * @since V1.00
 */
public class LoginFailureHandle implements AuthenticationFailureHandler
{
    /**
     * 
     * 重写方法
     * 
     * @param httpservletrequest
     * @param httpservletresponse
     * @param authenticationexception 如果访问地址不存在，那么就是null
     * @throws IOException
     * @throws ServletException
     * @see org.springframework.security.web.authentication.AuthenticationFailureHandler#onAuthenticationFailure(javax.servlet.http.HttpServletRequest,
     *      javax.servlet.http.HttpServletResponse, org.springframework.security.core.AuthenticationException)
     */
    @Override
    public void onAuthenticationFailure(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse, AuthenticationException authenticationexception)
        throws IOException, ServletException
    {
        String path = httpservletrequest.getContextPath();
        String basePath = httpservletrequest.getScheme() + "://" + httpservletrequest.getServerName() + ":" + httpservletrequest.getServerPort() + path + "/";
        // if (authenticationexception.getAuthentication() == null)
        StringBuilder message = new StringBuilder("");
        if (authenticationexception.getMessage() != null && !"".equals(authenticationexception.getMessage().trim()))
            message.append("?message=" + URLEncoder.encode(authenticationexception.getMessage(), "UTF-8") + "&error=true");
        // 注：此处用get方式传递中文参数可能会导致乱码，需要设置tomcat的conf目录中的server.xml文件中的<Connector port="8080" protocol="HTTP/1.1"
        // connectionTimeout="20000" redirectPort="8443" /> 标签中添加 Encoding="UTF-8" URIEncoding="UTF-8"
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("error", true);
        result.put("message", authenticationexception.getMessage());
        httpservletresponse.getOutputStream().write(Utility.tojson(result).getBytes("UTF-8"));
        //httpservletresponse.sendRedirect(basePath + "loginpage" + message.toString());
    }
    
}
