package com.profteam.bookgarden.validator.notnull;

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
 * The Interface NotNull.
 *
 */
@Documented
@Constraint(validatedBy = {NotNullValidator.class, ObjNotNullValidator.class})
@Target({METHOD, FIELD, PARAMETER})
@Retention(RUNTIME)
public @interface NotNull {

    /**
     * Message.
     *
     * @return the string
     */
    String message() default Constants.CONST_STR_BLANK;

    /**
     * Item name.
     *
     * @return the string
     */
    String itemName() default Constants.CONST_STR_BLANK;

    /**
     * Groups.
     *
     * @return the class[]
     */
    Class<?>[] groups() default {};

    /**
     * Payload.
     *
     * @return the class<? extends payload>[]
     */
    Class<? extends Payload>[] payload() default {};

    /**
     * Defines several {@link NotNull} annotations on the same element.
     *
     * @see javax.validation.constraints.NotNull
     */
    @Target({METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE})
    @Retention(RUNTIME)
    @Documented
    @interface List {

        /**
         * Value.
         *
         * @return the not null[]
         */
        NotNull[] value();
    }
}
