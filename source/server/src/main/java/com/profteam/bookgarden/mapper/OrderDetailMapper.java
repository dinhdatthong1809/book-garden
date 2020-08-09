package com.profteam.bookgarden.mapper;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.OrderDetail;
import com.profteam.bookgarden.dto.OrderDetailDto;

@Mapper
public interface OrderDetailMapper {

    OrderDetail toOrderDetail(OrderDetailDto orderDetailDto);

}
