package com.ld.gg.service;
import java.security.SecureRandom;
import java.util.Random;

public class PasswordGenerator {

    private static final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
    private static final String NUMBER = "0123456789";
    private static final String OTHER_CHAR = "!@#$%&*()_+-=[]?";

    private static final String PASSWORD_ALLOW_BASE = CHAR_LOWER + CHAR_UPPER + NUMBER + OTHER_CHAR;
    private static final int PASSWORD_LENGTH = 10;

    private static final Random random = new SecureRandom();

    public static String generateTemporaryPassword() {

        StringBuilder passwordBuilder = new StringBuilder(PASSWORD_LENGTH);

        for (int i = 0; i < PASSWORD_LENGTH; i++) {
            int randomCharIndex = random.nextInt(PASSWORD_ALLOW_BASE.length());
            passwordBuilder.append(PASSWORD_ALLOW_BASE.charAt(randomCharIndex));
        }

        return passwordBuilder.toString();
    }

}
