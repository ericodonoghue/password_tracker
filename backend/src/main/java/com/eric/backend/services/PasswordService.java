package com.eric.backend.services;

import com.eric.backend.models.Password;
import com.eric.backend.repositories.PasswordRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PasswordService {

    private final PasswordRepository passwordRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public PasswordService(PasswordRepository passwordRepository) {
        this.passwordRepository = passwordRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public Password newPassword(String applicationName, String applicationURL, String username, String password, String notes) {
        String hashedPassword = passwordEncoder.encode(password);
        Password newPassword = new Password(applicationName, applicationURL, username, hashedPassword, notes);
        // todo save it to the correct place
        return passwordRepository.save(newPassword); // Save the new password to the database
    }

    // todo not sure how to implement this yet
    public List<Password> getAllPasswords() {
        return passwordRepository.findAll();
    }

    public Password getPassword(String id, String applicationName) {
        return passwordRepository.findByApplicationName(id, applicationName).orElseThrow();
    }

}
