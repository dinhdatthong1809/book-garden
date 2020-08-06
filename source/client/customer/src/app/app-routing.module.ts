import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {MainComponent} from "src/app/pages/main/main.component";
import {ErrorComponent} from "src/app/pages/error/error.component";
import {AppUrl} from "src/app/constants/app-url";
import {SignInComponent} from "src/app/pages/main/sign-in/sign-in.component";
import {SignUpComponent} from "src/app/pages/main/sign-up/sign-up.component";
import {BooksComponent} from "src/app/pages/main/books/books.component";
import {ContactComponent} from "src/app/pages/main/contact/contact.component";
import {AppComponent} from "src/app/app.component";
import {HomeComponent} from "src/app/pages/main/home/home.component";

const routes: Routes = [
    {path: AppUrl.APP, component: AppComponent, children: [
        {path: AppUrl.MAIN, component: MainComponent, children: [
            {path: AppUrl.HOME, component: HomeComponent, pathMatch: "full"},
            {path: AppUrl.BOOKS, component: BooksComponent, pathMatch: "full"},
            {path: AppUrl.CONTACT, component: ContactComponent, pathMatch: "full"},
            {path: AppUrl.SIGN_IN, component: SignInComponent, pathMatch: "full"},
            {path: AppUrl.SIGN_UP, component: SignUpComponent, pathMatch: "full"}
        ]},
        {path: AppUrl.ERROR, component: ErrorComponent},
        {path: "**", redirectTo: AppUrl.MAIN, pathMatch: "full"}
    ]},
];

@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
