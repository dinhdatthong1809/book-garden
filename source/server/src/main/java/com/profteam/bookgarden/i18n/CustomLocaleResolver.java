package com.profteam.bookgarden.i18n;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Locale;

@Configuration
public class CustomLocaleResolver extends AcceptHeaderLocaleResolver implements WebMvcConfigurer {
    
    List<Locale> LOCALES = AppLanguages.getLocales();
    
    @Override
    public Locale resolveLocale(HttpServletRequest request) {
        String changeLangSignal = request.getHeader("Accept-Language");
        
        if ((changeLangSignal == null) || changeLangSignal.isEmpty()) {
            return LOCALES.get(0);
        }
        
        return Locale.lookup(Locale.LanguageRange.parse(changeLangSignal), LOCALES);
    }
    
    @Bean
    public ResourceBundleMessageSource messageSource() {
        ResourceBundleMessageSource resource = new ResourceBundleMessageSource();
        resource.setBasename("i18n/messages");
        resource.setDefaultEncoding("UTF-8");
        resource.setUseCodeAsDefaultMessage(true);
        
        return resource;
    }
    
}
