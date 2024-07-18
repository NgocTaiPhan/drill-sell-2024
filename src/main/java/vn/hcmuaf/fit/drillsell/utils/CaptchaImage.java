
package vn.hcmuaf.fit.drillsell.utils;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.font.FontRenderContext;
import java.awt.font.GlyphVector;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

@WebServlet("/captcha-image")
public class CaptchaImage extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("image/png");

        int iTotalChars = 6;
        int iHeight = 50;
        int iWidth = 200;

        Font[] fonts = {
                new Font("Arial", Font.BOLD, 30),
                new Font("Verdana", Font.BOLD, 30),
                new Font("Tahoma", Font.BOLD, 30),
                new Font("Georgia", Font.BOLD, 30)
        };

        Random randChars = new Random();
        StringBuilder sImageCodeBuilder = new StringBuilder(iTotalChars);
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        for (int i = 0; i < iTotalChars; i++) {
            sImageCodeBuilder.append(chars.charAt(randChars.nextInt(chars.length())));
        }
        String sImageCode = sImageCodeBuilder.toString();

        BufferedImage biImage = new BufferedImage(iWidth, iHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2dImage = (Graphics2D) biImage.getGraphics();

        // Vẽ nền
        g2dImage.setColor(Color.BLACK);
        g2dImage.fillRect(0, 0, iWidth, iHeight);
//        đường kẻ
        g2dImage.setColor(Color.WHITE);
        for (int i = 0; i < 5; i++) {
            int x1 = randChars.nextInt(iWidth);
            int y1 = randChars.nextInt(iHeight);
            int x2 = randChars.nextInt(iWidth);
            int y2 = randChars.nextInt(iHeight);
            g2dImage.drawLine(x1, y1, x2, y2);
        }

        // Vẽ các ký tự của mã biến dạng
        FontRenderContext frc = g2dImage.getFontRenderContext();
        for (int i = 0; i < iTotalChars; i++) {
            Font font = fonts[randChars.nextInt(fonts.length)];
            g2dImage.setFont(font);
            g2dImage.setColor(new Color(randChars.nextInt(255), randChars.nextInt(255), randChars.nextInt(255)));

            char c = sImageCode.charAt(i);
            GlyphVector gv = font.createGlyphVector(frc, String.valueOf(c));
            int charX = 30 * i + 10;
            int charY = 35 + randChars.nextInt(10);
            double theta = (randChars.nextDouble() - 0.5) * 0.5; // Biến dạng góc ký tự
            g2dImage.translate(charX, charY);
            g2dImage.rotate(theta);
            g2dImage.drawGlyphVector(gv, 0, 0);
            g2dImage.rotate(-theta);
            g2dImage.translate(-charX, -charY);
        }

        // Thêm một số hình tròn để tăng độ khó cho mã
        int iCircle = 6;
        for (int i = 0; i < iCircle; i++) {
            g2dImage.setColor(new Color(randChars.nextInt(255), randChars.nextInt(255), randChars.nextInt(255)));
            int x = randChars.nextInt(iWidth);
            int y = randChars.nextInt(iHeight);
            int radius = randChars.nextInt(30);
            g2dImage.drawOval(x, y, radius, radius);
        }

        // Thêm nhiều nhiễu hơn
        for (int i = 0; i <3; i++) {
            int x = randChars.nextInt(iWidth);
            int y = randChars.nextInt(iHeight);
            int size = randChars.nextInt(2);
            g2dImage.setColor(new Color(randChars.nextInt(255), randChars.nextInt(255), randChars.nextInt(255)));
            g2dImage.fillRect(x, y, size, size);
        }

        OutputStream osImage = response.getOutputStream();
        ImageIO.write(biImage, "png", osImage);

        g2dImage.dispose();

        HttpSession session = request.getSession();
        session.setAttribute("captcha_security", sImageCode);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
