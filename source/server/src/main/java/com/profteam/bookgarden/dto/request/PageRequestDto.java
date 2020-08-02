package com.profteam.bookgarden.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageRequestDto {
    
    private int page;
    
    private int size = 1;

}
