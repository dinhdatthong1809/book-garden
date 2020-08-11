import {ErrorHandler, Injectable} from '@angular/core';
import {AlertService} from "src/app/services/alert.service";
import {HttpErrorResponse} from "@angular/common/http";
import {AppUrl} from "src/app/constants/app-url";
import * as HttpStatus from "http-status-codes";

@Injectable({
    providedIn: 'root'
})
export class ErrorHandlerService implements ErrorHandler {

    constructor(private _alertService: AlertService) {

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
                window.location.href = `/${AppUrl.ERROR}`;
                return;
            }

            if (error.status === HttpStatus.NOT_FOUND) {
                window.location.href = `/${AppUrl.ERROR}`;
                return;
            }

            this._alertService.error(error.error.response.message);
            return;
        }

        this._alertService.error(error);
        console.log(error)
        // window.location.href = `/${AppUrl.ERROR}`;
    }

}
