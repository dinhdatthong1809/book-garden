package com.profteam.bookgarden.validator.number;

public enum NumberEnum {

    UNSIGNED_INTEGER("^[0-9]{1,8}$"),

    SIGNED_INTEGER("^([+-]{1})?([0-9]{1,8})*$");

    private String regex;

    private NumberEnum(String regex) {

        this.regex = regex;
    }

    public String getRegex() {
        return regex;
    }

}
