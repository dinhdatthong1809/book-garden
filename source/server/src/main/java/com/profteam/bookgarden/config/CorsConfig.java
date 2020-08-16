package com.profteam.bookgarden.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig {
    
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOrigins("http://localhost:4200", "https://book-garden.netlify.app", 
                                "http://book-garen-client.s3-website-ap-southeast-1.amazonaws.com", 
                                "http://book-garden.s3-website-ap-southeast-1.amazonaws.com")
                        .allowedMethods("GET", "POST", "PUT", "DELETE").allowCredentials(true);
            }
            
        };
    }
    
}
