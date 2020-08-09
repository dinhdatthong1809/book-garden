import {Component, OnInit} from '@angular/core';
import {MenuItem} from "src/app/abstract/menu";
import {AppUrl} from "src/app/constants/app-url";
import {AuthenticatedService} from "src/app/services/authenticated.service";
import {AlertService} from "src/app/services/alert.service";
import {SweetAlertResult} from "sweetalert2";

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
            disableRouter: false
        },
        {
            name: "Your cart",
            url: `/${AppUrl.YOUR_CART}`,
            disableRouter: false
        }
    ];

    rightItems: MenuItem[] = [
        {
            name: "Sign up",
            url: `/${AppUrl.SIGN_UP}`,
            disableRouter: false
        },
        {
            name: "Sign in",
            url: `/${AppUrl.SIGN_IN}`,
            disableRouter: false
        }
    ];

    rightItemsSignIned: MenuItem[] = [
        {
            name: "Sign out",
            url: `/${AppUrl.SIGN_OUT}`,
            disableRouter: true
        },
        {
            name: "Your profile",
            url: `/${AppUrl.YOUR_PROFILE}`,
            disableRouter: false
        }
    ];

    constructor(public _authenticatedService: AuthenticatedService,
                private _alertService: AlertService) {

    }

    ngOnInit(): void {

    }

    signOut(): void {
        this._alertService.ask("Signing out and return to home page")
                          .then((result: SweetAlertResult) => {
                              if (result.value) {
                                  this._authenticatedService.signOut();
                                  window.location.href = `/${AppUrl.HOME}`;
                              }
                          });
    }

}
