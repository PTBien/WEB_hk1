package utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmailValidator {
    // Phương thức kiểm tra định dạng email
    public static boolean isValidEmail(String email) {
        // Biểu thức chính quy để kiểm tra email
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";

        // Tạo đối tượng Pattern
        Pattern pattern = Pattern.compile(emailRegex);

        // Kiểm tra email bằng matcher
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }
}

