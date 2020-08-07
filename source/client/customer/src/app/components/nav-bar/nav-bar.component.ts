import {Component, OnInit} from '@angular/core';
import {MenuItem} from "src/app/abstract/menu";
import {AppUrl} from "src/app/constants/app-url";

@Component({
    selector: 'app-nav-bar',
    templateUrl: './nav-bar.component.html',
    styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {

    leftItems: MenuItem[] = [
        {
            name: "Books",
            url: `/${AppUrl.BOOKS}`,
            disabled: false
        },
        {
            name: "Contact",
            url: `/${AppUrl.CONTACT}`,
            disabled: false
        },
        {
            name: "Your cart",
            url: `/${AppUrl.YOUR_CART}`,
            disabled: false
        }
    ];

    rightItems: MenuItem[] = [
        {
            name: "Sign up",
            url: `/${AppUrl.SIGN_UP}`,
            disabled: false
        },
        {
            name: "Sign in",
            url: `/${AppUrl.SIGN_IN}`,
            disabled: false
        }
    ];

    constructor() {

    }

    ngOnInit(): void {

    }

}
