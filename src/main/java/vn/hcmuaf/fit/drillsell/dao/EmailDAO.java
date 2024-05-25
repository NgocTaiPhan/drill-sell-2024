package vn.hcmuaf.fit.drillsell.dao;


import vn.hcmuaf.fit.drillsell.mail.MailProperties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

import static javax.mail.Transport.send;

public class EmailDAO {

    public final String LINK = "http://localhost:8080/input-code.jsp";
    private Properties prop = new Properties();
    private static EmailDAO instance;

    {
        prop.put("mail.smtp.host", MailProperties.getHost());
        prop.put("mail.smtp.port", MailProperties.getPort());
        prop.put("mail.smtp.auth", MailProperties.getAuth());
        prop.put("mail.smtp.starttls.enable", MailProperties.getTls());
        prop.put("mail.smtp.socketFactory.port", MailProperties.getPort());

        prop.put("mail.smtp.ssl.trust","*");
    }

    public static EmailDAO getInstance() {
        if (instance == null) instance = new EmailDAO();
        return instance;
    }

    public boolean sendMailWelcome(String to, String subject, String confirmationCode) {
        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(MailProperties.getUsername(), MailProperties.getPassword());
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(MailProperties.getUsername()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            // Tạo liên kết xác nhận
            String confirmationMessage = "Đây là mã của bạn để " + subject.toLowerCase() + " :" + confirmationCode;
            String emailContent = "Hãy nhấn vào liên kết sau để " + subject.toLowerCase() + ": <a href=\"" + LINK + "\">Xác nhận đăng ký</a>";

            String fullEmailContent = confirmationMessage + "<br/><br/>" + emailContent;

            message.setContent(fullEmailContent, "text/html; charset=utf-8");


            message.setHeader("X-Mailer", "JavaMail API");
            message.setHeader("Content-Type", "text/html; charset=utf-8");

            message.getSentDate();
            // Gửi email
            send(message);
            System.out.println("Done");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        return true;
    }
    public boolean sendMailOTP(String to, String subject, String confirmationCode) {
        System.out.println( MailProperties.getUsername());
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
//        sửa lỗi tls
        props.put("mail.smtp.ssl.trust","*");
        props.put("mail.smtp.starttls.enable", "true");
        String username = "phuonghuynh131415@gmail.com";
        String password = "pkgy kplq sjcn gwhu";

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        };

        // Tạo đối tượng Session
        Session session = Session.getInstance(props, auth);



        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(MailProperties.getUsername()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            // Tạo liên kết xác nhận
            String confirmationMessage = "Đây là mã của bạn để " + subject.toLowerCase() + " :" + confirmationCode;
            String emailContent = "Hãy nhấn vào liên kết sau để " + subject.toLowerCase() + ": <a href=\"" + LINK + "\">Xác nhận đăng ký</a>";

            String fullEmailContent = confirmationMessage + "<br/><br/>" + emailContent;

            message.setContent(fullEmailContent, "text/html; charset=utf-8");


            message.setHeader("X-Mailer", "JavaMail API");
            message.setHeader("Content-Type", "text/html; charset=utf-8");

            message.getSentDate();
            // Gửi email
            send(message);
            System.out.println("Done");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        return true;
    }

    public boolean vertifyCode(String inputCode, String systemCode) {
        return inputCode.equalsIgnoreCase(systemCode);
    }


}

