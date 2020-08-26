import {Component, OnInit} from '@angular/core';
import {UserOrderDto} from "src/app/dto/response/user-order-dto";
import {OrderService} from "src/app/services/order.service";
import {getData, getPaginatedData, getPaginatedTotalElements, PaginationResponse, Response} from "src/app/dto/abstract-response";
import {AuthenticatedService} from "src/app/services/authenticated.service";
import {UserDto} from "src/app/dto/response/user-dto";
import {ImgService} from "src/app/services/img.service";
import {OrderListCriteriaDto} from "src/app/dto/request/order-list-criteria-dto";
import {BookDto} from "src/app/dto/response/book-dto";

@Component({
    selector: 'app-your-profile',
    templateUrl: './your-profile.component.html',
    styleUrls: ['./your-profile.component.css']
})
export class YourProfileComponent implements OnInit {

    user: UserDto = new UserDto();

    orders: UserOrderDto[] = [];

    page: number = 1;

    totalOrder: number = 0;

    orderListCriteriaDto: OrderListCriteriaDto = new OrderListCriteriaDto();

    constructor(private _orderService: OrderService,
                private _authenticatedService: AuthenticatedService,
                private _imgService: ImgService) {

    }

    ngOnInit(): void {
        this.loadAsyncData();
    }

    private loadAsyncData(): void {
        this.loadOrderList();
        this.loadUser();
    }

    loadOrderList(): void {
        this._orderService.findAllByUser(this.orderListCriteriaDto)
                          .subscribe((paginationResponse: PaginationResponse<UserOrderDto[]>) => {
                              this.orders = getPaginatedData<UserOrderDto[]>(paginationResponse);
                              console.log(paginationResponse)
                              console.log(this.orders)
                              this.totalOrder = getPaginatedTotalElements(paginationResponse);
                          });
    }

    loadUser(): void {
        if (this._authenticatedService.isAuthenticated()) {
            this._authenticatedService.getCurrentUser().subscribe((response: Response<UserDto>) => {
                this.user = getData<UserDto>(response);
            });
        }
    }

    getUserImg(image: string): string {
        return this._imgService.getUserImg(image);
    }

    goToPage(page: number): void {
        this.orderListCriteriaDto.page = page;
        this.loadOrderList();
    }

}
