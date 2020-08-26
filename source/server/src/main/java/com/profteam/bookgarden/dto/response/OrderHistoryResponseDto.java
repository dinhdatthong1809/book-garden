package com.profteam.bookgarden.dto.response;

import java.util.List;

import com.profteam.bookgarden.dto.OrderDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderHistoryResponseDto {

	List<OrderDto> list;

	long totalElements;

}
