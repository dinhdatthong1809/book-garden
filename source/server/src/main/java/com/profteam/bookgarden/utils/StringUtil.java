package com.profteam.bookgarden.utils;

public class StringUtil {

    public static boolean isNull(String str) {
        return str == null;
    }

    public static boolean isEmpty(String str) {
        return !isNull(str) && str.length() == 0;
    }

    public static boolean isNullOrEmpty(String str) {
        return isNull(str) || isEmpty(str);
    }

}
