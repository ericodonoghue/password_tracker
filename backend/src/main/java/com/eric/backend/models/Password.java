package com.eric.backend.models;

import org.springframework.data.annotation.Id;

import java.util.Date;

public class Password {

    @Id
    private String id;

    private String applicationName;

    private String applicationURL;

    private String username;

    private String password;

    private String notes;

    private Date lastUpdated;

    public Password() {}

    public Password(String applicationName, String applicationURL, String username, String password, String notes) {
        this.applicationName = applicationName;
        this.applicationURL = applicationURL;
        this.username = username;
        this.password = password;
        this.notes = notes;
        this.lastUpdated = new Date();
    }

    public String getId() { return id; }

    public String getApplicationName() { return applicationName; }

    public String getApplicationURL() { return applicationURL; }

    public String getUsername() { return username; }

    public String getPassword() { return password; }

    public String getNotes() { return notes; }
}
