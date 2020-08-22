package com.profteam.bookgarden.mapper;

import java.util.List;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import com.profteam.bookgarden.dom.Order;
import com.profteam.bookgarden.dto.OrderDto;
import com.profteam.bookgarden.enums.OrderStatusEnum;

@Mapper
public interface OrderMapper {

	@Mapping(source = "status", target = "status", qualifiedByName = "getStatus")
	OrderDto toOrderDto(Order order);

	List<OrderDto> toListOrderDto(List<Order> orders);

	@Named("getStatus")
	default String getStatus(String status) {
		return OrderStatusEnum.findStatusMessage(status);
	}

}
