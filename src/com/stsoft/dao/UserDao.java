package com.stsoft.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stsoft.entity.User;

public interface UserDao
{
    int deleteByPrimaryKey(String userId);
    
    int insert(User record);
    
    int insertSelective(User record);
    
    User selectByPrimaryKey(String userId);
    
    User selectByAccount(String account);
    
    int updateByPrimaryKeySelective(User record);
    
    int updateByPrimaryKey(User record);
    
    public List<Map<String, Object>> getAllUsers();
    
    void deleteUserByUserId(ArrayList<HashMap<String, Object>> users);
    
    public List<Map<String, Object>> searchAllAuthroityByUser(String username);
    
    public List<Map<String, Object>> selectAllAuthority();
    
    HashMap<String, Object> getMenuInfoById(String Id);
    
    List<HashMap<String, Object>> getChildrenMenuInfoByParentId(String parentid);
}
