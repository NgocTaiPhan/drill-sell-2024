package vn.hcmuaf.fit.drillsell.dao;


import vn.hcmuaf.fit.drillsell.controller.notify.Page;
import vn.hcmuaf.fit.drillsell.mail.MailProperties;
import vn.hcmuaf.fit.drillsell.utils.EmailUtils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

import static javax.mail.Transport.send;

public class EmailDAO {
    //Lấy link từ CONFIRM_CODE_PAGE trong Page
    public final String LINK = "http://localhost:8080/drillsell_war/" + Page.CONFIRM_CODE_PAGE.getPageUrl();
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
public static EmailDAO getInstance(){
        if(instance==null) instance = new EmailDAO();
        return instance;
}

    public boolean sendMailOTP(String to, String subject, String confirmationCode) {
        System.out.println( MailProperties.getUsername());
        Properties props = new Properties();
        props.put("mail.smtp.host", MailProperties.getHost());
        props.put("mail.smtp.port", MailProperties.getPort());
        props.put("mail.smtp.auth", MailProperties.getAuth());
        props.put("mail.smtp.ssl.trust", MailProperties.getSsl());
        props.put("mail.smtp.starttls.enable", MailProperties.getTls());

        String username = MailProperties.getUsername();
        String password = MailProperties.getPassword();
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
            String fullEmailContent = EmailUtils.emailTemplate("Xác nhận tài khoản", LINK, confirmationCode);

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

public boolean sendMailWelcome(String to, String subject,String confirmationCode) {
    Properties props = new Properties();
    props.put("mail.smtp.host", MailProperties.getHost());
    props.put("mail.smtp.port", MailProperties.getPort());
    props.put("mail.smtp.auth", MailProperties.getAuth());
    props.put("mail.smtp.ssl.trust", MailProperties.getSsl());
    props.put("mail.smtp.starttls.enable", MailProperties.getTls());

    String username = MailProperties.getUsername();
    String password = MailProperties.getPassword();

    Authenticator auth = new Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
        }
    };

    Session session = Session.getInstance(props, auth);

    try {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(MailProperties.getUsername()));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);

        String fullEmailContent = EmailUtils.emailTemplate("Xác nhận tài khoản", LINK, confirmationCode);

        message.setContent(fullEmailContent, "text/html; charset=utf-8");

        send(message);
        System.out.println("Done");
    } catch (MessagingException e) {
        throw new RuntimeException(e);
    }

    return true;
}

    public static void main(String[] args) {
        EmailDAO.getInstance().sendMailOTP("ngoctaiphan.cv@gmail.com","Test mail","fdgfdgd");
    }

}

