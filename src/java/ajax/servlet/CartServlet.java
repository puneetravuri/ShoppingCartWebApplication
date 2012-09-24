package ajax.servlet;

import ajax.store.Cart;
import java.util.Enumeration;
import javax.servlet.http.*;

public class CartServlet extends HttpServlet {

    /**
     * Updates Cart, and outputs XML representation of contents
     */
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws java.io.IOException {
        
        Enumeration headers = req.getHeaderNames();
        while (headers.hasMoreElements()) {
            String header = (String) headers.nextElement();
            System.out.println(header + ": " + req.getHeader(header));
        }
        
        Cart cart = getCartFromSession(req);
        
        String action = req.getParameter("action");
        String item = req.getParameter("item");
        
        if ((action != null) && (item != null)) {
            
            if ("add".equals(action)) {
                cart.addItem(item);
                
            } else if ("remove".equals(action)) {
                cart.removeItems(item);
            } else if ("delete".equals(action)) {
                cart.deleteItem(item);
            }
        }
        
        String cartJson = cart.toJson();
        res.setContentType("application/json");
        res.getWriter().write(cartJson);
    }
    
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws java.io.IOException {
        // Bounce to post, for debugging use
        // Hit this servlet directly from the browser to see XML
        doPost(req, res);
    }
    
    private Cart getCartFromSession(HttpServletRequest req) {
        
        HttpSession session = req.getSession(true);
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        return cart;
    }
}
