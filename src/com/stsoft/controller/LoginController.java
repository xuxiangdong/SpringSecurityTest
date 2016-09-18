package com.stsoft.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stsoft.service.IUserService;
import com.stsoft.util.FileUploadUtils;

@Controller
public class LoginController
{
    
    /**
     * 登陆界面
     * <功能详细描述>
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    @RequestMapping(value = "/loginpage", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView loginpage(@RequestParam(value = "error", required = false) String error,
        @RequestParam(value = "message", required = false) String message)//
    {
        ModelAndView mv = new ModelAndView("login");
        if (error != null)
        {
            HashMap<String, Object> params = new HashMap<String, Object>();
            params.put("error", error);
            params.put("message", message);
            mv.addObject("params", params);
        }
        return mv;// 此处index需要结合spring-servlet.xml配置文件的解析器来看，其中配置了前置prefix（/WEB-INF/jsp/）和suffix（.jsp）
    }
    
    @Autowired
    private SessionRegistry sr;
    
    /**
     * 
     * 本方法中获取用户信息，并根据用户信息和权限取得用户能够使用的菜单等信息并渲染到首页上去。 <br />
     * 注：本方法是通过 @see LoginSucessHandle#onAuthenticationSuccess 方法sendRedirect过来的，所以必须支持RequestMethod.GET方式访问
     * 
     * @return
     * @see LoginSucessHandle#onAuthenticationSuccess
     */
    @RequestMapping(value = "/admin", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView admin()//
    {
        ModelAndView mav = new ModelAndView("admin");// /WEB-INF/jsp/admin.jsp
        Authentication a = SecurityContextHolder.getContext().getAuthentication();
        Set<String> roles = AuthorityUtils.authorityListToSet(a.getAuthorities());
        
        Map m = getMenu("C27DE30FB5D5DD1378737865061A2152");
        
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
        mav.addObject("menu", m);
        return mav;
    }
    
    @RequestMapping(value = "/index", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView index()//
    {
        Authentication a = SecurityContextHolder.getContext().getAuthentication();
        Set<String> roles = AuthorityUtils.authorityListToSet(a.getAuthorities());
        return new ModelAndView("index");// 此处index需要结合spring-servlet.xml配置文件的解析器来看，其中配置了前置prefix（/WEB-INF/jsp/）和suffix（.jsp）
    }
    
    @RequestMapping(value = "/other", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView other()//
    {
        return new ModelAndView("other");// 此处index需要结合spring-servlet.xml配置文件的解析器来看，其中配置了前置prefix（/WEB-INF/jsp/）和suffix（.jsp）
    }
    
    /**
     * 文件上传案例
     * <一句话功能简述>
     * <功能详细描述>
     * 
     * @param request
     * @param files
     * @return
     * @see [类、类#方法、类#成员]
     */
    @RequestMapping(value = "upload", method = {RequestMethod.POST})
    @ResponseBody
    public String upload(HttpServletRequest request,
        @RequestParam(value = "myFile", required = false) MultipartFile[] files)
    {
        try
        {
            for (int i = 0; i < files.length; i++)
            {
                FileUploadUtils.upload(request, files[i]);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return "success";
    }
    
    /**
     * 文件下载案例
     * <一句话功能简述>
     * <功能详细描述>
     * 
     * @param request
     * @param response
     * @param fileName
     * @see [类、类#方法、类#成员]
     */
    @RequestMapping(value = "/download", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public void download(HttpServletRequest request, HttpServletResponse response, String fileName)
    {
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        try
        {
            response.setContentType("text/html;charset=UTF-8");
            
            request.setCharacterEncoding("UTF-8");
            
            String newFileName = new String(fileName.getBytes("ISO8859-1"), "UTF-8");
            String ctxPath = request.getSession().getServletContext().getRealPath("/") + FileUploadUtils.defaultBaseDir;
            String downLoadPath = ctxPath + /* File.separator */"/" + newFileName;
            long fileLength = new File(downLoadPath).length();
            response.setHeader("Content-disposition",
                "attachment; filename=" + new String(newFileName.getBytes("gb2312"), "ISO8859-1"));
            response.setHeader("Content-Length", String.valueOf(fileLength));
            bis = new BufferedInputStream(new FileInputStream(downLoadPath));
            bos = new BufferedOutputStream(response.getOutputStream());
            byte[] buff = new byte[2048];
            int bytesRead;
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length)))
            {
                bos.write(buff, 0, bytesRead);
            }
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            if (bis != null)
            {
                try
                {
                    bis.close();
                }
                catch (IOException e)
                {
                    e.printStackTrace();
                }
            }
            if (bos != null)
            {
                try
                {
                    bos.close();
                }
                catch (IOException e)
                {
                    e.printStackTrace();
                }
            }
        }
    }
    
    @Autowired
    private JdbcTokenRepositoryImpl tokenRepositoryImpl;
    
    @RequestMapping(value = "/test", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public void test(@RequestBody Map p, HttpServletRequest request, HttpServletResponse response)
    {
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
        for (SessionInformation sessionInformation : allSF)
        {
            User u = (User)sessionInformation.getPrincipal();
            if (u.getUsername() != null && p.get("username").equals(u.getUsername()))
            {
                // sr.removeSessionInformation(sessionInformation.getSessionId());
                sessionInformation.expireNow();
                tokenRepositoryImpl.removeUserTokens(u.getUsername());
            }
        }
    }
    
    @RequestMapping(value = "/home", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView home()
    {
        ModelAndView mav = new ModelAndView("home");// /WEB-INF/jsp/admin.jsp
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
    
    @RequestMapping(value = "/userManager", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView userManager()
    {
        ModelAndView mav = new ModelAndView("usermanager");// /WEB-INF/jsp/admin.jsp
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
    
    @RequestMapping(value = "/roleManager", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView roleManager()
    {
        ModelAndView mav = new ModelAndView("rolemanager");
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
    
    @RequestMapping(value = "/admin2", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView admin2()//
    {
        ModelAndView mav = new ModelAndView("other");// /WEB-INF/jsp/admin.jsp
        Authentication a = SecurityContextHolder.getContext().getAuthentication();
        Set<String> roles = AuthorityUtils.authorityListToSet(a.getAuthorities());
        
        List<SessionInformation> allSF = new ArrayList<SessionInformation>();
        mav.addObject("sessionInfos", allSF);
        return mav;
    }
    
    private Map getMenu(String id)
    {
        Collection<GrantedAuthority> allAuth = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        
        Map<String, Object> l = userService.getMenuInfoById(id);
        if (l.get("AUTHORITYID") == null || "".equals(l.get("AUTHORITYID").toString().trim()))
            return null;
        GrantedAuthorityImpl grantedAuthorityImpl =
            new GrantedAuthorityImpl(l.get("AUTHORITYID").toString());
        if (!allAuth.contains(grantedAuthorityImpl))
        {
            return null;
        }
        Map m = new HashMap<String, Object>();
        m.put("ID",l.get("ID"));
        m.put("PARENTID",l.get("PARENTID"));
        m.put("TITLE",l.get("TITLE"));
        m.put("URL",l.get("URL"));
        m.put("ICON",l.get("ICON"));
        m.put("CHILDREN", new ArrayList<Map<String, Object>>());
        List childs = userService.getChildrenMenuInfoByParentId(id);
        for (Object object : childs)
        {
            Map m2 = getMenu(((Map)object).get("ID").toString());
            if (m2 != null)
                ((ArrayList<Map<String, Object>>)m.get("CHILDREN")).add(m2);
        }
        return m;
    }
    
    @Autowired
    private IUserService userService;
    
    @RequestMapping(value = "/userOperate", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object userOperate(@RequestParam Map param, HttpServletRequest request, HttpServletResponse response)
    {
        com.stsoft.entity.User user = new com.stsoft.entity.User();
        user.setId(UUID.randomUUID().toString().replaceAll("-", "").toUpperCase());
        user.setUsername(param.get("username").toString());
        user.setPassword(param.get("password").toString());
        userService.addUser(user);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("message", "添加信息成功！");
        result.put("status", "200");
        result.put("data", user);
        return result;
    }
    
    @RequestMapping(value = "/getAllUsers", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object getAllUsers(@RequestParam(required = false) Map param, @RequestParam(required = false) int limit,
        @RequestParam(required = false) int offset, @RequestParam(required = false) String username,
        HttpServletRequest request, HttpServletResponse response)
    {
        PageHelper.startPage(offset, limit);
        List<HashMap<String, Object>> allUsers = userService.getAllUsers();
        PageInfo<HashMap<String, Object>> pageInfo = new PageInfo<HashMap<String, Object>>(allUsers);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("total", pageInfo.getTotal());// allUsers == null ? 0 : allUsers.size());
        result.put("rows", pageInfo.getList());
        return result;
    }
    
    @RequestMapping(value = "/deleteUserByUserId", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object deleteUserByUserId(@RequestBody ArrayList<HashMap<String, Object>> param, HttpServletRequest request,
        HttpServletResponse response)
    {
        userService.deleteUserByUserId(param);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("message", "删除信息成功！");
        result.put("status", "200");
        return result;
    }
}
