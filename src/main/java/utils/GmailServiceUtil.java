package utils;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.GmailScopes;
import com.google.api.services.gmail.model.Message;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.util.*;

public class GmailServiceUtil {
    private static final String APPLICATION_NAME = "Gmail API Java Servlet App";
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static final String TOKENS_DIRECTORY_PATH = "tokens";
    private static final List<String> SCOPES = Collections.singletonList(GmailScopes.GMAIL_SEND);

    private static Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT) throws Exception {
        String clientId = "344746815565-dh4qidue75img7761kori8euokthj2p8.apps.googleusercontent.com";
        String clientSecret = "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";

        GoogleClientSecrets clientSecrets = new GoogleClientSecrets()
                .setInstalled(new GoogleClientSecrets.Details()
                        .setClientId(clientId)
                        .setClientSecret(clientSecret));

        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(new FileDataStoreFactory(new File(TOKENS_DIRECTORY_PATH)))
                .setAccessType("offline")
                .build();

        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();
        return new com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp(flow, receiver)
                .authorize("user");
    }

    public static void sendEmail(String to, String subject, String templatePath, Map<String, String> placeholders) throws Exception {
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();

        Gmail service = new Gmail.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                .setApplicationName(APPLICATION_NAME)
                .build();

        MimeMessage email = createEmail(to, "me", subject, templatePath, placeholders);
        Message message = createMessageWithEmail(email);
        service.users().messages().send("me", message).execute();
    }

    private static MimeMessage createEmail(String to, String from, String subject, String templatePath, Map<String, String> placeholders)
            throws MessagingException, IOException {

        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);
        MimeMessage email = new MimeMessage(session);

        email.setFrom(new InternetAddress(from));
        email.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(to));
        email.setSubject(subject, "UTF-8");

        // Plain text fallback
        String plainText = "This is an automated message.";

        String htmlContent = loadHtmlTemplate(templatePath, placeholders);

        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setText(plainText, "UTF-8");

        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(htmlContent, "text/html; charset=UTF-8");

        MimeMultipart multipart = new MimeMultipart("alternative");
        multipart.addBodyPart(textPart);
        multipart.addBodyPart(htmlPart);

        email.setContent(multipart);

        return email;
    }

    private static String loadHtmlTemplate(String templatePath, Map<String, String> placeholders) throws IOException {
        InputStream inputStream = GmailServiceUtil.class.getClassLoader().getResourceAsStream(templatePath);
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



    private static Message createMessageWithEmail(MimeMessage email)
            throws IOException, MessagingException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        email.writeTo(buffer);
        byte[] rawBytes = buffer.toByteArray();
        String encodedEmail = Base64.getUrlEncoder().encodeToString(rawBytes);

        Message message = new Message();
        message.setRaw(encodedEmail);
        return message;
    }
}
