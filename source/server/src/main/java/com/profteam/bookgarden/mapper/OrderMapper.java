package com.profteam.bookgarden.mapper;

import java.util.List;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.Order;
import com.profteam.bookgarden.dto.OrderDto;

@Mapper
public interface OrderMapper {

    OrderDto toOrderDto(Order order);

    List<OrderDto> toListOrderDto(List<Order> orders);

}
