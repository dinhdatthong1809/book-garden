package com.profteam.bookgarden.validator.number;

import javax.validation.ConstraintValidatorContext;
import javax.validation.metadata.ConstraintDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraintvalidation.HibernateConstraintValidator;
import org.hibernate.validator.constraintvalidation.HibernateConstraintValidatorInitializationContext;

import com.profteam.bookgarden.constants.Constants;

public class NumberValidator implements HibernateConstraintValidator<Number, String> {

    private NumberEnum type;

    @Override
    public void initialize(ConstraintDescriptor<Number> constraintDescriptor,
            HibernateConstraintValidatorInitializationContext initializationContext) {
        HibernateConstraintValidator.super.initialize(constraintDescriptor, initializationContext);
        this.type = (NumberEnum) constraintDescriptor.getAttributes().get(Constants.CONST_STR_TYPE);
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {

        if (StringUtils.isEmpty(value)) {
            return true;
        }

        return value.matches(this.type.getRegex());
    }

}
