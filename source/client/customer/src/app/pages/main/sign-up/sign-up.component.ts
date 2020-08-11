import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {AppConstants} from "src/app/constants/app-constants";
import {Router} from "@angular/router";
import {AuthenticatedService} from "src/app/services/authenticated.service";

@Component({
    selector: 'app-sign-up',
    templateUrl: './sign-up.component.html',
    styleUrls: ['./sign-up.component.css']
})
export class SignUpComponent implements OnInit {

    signUpForm: FormGroup;

    submitted: boolean = false;

    appConstants = AppConstants;

    constructor(private _formBuilder: FormBuilder,
                private _router: Router,
                private _authenticatedService: AuthenticatedService) {
    }

    ngOnInit(): void {
        if (this._authenticatedService.isAuthenticated()) {
            this._router.navigateByUrl("/");
        }

        this.initForm();
    }

    private initForm(): void {
        this.signUpForm = this._formBuilder.group(
            {
                username: ["", [
                    Validators.required,
                    Validators.pattern(AppConstants.USERNAME_REGEX),
                    Validators.minLength(AppConstants.USERNAME_MIN_LENGTH),
                    Validators.maxLength(AppConstants.USERNAME_MAX_LENGTH),
                ]],
                password: ["", [
                    Validators.required,
                    Validators.pattern(AppConstants.PASSWORD_REGEX),
                    Validators.minLength(AppConstants.PASSWORD_MIN_LENGTH),
                    Validators.maxLength(AppConstants.PASSWORD_MAX_LENGTH),
                ]],
                email: ["", [
                    Validators.required,
                    Validators.pattern(AppConstants.EMAIL_REGEX),
                    Validators.minLength(AppConstants.EMAIL_MIN_LENGTH),
                    Validators.maxLength(AppConstants.EMAIL_MAX_LENGTH),
                ]]
            }
        );
    }

    get getForm() {
        return this.signUpForm.controls;
    }

    onSubmit(): void {
        this.submitted = true;

        if (this.signUpForm.invalid) {
            return;
        }

        console.log(this.getForm.username.value);
        console.log(this.getForm.password.value);
    }

}
