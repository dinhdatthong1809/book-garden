package com.profteam.bookgarden.utils;

import com.profteam.bookgarden.i18n.I18nMessages;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Component;

import java.util.Locale;

@Component
public class TranslateUtil {

    private static ResourceBundleMessageSource messageSource;

    @Autowired
    TranslateUtil(ResourceBundleMessageSource messageSource) {
        TranslateUtil.messageSource = messageSource;
    }

    public static String translate(I18nMessages i18nMessages) {
        Locale locale = LocaleContextHolder.getLocale();
        return messageSource.getMessage(i18nMessages.getKey(), null, locale);
    }

    public static String translate(I18nMessages i18nMessages, Object[] args) {
        Locale locale = LocaleContextHolder.getLocale();
        return messageSource.getMessage(i18nMessages.getKey(), args, locale);
    }

    public static String translate(String message) {
        Locale locale = LocaleContextHolder.getLocale();
        return messageSource.getMessage(message, null, locale);
    }

    public static String translate(String message, Object[] args) {
        Locale locale = LocaleContextHolder.getLocale();
        return messageSource.getMessage(message, null, locale);
    }

}
