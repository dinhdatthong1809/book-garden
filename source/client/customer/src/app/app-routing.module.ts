import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';
import {MainComponent} from "src/app/pages/main/main.component";
import {ErrorComponent} from "src/app/pages/error/error.component";
import {AppUrl} from "src/app/constants/app-url";
import {LoginComponent} from "src/app/pages/login/login.component";

const routes: Routes = [
    {path: AppUrl.MAIN, component: MainComponent, pathMatch: "full"},
    {path: AppUrl.ERROR, component: ErrorComponent},
    {
        path: AppUrl.MAIN,
        component: MainComponent,
        children: [
            {
                path: AppUrl.SIGN_IN,
                children: [
                    {path: "", component: LoginComponent, pathMatch: "full"},
                    {path: "**", redirectTo: AppUrl.SIGN_IN, pathMatch: "full"},
                ]
            },
        ]
    },

    {path: "**", redirectTo: AppUrl.MAIN, pathMatch: "full"},
];

@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
