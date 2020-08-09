package com.profteam.bookgarden.dto.response;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginResponseDto {

    private Long id;

    private String username;

    private String fullname;

    private Date dateOfBirth;

    private String email;

    private String phoneNumber;

}
