package com.profteam.bookgarden.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.zalando.problem.ProblemModule;
import org.zalando.problem.violations.ConstraintViolationProblemModule;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

@Configuration
public class JacksonConfiguration {

    /**
     * Support for Java date and time API.
     * @return the corresponding Jackson module.
     */
    @Bean
    public JavaTimeModule javaTimeModule() {
        return new JavaTimeModule();
    }

    @Bean
    public Jdk8Module jdk8TimeModule() {
        return new Jdk8Module();
    }

/*    *//*
     * Support for Hibernate types in Jackson.
     *//*
    @Bean
    public Hibernate5Module hibernate5Module() {
        return new Hibernate5Module();
    }

    *//*
     * Jackson Afterburner module to speed up serialization/deserialization.
     *//*
    @Bean
    public AfterburnerModule afterburnerModule() {
        return new AfterburnerModule();
    }*/

    /*
     * Module for serialization/deserialization of RFC7807 Problem.
     */
    // config exception translator
    @Bean
    ProblemModule problemModule() {
        return new ProblemModule();
    }

    /*
     * Module for serialization/deserialization of ConstraintViolationProblem.
     */
    @Bean
    ConstraintViolationProblemModule constraintViolationProblemModule() {
        return new ConstraintViolationProblemModule();
    }
    
    /**
     * Mapping jackson 2 http message converter.
     *
     * @return the mapping jackson 2 http message converter
     */
    @Bean
    public MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter() {
        MappingJackson2HttpMessageConverter jacksonConverter = new MappingJackson2HttpMessageConverter();

        // Create object mapper using ProblemModule
        ObjectMapper objectMapper = Jackson2ObjectMapperBuilder.json().modules(new ProblemModule().withStackTraces(false)).build();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        // Using custom json serializer
//        SimpleModule xssModule = new SimpleModule("XssStringJsonSerializer");
//        xssModule.addSerializer(new XssStringJsonSerializer());
//        objectMapper.registerModule(xssModule);
//        objectMapper.registerModule(new JavaTimeModule());

        jacksonConverter.setObjectMapper(objectMapper);
        return jacksonConverter;
    }
}
