package com.eric.backend.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


import java.util.Collections;
import java.util.Map;

@RestController
public class BasicController {

    @GetMapping("/test")
    public Map<String, Object> test() {
        return Collections.singletonMap("status", "UP");
    }
}
