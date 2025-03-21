package Controller;

import DAL.FeedbackDAO;
import DAL.OrderDAO;
import DAL.UserDAO;
import Model.UserTuan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session của người dùng
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        if (userId == null) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang login
            response.sendRedirect(request.getContextPath() + "/LoginControl");
            return;
        }

        // Gọi DAO để lấy thông tin người dùng
        UserDAO userDAO = new UserDAO();
        List<UserTuan> userInfo = userDAO.getInforUserById(userId);

        // Kiểm tra xem thông tin người dùng có tồn tại không
        if (userInfo.isEmpty()) {
            // Nếu không tìm thấy thông tin, chuyển hướng đến trang lỗi hoặc login
            response.sendRedirect(request.getContextPath() + "/LoginControl");
            return;
        }

        // Lấy email của người dùng từ thông tin đã lấy
        String email = userInfo.get(0).getEmail();

        // Gọi OrderDAO để lấy tổng số đơn hàng của người dùng
        OrderDAO orderDAO = new OrderDAO();
        int totalOrders = orderDAO.getTotalOrdersByCustomer(email);
        // lấy tổng số đơn hàng feedback
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        int totalFeedbacks = feedbackDAO.getTotalFeedbacksByUser(userId);

        // Gửi thông tin người dùng và tổng số đơn hàng sang JSP
        request.setAttribute("user", userInfo.get(0)); // Lấy thông tin người dùng đầu tiên
        request.setAttribute("totalOrders", totalOrders); // Gửi tổng số đơn hàng
        request.setAttribute("totalFeedbacks", totalFeedbacks); // Gửi tổng số lượt đánh giá

        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiện tại không xử lý POST trong servlet này
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
