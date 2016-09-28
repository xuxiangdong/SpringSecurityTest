package com.stsoft.controller;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stsoft.entity.User;
import com.stsoft.security.UserDetailService;
import com.stsoft.service.IAdminManagerService;
import com.stsoft.service.IUserService;

@Controller
@RequestMapping(value = "/adminManager")
public class AdminManagerController
{
    private final Logger logger = Logger.getLogger(this.getClass());
    
    @Autowired
    private IAdminManagerService adminManagerService;
    
    @Autowired
    private SessionRegistry sr;
    
    @Autowired
    private JdbcTokenRepositoryImpl tokenRepositoryImpl;
    
    @Autowired
    private IUserService userService;
    
    @RequestMapping(value = "/menuManager", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView userManager()
    {
        ModelAndView mav = new ModelAndView("menumanager");
        List<SessionInformation> allSF = new ArrayList<SessionInformation>();
        List<Object> objs = sr.getAllPrincipals();
        if (objs != null && objs.size() > 0)
        {
            for (Object object : objs)
            {
                List<SessionInformation> ls = sr.getAllSessions(object, false);
                allSF.addAll(ls);
            }
        }
        mav.addObject("sessionInfos", allSF);
        return mav;
    }
    
    @Autowired
    private UserDetailService userDetailService;
    
    @RequestMapping(value = "/getMenuTree", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getMenuTree(HttpServletRequest request, HttpServletResponse response)
    {
        Map m = getMenu("C27DE30FB5D5DD1378737865061A2152");
        ArrayDeque<Map> stacka = new ArrayDeque<Map>();
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("message", "获取菜单树信息成功！");
        result.put("status", "200");
        result.put("data", m);
        return result;
    }
    
    private Map getMenu(String id)
    {
        Map l = adminManagerService.getMenuById(id);
        if (l == null || l.size() == 0)
            return null;
        Map m = new HashMap<String, Object>();
        m.put("id", l.get("ID"));
        m.put("parentid", l.get("PARENTID"));
        m.put("title", l.get("TITLE"));
        m.put("url", l.get("URL"));
        m.put("icon", l.get("ICON"));
        m.put("authorityid", l.get("authorityid"));
        m.put("children", new ArrayList<Map<String, Object>>());
        List childs = adminManagerService.getChildrenMenuByParentid(id);
        for (Object object : childs)
        {
            Map m2 = getMenu(((Map)object).get("ID").toString());
            if (m2 != null)
                ((ArrayList<Map<String, Object>>)m.get("children")).add(m2);
        }
        return m;
    }
    
    @RequestMapping(value = "/addMenu", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object addMenu(@RequestParam Map param, HttpServletRequest request, HttpServletResponse response)
    {
        Map<String, Object> result = new HashMap<String, Object>();
        try
        {
            adminManagerService.addMenu(param);
            result.put("message", "添加菜单信息成功！");
            result.put("success", "true");
        }
        catch (Exception e)
        {
            logger.error(e);
            result.put("message", "添加菜单信息失败！");
            result.put("success", "false");
        }
        return result;
    }
    
    @RequestMapping(value = "/authorityManager", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView authorityManager()
    {
        ModelAndView mav = new ModelAndView("authoritymanager");
        List<SessionInformation> allSF = new ArrayList<SessionInformation>();
        List<Object> objs = sr.getAllPrincipals();
        if (objs != null && objs.size() > 0)
        {
            for (Object object : objs)
            {
                List<SessionInformation> ls = sr.getAllSessions(object, false);
                allSF.addAll(ls);
            }
        }
        mav.addObject("sessionInfos", allSF);
        return mav;
    }
    
    @RequestMapping(value = "/getAllUsers", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object getAllUsers(@RequestParam(required = false) Map param, @RequestParam(required = false) int limit, @RequestParam(required = false) int offset,
        @RequestParam(required = false) String username, HttpServletRequest request, HttpServletResponse response)
    {
        PageHelper.startPage(offset, limit);
        List<HashMap<String, Object>> allUsers = adminManagerService.getAllUserAndAuthorityInfos();
        
        userDetailService.loadUserByUsername("xxd2");
        
        PageInfo<HashMap<String, Object>> pageInfo = new PageInfo<HashMap<String, Object>>(allUsers);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("total", pageInfo.getTotal());// allUsers == null ? 0 : allUsers.size());
        result.put("rows", pageInfo.getList());
        return result;
    }
    
    @RequestMapping(value = "/getAllRoles", method = {RequestMethod.POST})
    @ResponseBody
    public Object getAllRoles(@RequestBody Map param, HttpServletRequest request, HttpServletResponse response)
    {
        Map<String, Object> result = new HashMap<String, Object>();
        try
        {
            result.put("message", "添加角色信息成功！");
            result.put("success", "true");
        }
        catch (Exception e)
        {
            logger.error(e);
            result.put("message", "添加角色信息失败！");
            result.put("success", "false");
        }
        return result;
    }
    
    @RequestMapping(value = "/asyncAuthority", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object asyncAuthority(@RequestBody List params, HttpServletRequest request, HttpServletResponse response)
    {
        List<Map> p = (List<Map>)params;
        List<HashMap<String, Object>> datas = new ArrayList<HashMap<String, Object>>();
        for (Map map : p)
        {
            Map user = (Map)map.get("user");
            List<Map> menus = (List<Map>)map.get("menus");
            for (Map map2 : menus)
            {
                HashMap data = new HashMap<String, Object>();
                data.put("userid", user.get("id"));
                data.put("authorityid", map2.get("authorityid"));
                datas.add(data);
            }
        }
        
        Map<String, Object> result = new HashMap<String, Object>();
        try
        {
            adminManagerService.addUsersAuthoritys(datas);
            result.put("message", "添加角色信息成功！");
            result.put("success", "true");
        }
        catch (Exception e)
        {
            logger.error(e);
            result.put("message", "添加角色信息失败！");
            result.put("success", "false");
        }
        return result;
    }
    
    @RequestMapping(value = "/deleteUsersAuthority", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object deleteUsersAuthority(@RequestBody List params, HttpServletRequest request, HttpServletResponse response)
    {
        List<Map> p = (List<Map>)params;
        List<HashMap<String, Object>> datas = new ArrayList<HashMap<String, Object>>();
        for (Map map : p)
        {
            List<Map> menus = (List<Map>)map.get("menus");
            for (Map map2 : menus)
            {
                HashMap data = new HashMap<String, Object>();
                data.put("userid", map.get("id"));
                data.put("authorityid", map2.get("authorityid"));
                datas.add(data);
            }
        }
        Map<String, Object> result = new HashMap<String, Object>();
        try
        {
            adminManagerService.deleteUsersAuthoritys(datas);
            result.put("message", "删除用户权限信息成功！");
            result.put("success", "true");
        }
        catch (Exception e)
        {
            logger.error(e);
            result.put("message", "删除用户权限信息失败！");
            result.put("success", "false");
        }
        return result;
    }
}
