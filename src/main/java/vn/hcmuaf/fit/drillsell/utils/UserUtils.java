package vn.hcmuaf.fit.drillsell.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Instant;
import java.util.Base64;
import java.util.UUID;

public class UserUtils {
    public static String hashPassword(String password) {

        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            byte[] hash = md.digest();
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }


    public static String generateVerifyCode(int length) {
        return UUID.randomUUID().toString().substring(0, length);
    }


    public static Instant setTimeTo(int time) {
        return Instant.now().plusSeconds(time);
    }

    public static boolean isAfterNow(Instant expiryTime) {
        return Instant.now().isAfter(expiryTime);
    }
}
