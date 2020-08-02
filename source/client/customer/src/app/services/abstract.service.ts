import {Injectable} from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders, HttpParams} from "@angular/common/http";
import {Observable, throwError} from "rxjs";
import {AlertService} from "src/app/services/alert.service";

@Injectable({
    providedIn: 'root'
})
export class AbstractService {

    constructor(
        private _http: HttpClient,
        private _alertService: AlertService
    ) {
    }

    /**
     * Helper methods
     * */

    handleError(error: HttpErrorResponse): Observable<never>  {
        return throwError(error);
    }

    /**
     * HTTP methods
     * */

    get <RESPONSE_TYPE> (url: string, params?: any): Observable<RESPONSE_TYPE> {
        return this._http.get<RESPONSE_TYPE>(url, {params: params});
    }

    post <REQUEST_TYPE, RESPONSE_TYPE> (url: string, body: REQUEST_TYPE): Observable<RESPONSE_TYPE>  {
        return this._http.post<RESPONSE_TYPE>(url, body);
    }

    put <REQUEST_TYPE, RESPONSE_TYPE> (url: string, body: REQUEST_TYPE): Observable<RESPONSE_TYPE>  {
        return this._http.put<RESPONSE_TYPE>(url, body);
    }

    delete <REQUEST_TYPE, RESPONSE_TYPE> (url: string, body: REQUEST_TYPE): Observable<RESPONSE_TYPE>  {
        let options = {
            headers: new HttpHeaders({
                "Content-Type": "application/json"
            }),
            body: body
        };

        return this._http.delete<RESPONSE_TYPE>(url, options);
    }

}
