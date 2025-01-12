package controller.admin.bill;

import database.dao.CustomerDao;
import model.Bill;
import service.CustomerService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminBillsManager", value = "/admin/quan-ly-don-hang")
public class AdminBillsManagerServlet extends HttpServlet {
    private final CustomerDao customerDao = new CustomerDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Bill> bills = CustomerService.getAllBills();
        request.setAttribute("bills", bills);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin-jsp/bills-manager.jsp");
        dispatcher.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("bill_id");
        String cus = req.getParameter("bill_cus");
        String price = req.getParameter("bill_price");;
        String address = req.getParameter("bill_address");
        String status = req.getParameter("bill_status");
        customerDao.updateBill(Integer.parseInt(id), cus, Double.parseDouble(price), extractStatusId(status), address);
        resp.sendRedirect(req.getContextPath() + "/admin/quan-ly-don-hang");
    }



    private int extractStatusId(String status) {
        switch (status) {
            case "bg-success": return 1;
            case "bg-warning": return 2;
            case "bg-info": return 4;
            case "bg-danger": return 3;
        }
        return -1;
    }
}