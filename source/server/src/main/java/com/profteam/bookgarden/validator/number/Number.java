package com.profteam.bookgarden.validator.number;

import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.ElementType.CONSTRUCTOR;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.ElementType.TYPE_USE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.profteam.bookgarden.constants.Constants;

/**
 * The annotation Number to check number valid.
 *
 */
@Documented
@Constraint(validatedBy = { NumberValidator.class })
@Target({ METHOD, FIELD })
@Retention(RUNTIME)
public @interface Number {

    String message() default Constants.CONST_STR_BLANK;

    String itemName() default Constants.CONST_STR_BLANK;

    NumberEnum type() default NumberEnum.SIGNED_INTEGER;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    @Target({ METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE })
    @Retention(RUNTIME)
    @Documented
    @interface List {
        Number[] value();
    }
}
