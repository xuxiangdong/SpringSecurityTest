package com.stsoft.security;

import org.apache.log4j.Logger;
/**
 * @author 徐泽宇(roamer)
 * 
 *         2010-7-4
 */
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import org.springframework.security.access.SecurityMetadataSource;
import org.springframework.security.access.intercept.AbstractSecurityInterceptor;
import org.springframework.security.access.intercept.InterceptorStatusToken;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

public class FilterSecurityInterceptor extends AbstractSecurityInterceptor implements Filter
{
    private static final Logger logger = Logger.getLogger(FilterSecurityInterceptor.class);
    
    private FilterInvocationSecurityMetadataSource securityMetadataSource;
    
    @Override
    public void init(FilterConfig filterconfig)
        throws ServletException
    {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException
    {
        logger.info("FilterSecurityInterceptor.doFilter");
        FilterInvocation fi = new FilterInvocation(request, response, chain);
        invoke(fi);
    }
    
    @Override
    public void destroy()
    {
    }
    
    public Class<? extends Object> getSecureObjectClass()
    {
        return FilterInvocation.class;
    }
    
    public void invoke(FilterInvocation fi)
        throws IOException, ServletException
    {
        InterceptorStatusToken token = super.beforeInvocation(fi);// 会调用自定义的accessdecisionmanager:decide和securitymetadatasource:getattributes方法
        try
        {
            fi.getChain().doFilter(fi.getRequest(), fi.getResponse());
        }
        finally
        {
            super.afterInvocation(token, null);
        }
    }
    
    @Override
    public SecurityMetadataSource obtainSecurityMetadataSource()
    {
        return this.securityMetadataSource;
    }
    
    public void setSecurityMetadataSource(FilterInvocationSecurityMetadataSource securityMetadataSource)
    {
        this.securityMetadataSource = securityMetadataSource;
    }
    
    public FilterInvocationSecurityMetadataSource getSecurityMetadataSource()
    {
        return this.securityMetadataSource;
    }
}
