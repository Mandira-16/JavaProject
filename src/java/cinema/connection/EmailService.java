package cinema.connection;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailService {
    private static final Logger LOGGER = Logger.getLogger(EmailService.class.getName());
    
    public static void sendEmail(String toEmail, String subject, String body) throws MessagingException {
        // Configure email server properties
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        // Create session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("filmorcinema1@gmail.com", "fochkrjulttweuwl");
            }
        });

        try {
            // Create message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("filmorcinema1@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=utf-8");

            // Send message
            Transport.send(message);
            LOGGER.info("Email sent successfully to: " + toEmail);
            
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Failed to send email to: " + toEmail, e);
            throw e;
        }
    }
}