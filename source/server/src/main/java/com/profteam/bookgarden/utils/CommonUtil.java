package com.profteam.bookgarden.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.zip.DataFormatException;
import java.util.zip.Inflater;

import org.aspectj.util.FileUtil;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class CommonUtil {

    public static String getMessageWithCode(String messageCode) {
        InputStream utf8in = CommonUtil.class.getClassLoader().getResourceAsStream("i18n/messages.properties");
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

    public static byte[] getImage(String imageName) throws IOException {
        String path = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\images\\" + imageName;
        File file = new File(path);
        return FileUtil.readAsByteArray(file);
    }

    public static <T> T convertJsonStringToObject(String jsonData, Class<T> typeClass) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(jsonData, typeClass);
    }

    public static byte[] decompressBytes(byte[] data) {
        Inflater inflater = new Inflater();
        inflater.setInput(data);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
        byte[] buffer = new byte[1024];
        try {
            while (!inflater.finished()) {
                int count = inflater.inflate(buffer);
                outputStream.write(buffer, 0, count);
            }
            outputStream.close();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } catch (DataFormatException e) {
            e.printStackTrace();
        }
        return outputStream.toByteArray();
    }
}
