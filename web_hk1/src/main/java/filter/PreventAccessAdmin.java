package filter;

import model.Admin;
import utils.CommonString;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "PreventAccessAdmin")
public class PreventAccessAdmin implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpRes = (HttpServletResponse) response;
        Admin admin = (Admin) httpReq.getSession().getAttribute(CommonString.ADMIN_SESSION);
        String url = httpReq.getRequestURL().toString();
        if((admin == null && !url.contains("/admin/dang-nhap")) && (!url.contains("/admin/login.jsp"))){
            try{
                httpRes.sendRedirect(httpReq.getContextPath() + "/admin/dang-nhap");
                System.out.println("chuyen thanh cong");
                return;
            }catch (Exception e){
                throw new RuntimeException("khong thanh cong");
            }
        }else{
            chain.doFilter(request, response);
            return;
        }
    }
}
