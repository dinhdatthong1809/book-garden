package com.profteam.bookgarden.dom.validator.abstraction;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.lang.annotation.Annotation;

public interface IAbstractValidator<A extends Annotation, T> extends ConstraintValidator<A, T> {

    default void customMessage(String message, ConstraintValidatorContext context) {
        context.buildConstraintViolationWithTemplate(message).addConstraintViolation();
    }

}
