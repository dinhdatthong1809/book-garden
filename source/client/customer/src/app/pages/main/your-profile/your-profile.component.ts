import {Component, OnInit} from '@angular/core';
import {UserOrderDto} from "src/app/dto/response/user-order-dto";
import {OrderService} from "src/app/services/order.service";
import {getData} from "src/app/dto/abstract-response";

@Component({
    selector: 'app-your-profile',
    templateUrl: './your-profile.component.html',
    styleUrls: ['./your-profile.component.css']
})
export class YourProfileComponent implements OnInit {

    user = {
        photo: "photo",
        fullName: "fullName",
        passwordConfirm: "email",
        mark: "mark"
    }

    orders: UserOrderDto[] = [];

    constructor(private _orderService: OrderService) {

    }

    ngOnInit(): void {
        this.findOrders();
    }

    findOrders(): void {
        this._orderService.findAllByUser()
                          .subscribe(value => {
                              this.orders = getData<UserOrderDto[]>(value);
                          });
    }

}
