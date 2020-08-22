package com.profteam.bookgarden.dto;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.profteam.bookgarden.constants.AppConstants;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDto {

    private long id;

    @JsonFormat(pattern = AppConstants.DDMMYYYY)
    private Date dateCreated;

    private List<OrderDetailDto> orderDetails;

    private double totalAmount;

    private String status;

}
