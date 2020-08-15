package com.profteam.bookgarden.validator.pattern;

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

@Documented
@Constraint(validatedBy = { PatternValidator.class })
@Target({ METHOD, FIELD, PARAMETER })
@Retention(RUNTIME)
public @interface Pattern {

    String message() default Constants.CONST_STR_BLANK;

    String itemName() default Constants.CONST_STR_BLANK;

    String pattern() default Constants.CONST_STR_BLANK;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    @Target({ METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE })
    @Retention(RUNTIME)
    @Documented
    @interface List {
        Pattern[] value();
    }

}
