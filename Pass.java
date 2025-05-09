import java.security.MessageDigest;
...
MessageDigest md = MessageDigest.getInstance("SHA-256");
byte[] hashed = md.digest(password.getBytes(StandardCharsets.UTF_8));
String hashedPassword = Base64.getEncoder().encodeToString(hashed);

