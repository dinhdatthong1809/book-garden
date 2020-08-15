package com.profteam.bookgarden.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.profteam.bookgarden.constants.AppConstants;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class RegisterResponseDto {

    private Long id;

    private String username;

    private String fullname;

    @JsonFormat(pattern = AppConstants.DDMMYYYY)
    private Date dateOfBirth;

    private String email;

    private String phoneNumber;

}
