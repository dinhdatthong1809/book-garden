package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.enums.OrderEnum;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.domain.Sort;

@Getter
@Setter
public class OrderBy {

    String field;

    OrderEnum orderEnum;
    
    public Sort getSort() {
        return Sort.by(Sort.Direction.valueOf(orderEnum.name()), field);
    }

}
