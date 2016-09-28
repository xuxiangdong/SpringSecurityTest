package com.stsoft.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.github.pagehelper.Page;
import com.stsoft.dao.AdminManagerDao;
import com.stsoft.dao.UserDao;
import com.stsoft.entity.User;
import com.stsoft.security.UserDetailService;
import com.stsoft.service.IAdminManagerService;
import com.stsoft.service.IUserService;
import com.stsoft.util.Utility;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("adminManagerService")
public class AdminManagerServiceImpl implements IAdminManagerService
{
    private final Logger logger = Logger.getLogger(this.getClass());
    
    /**
     * 使用@Autowired注解标注userMapper变量，
     * 当需要使用UserMapper时，Spring就会自动注入UserMapper
     */
    @Autowired
    private UserDao userDao;// 注入dao
    
    @Autowired
    private AdminManagerDao adminManagerDao;
    
    @Override
    public Map getMenuById(String id)
    {
        return adminManagerDao.getMenuById(id);
    }
    
    @Override
    public List<Map> getChildrenMenuByParentid(String parentid)
    {
        return adminManagerDao.getChildrenMenuByParentid(parentid);
    }
    
    /**
     * 1、向菜单表插入数据
     * 2、向权限表插入数据
     * 3、向菜单权限中间表插入数据
     * 重写方法
     * 
     * @param param
     * @see com.stsoft.service.IAdminManagerService#addMenu(java.util.Map)
     */
    @Transactional
    @Override
    public void addMenu(Map<String, Object> param)
    {
        // 菜单信息
        String menuId = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
        Map<String, Object> menuInfo = new HashMap<String, Object>();
        menuInfo.put("id", menuId);
        menuInfo.put("title", param.get("title") == null ? "" : param.get("title"));
        menuInfo.put("parentid", param.get("parentid"));
        menuInfo.put("URL",
            param.get("URL") == null || "".equals(param.get("URL").toString().trim()) ? null : param.get("URL"));
        menuInfo.put("icon", param.get("icon"));
        // 权限表信息
        String authorityId = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
        Map<String, Object> authorityInfo = new HashMap<String, Object>();
        authorityInfo.put("id", authorityId);
        authorityInfo.put("action", menuInfo.get("URL"));
        // 菜单权限中间表信息
        Map<String, Object> menuAuthorityInfo = new HashMap<String, Object>();
        menuAuthorityInfo.put("authorityid", authorityId);
        menuAuthorityInfo.put("menuid", menuId);
        
        adminManagerDao.insertMenuInfo(menuInfo);
        adminManagerDao.insertAuthorityInfo(authorityInfo);
        adminManagerDao.insertMenuAuthorityInfo(menuAuthorityInfo);
    }
    
    @Override
    public List<HashMap<String, Object>> getAllUserAndAuthorityInfos()
    {
        Page<HashMap<String, Object>> users = (Page)userDao.getAllUsers();
        for (Map<String, Object> user : users)
        {
            // System.out.println(Utility.tojson(getMenu("C27DE30FB5D5DD1378737865061A2152")));
            // m.put("menus",Utility.tojson(getMenu("C27DE30FB5D5DD1378737865061A2152")));
            // user.put("menus", getMenu("C27DE30FB5D5DD1378737865061A2152",user.get("username").toString()));
            UserDetails ud = userDetailService.loadUserByUsername(user.get("username").toString());
            Collection<GrantedAuthority> allAuth = ud.getAuthorities();// SecurityContextHolder.getContext().getAuthentication().getAuthorities();
            user.put("auths", allAuth);
        }
        return users;
    }
    
    @Autowired
    IUserService userService;
    
    @Autowired
    private UserDetailService userDetailService;
    
    private Map getMenu(String id, String account)
    {
        UserDetails ud = userDetailService.loadUserByUsername(account);
        Collection<GrantedAuthority> allAuth = ud.getAuthorities();// SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        
        Map<String, Object> l = userService.getMenuInfoById(id);
        if (l == null)
            return null;
        if (l.get("AUTHORITYID") == null || "".equals(l.get("AUTHORITYID").toString().trim()))
        {
            return null;
        }
        GrantedAuthorityImpl grantedAuthorityImpl = new GrantedAuthorityImpl(l.get("AUTHORITYID").toString());
        if (!allAuth.contains(grantedAuthorityImpl))
        {
            l.put("isChecked", false);
        }
        else
        {
            l.put("isChecked", true);
        }
        Map m = new HashMap<String, Object>();
        m.put("ID", l.get("ID"));
        m.put("PARENTID", l.get("PARENTID"));
        m.put("TITLE", l.get("TITLE"));
        m.put("URL", l.get("URL"));
        m.put("ICON", l.get("ICON"));
        m.put("isChecked", l.get("isChecked"));
        m.put("CHILDREN", new ArrayList<Map<String, Object>>());
        List childs = userService.getChildrenMenuInfoByParentId(id);
        for (Object object : childs)
        {
            Map m2 = getMenu(((Map)object).get("ID").toString(), account);
            if (m2 != null)
                ((ArrayList<Map<String, Object>>)m.get("CHILDREN")).add(m2);
        }
        return m;
    }
    
    @Override
    public void addUsersAuthoritys(List<HashMap<String,Object>> datas)
    {
        adminManagerDao.addUsersAuthoritys(datas);
    }

    @Override
    public void deleteUsersAuthoritys(List<HashMap<String, Object>> datas)
    {
        adminManagerDao.deleteUsersAuthoritys(datas);
    }
}
