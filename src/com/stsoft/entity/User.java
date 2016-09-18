package com.stsoft.entity;

public class User
{
    private String id;
    
    public String getId()
    {
        return id;
    }
    
    public void setId(String id)
    {
        this.id = id;
    }
    
    private String username;
    
    private String password;
    
    public String getUsername()
    {
        return username;
    }
    
    public void setUsername(String username)
    {
        this.username = username;
    }
    
    public String getPassword()
    {
        return password;
    }
    
    public void setPassword(String password)
    {
        this.password = password;
    }
    
    /**
     * 如果账号未锁定，那么此方法返回true
     * <一句话功能简述>
     * <功能详细描述>
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    public boolean isEnabled()
    {
        return true;
    }
}
