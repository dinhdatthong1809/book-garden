package com.profteam.bookgarden.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.profteam.bookgarden.dom.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>{

    Page<Order> findByUserId(Long userId, Pageable pageable);

	Optional<Order> findByIdAndUserId(Long id, Long userId);

}
