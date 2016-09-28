package com.stsoft.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stsoft.entity.User;

public interface IAdminManagerService
{
    public Map getMenuById(String id);
    
    public List<Map> getChildrenMenuByParentid(String parentid);
    
    public void addMenu(Map<String, Object> param);
    
    public List<HashMap<String, Object>> getAllUserAndAuthorityInfos();
    
    public void addUsersAuthoritys(List<HashMap<String, Object>> datas);
    
    public void deleteUsersAuthoritys(List<HashMap<String, Object>> datas);
}
