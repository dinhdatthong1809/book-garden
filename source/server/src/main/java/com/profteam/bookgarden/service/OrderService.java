package com.profteam.bookgarden.service;

import java.util.List;

import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.profteam.bookgarden.dom.Order;
import com.profteam.bookgarden.dto.OrderDto;
import com.profteam.bookgarden.mapper.OrderMapper;
import com.profteam.bookgarden.repository.OrderRepository;

@Service
public class OrderService {

    @Autowired
    OrderRepository orderRepository;
    
    private final OrderMapper orderMapper = Mappers.getMapper(OrderMapper.class);

    public List<OrderDto> getListOrderHistory() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Long userId = (Long) authentication.getPrincipal();

        List<Order> listOrder = orderRepository.findByUserId(userId);
        List<OrderDto> listOrderDto = orderMapper.toListOrderDto(listOrder);

        listOrderDto.stream().forEach(orderDto -> {
            double totalAmount = orderDto.getOrderDetails().stream().mapToDouble(orderDetail -> orderDetail.getAmount()*orderDetail.getPrice()).sum();
            orderDto.setTotalAmount(totalAmount);
        });

        return listOrderDto;
    }

}
