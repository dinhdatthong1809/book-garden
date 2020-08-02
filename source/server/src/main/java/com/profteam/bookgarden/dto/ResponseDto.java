package com.profteam.bookgarden.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResponseDto {

    @JsonProperty(index = 1)
    private String message;

    @JsonProperty(index = 2)
    private Object resultData;

    @JsonProperty(index = 3)
    private List<?> errorData;
}
