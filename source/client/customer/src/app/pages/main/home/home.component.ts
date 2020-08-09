import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {AppConstants} from "src/app/constants/app-constants";
import {Router} from "@angular/router";
import {AppUrl} from "src/app/constants/app-url";
import {LocalStorageKeys} from "src/app/constants/local-storage-keys";

@Component({
    selector: 'app-home',
    templateUrl: './home.component.html',
    styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

    aboutUsTiles: any[] = [
        {
            title: "Choose good book",
            content: "You should choose a good book based on its cover or title",
            icon: "note.png"
        },
        {
            title: "Prepare time",
            content: "You should choose right time, the right book, do not get more stress",
            icon: "clock.png"
        },
        {
            title: "Aim for target",
            content: "Do not waste your time reading bad books and gaining nothing from it",
            icon: "target.png"
        },
        {
            title: "Be mature",
            content: "The more book you read, the more points of view you get",
            icon: "man.png"
        }
    ];

    filterForm: FormGroup;

    submitted: boolean = false;

    appConstants = AppConstants;

    constructor(private _formBuilder: FormBuilder,
                private _router: Router) {
    }

    ngOnInit(): void {
        this.initForm();
    }

    private initForm(): void {
        this.filterForm = this._formBuilder.group(
            {
                title: [null, [
                    Validators.maxLength(AppConstants.TITLE_KEYWORD_MAX_LENGTH),
                ]],
            }
        );
    }

    get getForm() {
        return this.filterForm.controls;
    }

    onSubmit(): void {
        this.submitted = true;
        let title = this.getForm.title.value;

        if (this.filterForm.invalid || !title) {
            return;
        }

        localStorage.setItem(LocalStorageKeys.TITLE_KEYWORD, title);
        this._router.navigateByUrl(`${AppUrl.BOOKS}`);
    }

}
