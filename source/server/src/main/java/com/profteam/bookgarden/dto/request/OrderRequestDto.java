package com.profteam.bookgarden.dto.request;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderRequestDto {

    List<OrderDetailRequestDto> items;

}
