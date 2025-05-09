package com.system.utils;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtility {

    public static void sendEmail(String to, String subject, String messageText) throws MessagingException {
        final String fromEmail = "your_email@gmail.com";
        final String password = "your_app_password"; // Use App Password (not Gmail password)

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "587"); 
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setText(messageText);

        Transport.send(msg);
    }
}

