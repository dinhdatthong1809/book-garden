import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {AppConstants} from "src/app/constants/app-constants";
import {AuthenticatedService} from "src/app/services/authenticated.service";
import {SignInDto} from "src/app/dto/request/sign-in-dto";
import {UserDto} from "src/app/dto/response/user-dto";
import {AlertService} from "src/app/services/alert.service";
import {getData, Response} from "src/app/dto/abstract-response";
import {Router} from "@angular/router";
import {Location} from "@angular/common";

@Component({
    selector: 'app-sign-in',
    templateUrl: './sign-in.component.html',
    styleUrls: ['./sign-in.component.css']
})
export class SignInComponent implements OnInit {

    signInForm: FormGroup;

    submitted: boolean = false;

    appConstants = AppConstants;

    constructor(private _formBuilder: FormBuilder,
                private _alertService: AlertService,
                private _location: Location,
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
        this.signInForm = this._formBuilder.group(
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
                ]]
            }
        );
    }

    get getForm() {
        return this.signInForm.controls;
    }

    onSubmit(): void {
        this.submitted = true;

        if (this.signInForm.invalid) {
            return;
        }

        let signInDto: SignInDto = <SignInDto> this.signInForm.value;

        this._authenticatedService.signIn(signInDto)
                                  .subscribe((response: Response<UserDto>) => {
                                      let userDto = getData<UserDto>(response);
                                      this._alertService.success(`Welcome back ${userDto.fullname}!`);
                                      this._authenticatedService.saveUserToLocal(signInDto);
                                      this._location.back();
                                  });
    }

}
