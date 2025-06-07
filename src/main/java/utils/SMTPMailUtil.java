package utils;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class SMTPMailUtil {
    private static final String USERNAME = "irissoveriegn@gmail.com"; 
    private static final String APP_PASSWORD = "xdlj vfco chta llps"; 
    public static void sendEmail(String to, String subject, String htmlContent) throws MessagingException, UnsupportedEncodingException {
        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");


        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, APP_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(USERNAME, "4Book Corporation"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B")); 
        message.setContent(htmlContent, "text/html; charset=UTF-8");

        Transport.send(message);
    }

    public static String loadHtmlTemplate(String templatePath, Map<String, String> placeholders) throws IOException {
        InputStream inputStream = SMTPMailUtil.class.getClassLoader().getResourceAsStream(templatePath);
        if (inputStream == null) {
            throw new FileNotFoundException("Template not found in classpath: " + templatePath);
        }

        StringBuilder builder = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line).append("\n");
            }
        }

        String html = builder.toString();
        for (Map.Entry<String, String> entry : placeholders.entrySet()) {
            html = html.replace("{{" + entry.getKey() + "}}", entry.getValue().replace("\n", "<br>"));
        }

        return html;
    }
}
