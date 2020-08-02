import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';

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
import {ContactComponent} from './pages/main/contact/contact.component';
import { FooterComponent } from './components/footer/footer.component';
import { HomeComponent } from './pages/main/home/home.component';

@NgModule({
    declarations: [
        AppComponent,
        NavBarComponent,
        MainComponent,
        ErrorComponent,
        SignInComponent,
        SignUpComponent,
        BooksComponent,
        ContactComponent,
        FooterComponent,
        HomeComponent
    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        HttpClientModule,
        ReactiveFormsModule,
        NgbModule,
        FormsModule
    ],
    providers: [],
    bootstrap: [AppComponent]
})
export class AppModule {

}
