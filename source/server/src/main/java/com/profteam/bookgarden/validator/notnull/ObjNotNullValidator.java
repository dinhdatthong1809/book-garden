package com.profteam.bookgarden.validator.notnull;

import javax.validation.ConstraintValidatorContext;

import org.hibernate.validator.constraintvalidation.HibernateConstraintValidator;

/**
 * To validator object.
 */
public class ObjNotNullValidator implements HibernateConstraintValidator<NotNull, Object> {

    /**
     * Checks if is valid.
     *
     * @param value the value
     * @param context the context
     * @return true, if is valids
     */
    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        return value != null;
    }

}
