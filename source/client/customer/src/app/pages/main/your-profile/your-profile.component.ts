import {Component, OnInit} from '@angular/core';
import {UserOrderDto} from "src/app/dto/response/user-order-dto";
import {OrderService} from "src/app/services/order.service";
import {getData, Response} from "src/app/dto/abstract-response";
import {AuthenticatedService} from "src/app/services/authenticated.service";
import {UserDto} from "src/app/dto/response/user-dto";
import {AppConstants} from "src/app/constants/app-constants";
import {ImgService} from "src/app/services/img.service";

@Component({
    selector: 'app-your-profile',
    templateUrl: './your-profile.component.html',
    styleUrls: ['./your-profile.component.css']
})
export class YourProfileComponent implements OnInit {

    user: UserDto = new UserDto();

    orders: UserOrderDto[] = [];

    constructor(private _orderService: OrderService,
                private _authenticatedService: AuthenticatedService,
                private _imgService: ImgService) {

    }

    ngOnInit(): void {
        this.findOrders();
        this.loadUser();
    }

    findOrders(): void {
        this._orderService.findAllByUser()
                          .subscribe(value => {
                              this.orders = getData<UserOrderDto[]>(value);
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

    chooseAvatar(): void {

    }

}
