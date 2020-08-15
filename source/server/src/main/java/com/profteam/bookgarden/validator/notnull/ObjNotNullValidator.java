package com.profteam.bookgarden.validator.notnull;

import javax.validation.ConstraintValidatorContext;

import org.hibernate.validator.constraintvalidation.HibernateConstraintValidator;

public class ObjNotNullValidator implements HibernateConstraintValidator<NotNull, Object> {

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        return value != null;
    }

}
