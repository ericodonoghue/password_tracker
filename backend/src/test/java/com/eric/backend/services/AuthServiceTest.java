package com.eric.backend.services;

import com.eric.backend.models.User;
import com.eric.backend.repositories.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import static org.junit.jupiter.api.Assertions.*;
import java.util.Optional;

public class AuthServiceTest {
    private AuthService authService;
    private UserRepository userRepository;

    @BeforeEach
    void setUp() {
        userRepository = Mockito.mock(UserRepository.class);
        authService = new AuthService(userRepository);
    }

    @Test
    void shouldRegisterUserSuccessfully() {
        String username = "testUser";
        String password = "password123";

        Mockito.when(userRepository.findByUsername(username)).thenReturn(Optional.empty());
        Mockito.when(userRepository.save(Mockito.any())).thenAnswer(invocation -> invocation.getArgument(0));

        User registeredUser = authService.register(username, password);
        assertNotNull(registeredUser);
        assertNotEquals(password, registeredUser.getPasswordHash()); // Password should be hashed
    }

    @Test
    void shouldFailToRegisterDuplicateUser() {
        String username = "existingUser";
        String password = "password";

        Mockito.when(userRepository.findByUsername(username)).thenReturn(Optional.of(new User(username, "hashedPassword")));

        assertThrows(IllegalArgumentException.class, () -> authService.register(username, password));
    }

    @Test
    void shouldAuthenticateValidUser() {
        String username = "validUser";
        String password = "correctPassword";
        String hashedPassword = new BCryptPasswordEncoder().encode(password);

        Mockito.when(userRepository.findByUsername(username)).thenReturn(Optional.of(new User(username, hashedPassword)));

        assertTrue(authService.authenticate(username, password));
    }

    @Test
    void shouldFailInvalidPassword() {
        String username = "validUser";
        String password = "wrongPassword";
        String hashedPassword = new BCryptPasswordEncoder().encode("correctPassword");

        Mockito.when(userRepository.findByUsername(username)).thenReturn(Optional.of(new User(username, hashedPassword)));

        assertFalse(authService.authenticate(username, password));
    }
}

