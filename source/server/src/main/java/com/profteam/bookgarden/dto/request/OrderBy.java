package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.enums.OrderEnum;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderBy {

    String field;

    OrderEnum orderEnum;

}
