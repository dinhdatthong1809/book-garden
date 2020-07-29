import {Component, OnInit} from '@angular/core';
import {MenuItem} from "src/app/abstract/menu";

@Component({
    selector: 'app-nav-bar',
    templateUrl: './nav-bar.component.html',
    styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {

    leftItems: MenuItem[] = [
        {
            name: "Books",
            url: "/",
            disabled: false
        },
        {
            name: "Contact",
            url: "/",
            disabled: false
        }
    ];

    rightItems: MenuItem[] = [
        {
            name: "Sign in",
            url: "/sign-in",
            disabled: false
        },
        {
            name: "Sign up",
            url: "/",
            disabled: false
        }
    ];

    constructor() {

    }

    ngOnInit(): void {

    }

}
