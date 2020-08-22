import {ErrorHandler, Injectable} from '@angular/core';
import {AlertService} from "src/app/services/alert.service";
import {HttpErrorResponse} from "@angular/common/http";
import {AppUrl} from "src/app/constants/app-url";
import * as HttpStatus from "http-status-codes";
import {Router} from "@angular/router";

@Injectable({
    providedIn: 'root'
})
export class ErrorHandlerService implements ErrorHandler {

    constructor(private _alertService: AlertService, private _router: Router) {

    }

    handleError(error: any): void {
        if (!error) {
            return;
        }

        if (error instanceof ErrorEvent) {
            this._alertService.error("Error has occurred in client");
            return;
        }

        if (error instanceof HttpErrorResponse) {

            // lost connection to server app
            if (error.status === 0) {
                console.log(error);
                this._alertService.error("Lost connect to server!");
                return;
            }
            if (error.status === HttpStatus.NOT_FOUND) {
                console.log(error);
                this._alertService.error(error.error.response.message);
                return;
            }

            this._alertService.error(error.error.response.message);
            return;
        }

        this._alertService.error(error);
        console.log(error);
        // window.location.href = `/${AppUrl.ERROR}`;
    }

}
