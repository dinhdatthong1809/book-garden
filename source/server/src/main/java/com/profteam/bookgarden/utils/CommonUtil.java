package com.profteam.bookgarden.utils;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class CommonUtil {

    public static String getMessageWithCode(String messageCode) {

        InputStream utf8in = ResponseUtil.class.getClassLoader().getResourceAsStream("i18n/messages.properties");
        Reader reader;
        try {
            reader = new InputStreamReader(utf8in, StandardCharsets.UTF_8);
            Properties props = new Properties();
            props.load(reader);
            return props.getProperty(messageCode);
        } catch (Exception e) {
            return null;
        }
    }

    public static <T> T convertJsonStringToObject(String jsonData, Class<T> typeClass) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(jsonData, typeClass);
    }

}
