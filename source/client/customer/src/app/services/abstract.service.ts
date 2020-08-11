import {Injectable} from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders} from "@angular/common/http";
import {Observable, throwError} from "rxjs";
import {AlertService} from "src/app/services/alert.service";
import {SignInDto} from "src/app/dto/request/sign-in-dto";
import {SessionStorageKeys} from "src/app/constants/session-storage-keys";

@Injectable({
    providedIn: 'root'
})
export class AbstractService {

    constructor(private _http: HttpClient,
                private _alertService: AlertService) {

    }

    /**
     * Helper methods
     * */

    protected handleError(error: HttpErrorResponse): Observable<never>  {
        return throwError(error);
    }

    /**
     * HTTP methods
     * */

    protected get<RESPONSE_TYPE> (url: string, params?: any): Observable<RESPONSE_TYPE> {
        return this._http.get<RESPONSE_TYPE>(url, {params: params});
    }

    protected post<REQUEST_TYPE, RESPONSE_TYPE> (url: string, body?: REQUEST_TYPE, withCredentials?: boolean): Observable<RESPONSE_TYPE>  {
        if (!withCredentials) {
            return this._http.post<RESPONSE_TYPE>(url, body);
        }

        let signInDto: SignInDto = JSON.parse(localStorage.getItem(SessionStorageKeys.USER));

        const headers = new HttpHeaders(signInDto ? {authorization: "Basic " + btoa(signInDto.username + ":" + signInDto.password)}
                                                  : undefined);

        return this._http.post<RESPONSE_TYPE>(url, body, {headers: headers});
    }

    protected put<REQUEST_TYPE, RESPONSE_TYPE> (url: string, body: REQUEST_TYPE): Observable<RESPONSE_TYPE>  {
        return this._http.put<RESPONSE_TYPE>(url, body);
    }

    protected delete<REQUEST_TYPE, RESPONSE_TYPE> (url: string, body: REQUEST_TYPE): Observable<RESPONSE_TYPE>  {
        let options = {
            headers: new HttpHeaders({
                "Content-Type": "application/json"
            }),
            body: body
        };

        return this._http.delete<RESPONSE_TYPE>(url, options);
    }

}
