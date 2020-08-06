package com.profteam.bookgarden.dto;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDto {

    private long id;

    private Date dateCreated;

    private List<OrderDetailDto> orderDetails;

    private double totalAmount;

}
