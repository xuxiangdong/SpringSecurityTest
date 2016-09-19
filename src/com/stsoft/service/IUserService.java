package com.stsoft.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stsoft.entity.User;

public interface IUserService
{
    
    /**
     * 添加用户
     * 
     * @param user
     */
    void addUser(User user);
    
    /**
     * 根据用户id获取用户
     * 
     * @param userId
     * @return
     */
    User getUserById(String id);
    
    public List<HashMap<String, Object>> getAllUsers();
    
    void deleteUserByUserId(ArrayList<HashMap<String, Object>> param);
    
    User search(String username);
    
    HashMap<String, Object> searchAllAuthroityByUser(String username);
    
    HashMap<String, String> getSystemAllResource();
    
    HashMap<String, Object> getMenuInfoById(String Id);
    
    List<HashMap<String, Object>> getChildrenMenuInfoByParentId(String parentid);
}
