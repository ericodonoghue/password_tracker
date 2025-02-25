package com.eric.backend.controllers;

import com.eric.backend.services.PasswordService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/password")
public class PasswordController {

    private final PasswordService passwordService;

    public PasswordController(PasswordService passwordService) {
        this.passwordService = passwordService;
    }

    @PostMapping("/newPassword")
    public ResponseEntity<?> newPassword(@RequestBody Map<String, String> body) {
        // todo sanitize input
        String applicationName = body.get("applicationName");
        String applicationURL = body.get("applicationURL");
        String username = body.get("username");
        String password = body.get("password");
        String notes = body.get("notes");

        // TODO sanitize input
        if (applicationName == null || applicationURL == null || username == null || password == null ||
                applicationName.isEmpty() || applicationURL.isEmpty()|| username.isEmpty() || password.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("error", "Missing required fields"));
        }

        // TODO escape special characters
        // TODO validate URL
        // TODO username characters
        // TODO password characters


        // TODO check password strength and show a warning if it's weak
        try {
            //passwordService.newPassword(applicationName, applicationURL, username, password, notes);
            System.out.println("New password created");
        }
        catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
        return ResponseEntity.ok(Map.of("message", "Password Saved"));
    }

    @GetMapping("/allPasswords")
    public ResponseEntity<?> allPasswords() {
        return ResponseEntity.ok(passwordService.getAllPasswords());
    }

    @GetMapping("/getPassword")
    public ResponseEntity<?> getPassword(@RequestBody Map<String, String> body) {
        return ResponseEntity.ok(passwordService.getPassword(body.get("id"), body.get("applicationName")));
    }
}
