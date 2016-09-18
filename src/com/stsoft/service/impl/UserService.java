package com.stsoft.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.github.pagehelper.Page;
import com.stsoft.dao.UserDao;
import com.stsoft.entity.User;
import com.stsoft.security.UserDetailService;
import com.stsoft.service.IUserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userService")
public class UserService implements IUserService
{
    
    /**
     * 使用@Autowired注解标注userMapper变量，
     * 当需要使用UserMapper时，Spring就会自动注入UserMapper
     */
    @Autowired
    private UserDao userDao;// 注入dao
    
    @Transactional
    @Override
    public void addUser(User user)
    {
        userDao.insert(user);
    }
    
    @Override
    public User getUserById(String userId)
    {
        return userDao.selectByPrimaryKey(userId);
    }
    /**
     * 获取所有用户的信息，信息中包括用户所有权限信息
     * 重写方法
     * @return
     * @see com.stsoft.service.IUserService#getAllUsers()
     */
    @Override
    public List<HashMap<String, Object>> getAllUsers()
    {
        List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
        Page<HashMap<String, Object>> users = (Page)userDao.getAllUsers();
        for (HashMap<String, Object> hashMap : users)
        {
            hashMap.put("menus", getMenu("C27DE30FB5D5DD1378737865061A2152",hashMap.get("username").toString()));
        }
       /* for (User user : users)
        {
            HashMap<String, Object> m = new HashMap<String, Object>();
            //m.put("menus",getMenu("C27DE30FB5D5DD1378737865061A2152",user.getUsername()));
            m.put("id", user.getId());
            m.put("username", user.getUsername());
            m.put("password", user.getPassword());
            result.add(m);
        }*/
        return users;
    }
    
    @Autowired
    private UserDetailService userDetailService;
    /**
     * 根据菜单的根目录和用户的id获取菜单信息以及对应的权限信息
     * <一句话功能简述>
     * <功能详细描述>
     * @param id
     * @param userid
     * @return
     * @see [类、类#方法、类#成员]
     */
    private Map getMenu(String id,String account)
    {
        //Collection<GrantedAuthority> allAuth = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        UserDetails ud = userDetailService.loadUserByUsername(account);
        Collection<GrantedAuthority> allAuth = ud.getAuthorities();
        Map<String, Object> l = getMenuInfoById(id);
        if (l.get("AUTHORITYID") == null || "".equals(l.get("AUTHORITYID").toString().trim()))
            return null;
        GrantedAuthorityImpl grantedAuthorityImpl =
            new GrantedAuthorityImpl(l.get("AUTHORITYID").toString());
        if (allAuth.contains(grantedAuthorityImpl))
        {
            l.put("hasAuthority", "true");
        }
        else
        {
            l.put("hasAuthority", "false");
        }
        Map m = new HashMap<String, Object>();
        m.put("ID",l.get("ID"));
        m.put("PARENTID",l.get("PARENTID"));
        m.put("TITLE",l.get("TITLE"));
        m.put("URL",l.get("URL"));
        m.put("ICON",l.get("ICON"));
        m.put("CHILDREN", new ArrayList<Map<String, Object>>());
        m.put("HASAUTHORITY", l.get("hasAuthority"));
        List childs = getChildrenMenuInfoByParentId(id);
        for (Object object : childs)
        {
            Map m2 = getMenu(((Map)object).get("ID").toString(),account);
            if (m2 != null)
                ((ArrayList<Map<String, Object>>)m.get("CHILDREN")).add(m2);
        }
        return m;
    }
    /**
     * 事务处理必需抛出异常 spring 才会帮事务回滚
     * 
     * @param orders
     */
    @Transactional
    @Override
    public void deleteUserByUserId(ArrayList<HashMap<String, Object>> users)
    {
        List<String> ids = new ArrayList<String>();
        for (Map map : users)
        {
            Object id = map.get("id");
            if (id != null && !"".equals(id.toString().trim()))
            {
                ids.add(id.toString());
            }
        }
        userDao.deleteUserByUserId(users);
    }
    
    @Override
    public User search(String username)
    {
        List<User> allUsers = new ArrayList<User>();
        User u = userDao.selectByAccount(username);
        return u;
    }
    
    /**
     * 根据用户账号查找用户的所有权限
     * 1、用户权限
     * 2、用户——用户组——组权限
     * 3、用户——用户组——角色——角色权限
     * 4、用户——用户组——角色——角色组——角色组权限
     * 5、用户——角色——权限
     * 6、用户——角色组——权限
     * <功能详细描述>
     * 
     * @param username
     * @return
     * @see [类、类#方法、类#成员]
     */
    @Override
    public HashMap<String, Object> searchAllAuthroityByUser(String username)
    {
        HashMap<String, Object> all = new HashMap<String, Object>();
        // List<Map<String, Object>> userAllAuthroity = jdbcTemplate.queryForList(sql, username, username);
        List<Map<String, Object>> userAllAuthroity = userDao.searchAllAuthroityByUser(username);
        for (Map<String, Object> map : userAllAuthroity)
        {
            all.put(map.get("id").toString(), map.get("action"));
        }
        return all;
    }
    
    @Override
    public HashMap<String, String> getSystemAllResource()
    {
        HashMap<String, String> hashMap = new HashMap<String, String>();
        List<Map<String, Object>> allResource = userDao.selectAllAuthority();
        for (Map<String, Object> map : allResource)
        {
            hashMap.put(map.get("id").toString(), map.get("action").toString());
        }
        return hashMap;
    }
    
    @Override
    public HashMap<String, Object> getMenuInfoById(String Id)
    {
        return userDao.getMenuInfoById(Id);
    }
    
    @Override
    public List<HashMap<String, Object>> getChildrenMenuInfoByParentId(String parentid)
    {
        return userDao.getChildrenMenuInfoByParentId(parentid);
    }
}
