package com.eric.backend.repositories;

import com.eric.backend.models.Password;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.Optional;

public interface PasswordRepository extends MongoRepository<Password, String> {
    Optional<Password> getPasswordsById(String id);

    Optional<Password> findByApplicationName(String Id, String applicationName);
}
