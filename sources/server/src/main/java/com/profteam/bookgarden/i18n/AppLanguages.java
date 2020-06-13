package com.profteam.bookgarden.i18n;

import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

public enum AppLanguages {

    VIETNAM("vn"),

    ENGLISH("en");

    private Locale locale;

    AppLanguages(String code) {
        this.locale = new Locale(code);
    }

    public static List<Locale> getLocales() {
        return Arrays.stream(AppLanguages.values())
                     .map(language -> language.getLocale())
                     .collect(Collectors.toList());
    }

    public Locale getLocale() {
        return locale;
    }

}
