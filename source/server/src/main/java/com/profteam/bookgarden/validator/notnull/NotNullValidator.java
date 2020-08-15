package com.profteam.bookgarden.validator.notnull;

import javax.validation.ConstraintValidatorContext;
import org.hibernate.validator.constraintvalidation.HibernateConstraintValidator;
import com.profteam.bookgarden.constants.Constants;

public class NotNullValidator implements HibernateConstraintValidator<NotNull, String> {

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value != null && !Constants.CONST_STR_BLANK.equals(value.trim())) {
            return true;
        }
        return false;
    }

}
