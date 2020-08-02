import {Component, OnInit} from '@angular/core';
import {AppConstants} from "src/app/constants/app-constants";

@Component({
    selector: 'app-footer',
    templateUrl: './footer.component.html',
    styleUrls: ['./footer.component.css']
})
export class FooterComponent implements OnInit {

    appAuthor = AppConstants.APP_AUTHOR;

    socialIcons: any = {
        facebook: "fab fa-facebook-f",
        instagram: "fab fa-instagram",
        github: "fab fa-github"
    }

    members: string[] = [

    ];

    constructor() {
    }

    ngOnInit(): void {
    }

}
