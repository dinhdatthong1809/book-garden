package com.profteam.bookgarden.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.profteam.bookgarden.constants.AppConstants;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDto {

    private Long id;

    private String fullname;

    @JsonFormat(pattern = AppConstants.DDMMYYYY)
    private Date dateOfBirth;

    private String email;

    private String phoneNumber;

    private String address;

}
