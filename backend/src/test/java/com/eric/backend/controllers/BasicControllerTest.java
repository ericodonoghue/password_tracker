package com.eric.backend.controllers;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class BasicControllerTest {

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    void basicEndpointTest() {
        ResponseEntity<String> response = restTemplate.getForEntity("/test", String.class);

        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals("{\"status\":\"UP\"}", response.getBody());
    }
}
