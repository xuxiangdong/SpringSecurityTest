package com.stsoft.util;

import java.io.StringWriter;
import java.io.Writer;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Utility
{
    
    public Utility()
    {
        
    }
    
    /**
     * 将对象序列化
     * 
     * @param obj
     */
    public static String tojson(Object obj)
    {
        String userDataJSON = "";
        try
        {
            ObjectMapper mapper = new ObjectMapper();
            Writer strWriter = new StringWriter();
            mapper.writeValue(strWriter, obj);
            userDataJSON = strWriter.toString();
            // System.out.println(userDataJSON);
            
        }
        catch (Exception e)
        {
            LogFactory.getLog(Utility.class).debug(e.getMessage());
        }
        return userDataJSON;
    }
    
    /**
     * 将json字符串反序列化为对象
     * 
     * @param json
     */
    public static <T> T toobject(String json, Class<T> valueType)
    {
        T object = null;
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try
        {
            
            object = mapper.readValue(json, valueType);
        }
        catch (Exception e)
        {
            LogFactory.getLog(Utility.class).debug(e.getMessage());
            // System.out.print("json to object failed , json string: "+json);
            // e.printStackTrace();
        }
        return object;
    }
    
    public static Object toobject(String json, TypeReference valueTypeRef)
    {
        Object object = null;
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try
        {
            object = mapper.readValue(json, valueTypeRef);
        }
        catch (Exception e)
        {
            LogFactory.getLog(Utility.class).debug(e.getMessage());
        }
        return object;
    }
    
    /**
     * 获取servlet request
     * 
     * @return
     */
    public static HttpServletRequest getServletRequest()
    {
        ServletRequestAttributes sra = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes());
        if (sra == null)
            return null;
        return sra.getRequest();
    }
    
}