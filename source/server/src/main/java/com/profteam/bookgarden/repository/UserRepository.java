package com.profteam.bookgarden.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.profteam.bookgarden.dom.User;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsernameAndPassword(String username, String password);

    Optional<User> findByUsername(String username);

}
