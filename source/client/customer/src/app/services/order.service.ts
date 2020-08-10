import {Injectable} from '@angular/core';
import {AbstractService} from "src/app/services/abstract.service";
import {Observable} from "rxjs";
import {Response} from "src/app/dto/abstract-response";
import {ApiUrl} from "src/app/constants/api-url";
import {catchError} from "rxjs/operators";
import {UserOrderDto} from "src/app/dto/response/user-order-dto";

@Injectable({
    providedIn: 'root'
})
export class OrderService extends AbstractService {

    findAllByUser(): Observable<Response<UserOrderDto[]>> {
        return super.post<null, Response<UserOrderDto[]>>(ApiUrl.USER_ORDER, undefined, true)
                    .pipe(catchError(super.handleError));
    }

}
