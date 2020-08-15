package com.profteam.bookgarden.dto.request;

import java.util.Date;

import com.profteam.bookgarden.validator.notnull.NotNull;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateUserInfoRequestDto {

    @NotNull
    private Long id;

    @NotNull
    private String username;

    @NotNull
    private String password;

    @NotNull
    private String fullname;

    @NotNull
    private Date dateOfBirth;

    @NotNull
    private String email;

    @NotNull
    private String phoneNumber;

    @NotNull
    private boolean sex;

    @NotNull
    private String address;

}
