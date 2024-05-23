//package vn.hcmuaf.fit.drillsell.controller.order;
//
//import vn.hcmuaf.fit.drillsell.dao.OrderDAO;
//import vn.hcmuaf.fit.drillsell.model.Order;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/viewEdit")
//public class viewEdit extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        List<Order> arr = OrderDAO.show(id);
//        HttpSession session = request.getSession();
//        session.setAttribute("order", arr);
//        request.getRequestDispatcher("formUpdateOrder.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        request.setCharacterEncoding("UTF-8");
//
//        // Lấy giá trị id từ request
//        int id = Integer.parseInt(request.getParameter("id"));
//
//        // Lấy trạng thái hiện tại từ cơ sở dữ liệu
//        String currentStatuss = OrderDAO.getCurrentStatus(id);
//
//        // Kiểm tra nếu currentStatuss không null và không rỗng
//        if (currentStatuss != null && !currentStatuss.isEmpty()) {
//            // Lấy giá trị statuss từ request
//            String newStatuss = request.getParameter("statuss");
//
//            // Kiểm tra nếu newStatuss không null và không rỗng
//            if (newStatuss != null && !newStatuss.isEmpty()) {
//                // Nếu trạng thái hợp lệ, tiến hành cập nhật
//                if (isvalidStatuss(newStatuss, currentStatuss)) {
//                    Order order = new Order();
//                    order.setId(id);
//                    order.setStauss(newStatuss);
//                    boolean update = OrderDAO.updateOrder(order);
//                    if (update) {
//                        // Gửi thông báo cập nhật đến trình duyệt
//                        response.getWriter().println("<script>alert('Đã cập nhật đơn hàng'); window.location.href='"
//                                + request.getContextPath() + "/viewOder.jsp';</script>");
//                    } else {
//                        request.setAttribute("err", "Trạng thái đơn hàng không hợp lệ");
//                        request.getRequestDispatcher("formUpdateOrder.jsp").forward(request, response);
//                    }
//
//                } else {
//                    request.setAttribute("err", "Trạng thái đơn hàng không hợp lệ");
//                    request.getRequestDispatcher("formUpdateOrder.jsp").forward(request, response);
//                }
//            } else {
//                request.setAttribute("err", "Trạng thái đơn hàng không hợp lệ");
//                request.getRequestDispatcher("formUpdateOrder.jsp").forward(request, response);
//            }
//        } else {
//            request.setAttribute("err", "Trạng thái đơn hàng không hợp lệ");
//            request.getRequestDispatcher("formUpdateOrder.jsp").forward(request, response);
//        }
//    }
//
//
//    private boolean isvalidStatuss(String newStatuss, String currentStatuss){
//
//        switch (currentStatuss){
//            case "Đang xử lý":
//                return  newStatuss.equals("Đã xác nhận") || newStatuss.equals("Đã hủy") ;
//            case "Đã xác nhận":
//                return newStatuss.equals("Người bán đang chuẩn bị hàng") ||  newStatuss.equals("Đã hủy") ;
//            case "Người bán đang chuẩn bị hàng":
//                return newStatuss.equals("Đã bàn giao cho đơn vị vận chuyển GHTK") || newStatuss.equals("Đã hủy")  ;
//            case "Đã bàn giao cho đơn vị vận chuyển GHTK":
//                return newStatuss.equals("Đang giao hàng") || newStatuss.equals("Đã hủy");
//            case "Đang giao hàng":
//                return newStatuss.equals("Đã giao hàng") || newStatuss.equals("Đã hủy");
//            case "Đã giao hàng":
//                return newStatuss.equals("Đã hoàn trả");
//            case "Đã hoàn trả":
//                return newStatuss.equals("Đã hoàn trả");
//            case "Đã hủy":
//                return newStatuss.equals("Đã hủy");
//        }
//        return false;
//    }
//
//}
