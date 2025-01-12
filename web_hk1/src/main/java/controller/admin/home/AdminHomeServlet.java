package controller.admin.home;

import model.Bill;
import model.Customer;
import service.AdminService;
import service.CustomerService;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "AdminHome", value = "/admin/trang-chu")
public class AdminHomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int[] stats = { AdminService.getCustomerCounts(), AdminService.getProductCounts(),
                AdminService.getBillCounts(), ProductService.getProductsHasQuantity(10) };
        req.setAttribute("stats", stats);

        List<Bill> recentBills = AdminService.getRecentOrderedBills(7)
                .stream().limit(10).collect(Collectors.toList());
        req.setAttribute("recent_bills", recentBills);

        List<Customer> recentCustomers = CustomerService.getRecentCustomers(7)
                .stream().limit(10).collect(Collectors.toList());
        req.setAttribute("recent_customers", recentCustomers);

        double[] revenues = new double[12];
        int[] createdCustomers = new int[12], orderedBills = new int[12];
        for (int i = 1, j = 0; i < 13 && j < 12; i++, j++) {
            revenues[j] = AdminService.getRevenueFor(i);
            createdCustomers[j] = AdminService.getCustomersCreatedIn(i);
            orderedBills[j] = AdminService.getBillsOrderedIn(i).size();
        }
        req.setAttribute("revenue", revenues);
        req.setAttribute("created_customers", createdCustomers);
        req.setAttribute("ordered_bills", orderedBills);

        getServletContext().getRequestDispatcher("/admin-jsp/index.jsp").forward(req, resp);
    }
}
