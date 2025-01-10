package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(filterName = "Utf8", urlPatterns = "/*")
public class Utf8Filter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain filter)
            throws IOException, ServletException {
        req.setCharacterEncoding("utf8");
        resp.setCharacterEncoding("utf8");
        filter.doFilter(req, resp);
    }
}
