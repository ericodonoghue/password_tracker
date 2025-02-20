package com.eric.backend.services;

import com.eric.backend.models.User;
import com.eric.backend.repositories.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class AuthService {
    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public User register(String username, String password) {
        if (userRepository.findByUsername(username).isPresent()) {
            throw new IllegalArgumentException("Username already taken");
        }
        String hashedPassword = passwordEncoder.encode(password);
        User newUser = new User(username, hashedPassword);
        return userRepository.save(newUser);
    }

    public boolean authenticate(String username, String password) {
        Optional<User> user = userRepository.findByUsername(username);
        return user.map(value -> passwordEncoder.matches(password, value.getPasswordHash())).orElse(false);
    }
}

