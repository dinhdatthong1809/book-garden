package com.profteam.bookgarden.dom.validator.author;

import com.profteam.bookgarden.dom.Author;
import com.profteam.bookgarden.dom.validator.abstraction.IAbstractValidator;
import com.profteam.bookgarden.i18n.I18nMessages;
import com.profteam.bookgarden.utils.TranslateUtil;

import javax.validation.Constraint;
import javax.validation.ConstraintValidatorContext;
import javax.validation.Payload;
import java.lang.annotation.*;
import java.time.LocalDate;

@Target(ElementType.TYPE_USE)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = CheckAuthorDateOfDeathValidator.class)
@Documented
public @interface CheckAuthorDateOfDeath {

    String message() default "";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}

class CheckAuthorDateOfDeathValidator implements IAbstractValidator<CheckAuthorDateOfDeath, Author> {

    @Override
    public void initialize(CheckAuthorDateOfDeath constraintAnnotation) {

    }

    @Override
    public boolean isValid(Author author, ConstraintValidatorContext context) {
        LocalDate dateOfBirth = author.getDateOfBirth();
        LocalDate dateOfDeath = author.getDateOfDeath();

        if (dateOfBirth == null || dateOfDeath == null) {
            return true;
        }

        boolean dateOfDeathIsAfterDateOfBirth = dateOfDeath.compareTo(dateOfBirth) > 0;

        if (dateOfDeathIsAfterDateOfBirth) {
            return true;
        }

        customMessage(
            TranslateUtil.translate(I18nMessages.DATE_OF_DEATH_MUST_BE_AFTER_DATE_OF_BIRTH),
            context
        );
        return false;
    }

}
