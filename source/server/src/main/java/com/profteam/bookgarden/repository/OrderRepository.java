package com.profteam.bookgarden.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.profteam.bookgarden.dom.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>{

    List<Order> findByUserId(Long userId);

}
