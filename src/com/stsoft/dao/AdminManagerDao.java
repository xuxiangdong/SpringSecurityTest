package com.stsoft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stsoft.entity.User;

public interface AdminManagerDao
{
    public Map getMenuById(String id);
    
    public List<Map> getChildrenMenuByParentid(String parentid);
    
    public int insertMenuInfo(Map<String, Object> menuInfo);
    
    public int insertAuthorityInfo(Map<String, Object> authorityInfo);
    
    public int insertMenuAuthorityInfo(Map<String, Object> menuAuthorityInfo);
    
    public void addUsersAuthoritys(List<HashMap<String,Object>> datas);
    
    public void deleteUsersAuthoritys(List<HashMap<String,Object>> datas);
}
