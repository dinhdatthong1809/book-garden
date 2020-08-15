import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {AppConstants} from "src/app/constants/app-constants";
import {Router} from "@angular/router";
import {AuthenticatedService} from "src/app/services/authenticated.service";
import {AlertService} from "src/app/services/alert.service";
import {SignUpDto} from "src/app/dto/request/sign-up-dto";
import {UserDto} from "src/app/dto/response/user-dto";
import {Response} from "src/app/dto/abstract-response";

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
                private _alertService: AlertService,
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
                confirmPassword: ["", [
                    Validators.required,
                    Validators.pattern(AppConstants.PASSWORD_REGEX),
                    Validators.minLength(AppConstants.PASSWORD_MIN_LENGTH),
                    Validators.maxLength(AppConstants.PASSWORD_MAX_LENGTH),
                ]]
            }
        );
    }

    get getForm() {
        return this.signUpForm.controls;
    }

    onSubmit(): void {
        this.submitted = true;

        if (this.getForm.password.value !== this.getForm.confirmPassword.value) {
            this._alertService.error("Password fields are not the same");
            return;
        }

        if (this.signUpForm.invalid) {
            return;
        }

        let signUpDto: SignUpDto = <SignUpDto> this.signUpForm.value;
        this._authenticatedService.signUp(signUpDto)
                                  .subscribe((response: Response<UserDto>) => {
                                      this._alertService.success(`Welcome to Book Garden!<br>You can sign in <a href="/sign-in">here</a>`)
                                  })
    }

}
