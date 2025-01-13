package mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendMail {
    public static void sendMail(String toEmail, Email email){
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");

        Session session_send = Session.getInstance(pro, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email.getUsername(), email.getPassword());
            }
        });
        try {
            MimeMessage message = new MimeMessage(session_send);
            message.setFrom(new InternetAddress(email.getUsername()));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject(email.getSub(), "utf-8");
            message.setContent(email.getBody(), "text/html; charset=utf-8");
            Transport.send(message);
        }catch (MessagingException e){
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
        Email em = new Email("20130203@st.hcmuaf.edu.vn", "zyqc shbm dolw oyyk",
                "text gửi mail mà hơi khó á",
                "Để tạo tài khoản và sử dụng các dịch vụ của chúng tôi hãy <a href='#'>nhấn vào đây!</a>");
        sendMail("zozo369123@gmail.com", em);
        System.out.println("thanh cong");
    }
}
