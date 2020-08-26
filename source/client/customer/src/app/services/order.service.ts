import {Injectable} from '@angular/core';
import {AbstractService} from "src/app/services/abstract.service";
import {Observable} from "rxjs";
import {PaginationResponse, Response} from "src/app/dto/abstract-response";
import {ApiUrl} from "src/app/constants/api-url";
import {catchError} from "rxjs/operators";
import {UserOrderDto} from "src/app/dto/response/user-order-dto";
import {OrderListCriteriaDto} from "src/app/dto/request/order-list-criteria-dto";

@Injectable({
    providedIn: 'root'
})
export class OrderService extends AbstractService {

    findAllByUser(orderListCriteriaDto: OrderListCriteriaDto): Observable<PaginationResponse<UserOrderDto[]>> {
        return super.post<OrderListCriteriaDto, PaginationResponse<UserOrderDto[]>>(ApiUrl.USER_ORDER, orderListCriteriaDto, true)
                    .pipe(catchError(super.handleError));
    }

}
