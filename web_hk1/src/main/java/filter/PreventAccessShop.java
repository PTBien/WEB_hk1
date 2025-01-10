package filter;

import model.Customer;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "PreventAccess")
public class PreventAccessShop implements Filter {

    public void init(FilterConfig config) throws ServletException {

    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpRes = (HttpServletResponse) response;
        Customer customer = (Customer) httpReq.getSession().getAttribute("auth_customer");
//        HttpSession session = (HttpSession) httpReq.getSession(true).getAttribute("auth_customer");
//        String url = httpReq.getRequestURL().toString();
//        if(url.contains("/shop/login.jsp")){
//            System.out.println("dang chuyen huong");
//            System.out.println(httpReq.getContextPath() + "/shop/cart.jsp");
//            httpRes.sendRedirect(httpReq.getContextPath() + "/shop/cart.jsp");
//            chain.doFilter(request, response);
//        }
        if(customer == null){
            try{
                httpRes.sendRedirect(httpReq.getContextPath() + "/shop/login.jsp");
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
