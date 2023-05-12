package com.ld.gg.service;

import java.security.SecureRandom;

import org.springframework.stereotype.Service;

@Service
public class MerchantIdGenerator {
	private static final String PREFIX = "ORD";
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final int LENGTH = 17; // 20 - 3 (PREFIX)

    public String generateOrderId() {
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(PREFIX);

        for (int i = 0; i < LENGTH; i++) {
            int randomIndex = random.nextInt(CHARACTERS.length());
            char randomChar = CHARACTERS.charAt(randomIndex);
            sb.append(randomChar);
        }

        return sb.toString();
    }

    public void main(String[] args) {
        String randomString = generateOrderId();
        System.out.println(randomString);
    }
}
