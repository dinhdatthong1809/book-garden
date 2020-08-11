import {BrowserModule} from '@angular/platform-browser';
import {ErrorHandler, NgModule} from '@angular/core';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import {NavBarComponent} from './components/nav-bar/nav-bar.component';
import {MainComponent} from './pages/main/main.component';
import {ErrorComponent} from './pages/error/error.component';
import {HttpClientModule} from "@angular/common/http";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {SignUpComponent} from './pages/main/sign-up/sign-up.component';
import {SignInComponent} from './pages/main/sign-in/sign-in.component';
import {BooksComponent} from './pages/main/books/books.component';
import { FooterComponent } from './components/footer/footer.component';
import { HomeComponent } from './pages/main/home/home.component';
import { YourCartComponent } from './pages/main/your-cart/your-cart.component';
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {ToastrModule} from "ngx-toastr";
import {ErrorHandlerService} from "src/app/services/error-handler.service";
import { YourProfileComponent } from './pages/main/your-profile/your-profile.component';

@NgModule({
    declarations: [
        AppComponent,
        NavBarComponent,
        MainComponent,
        ErrorComponent,
        SignInComponent,
        SignUpComponent,
        BooksComponent,
        FooterComponent,
        HomeComponent,
        YourCartComponent,
        YourProfileComponent,
    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        HttpClientModule,
        ReactiveFormsModule,
        NgbModule,
        FormsModule,
        BrowserAnimationsModule,
        ToastrModule.forRoot(),
    ],
    providers: [
        {provide: ErrorHandler, useClass: ErrorHandlerService},
    ],
    bootstrap: [AppComponent]
})
export class AppModule {

}
