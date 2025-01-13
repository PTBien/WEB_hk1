package utils;

import org.mindrot.jbcrypt.BCrypt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    public static boolean checkPassword(String inputPassword, String storedPasswordHash) {
        String hashedInputPassword = hashPassword(inputPassword);
        return hashedInputPassword.equals(storedPasswordHash);
    }

    // Phương thức hash mật khẩu
//    public static String hashPassword(String plainTextPassword) {
//        // Tạo một salt ngẫu nhiên với cost factor = 12
//        String salt = BCrypt.gensalt(); // 12 là mức độ bảo mật (cost factor)
//        // Tạo hash từ mật khẩu với salt
//        return BCrypt.hashpw(plainTextPassword, salt);
//    }
    public static String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xFF & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();  // Trả về chuỗi MD5
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error while hashing password", e);
        }
    }


}

