import {Injectable} from '@angular/core';
import {AbstractService} from "src/app/services/abstract.service";
import {Observable} from "rxjs";
import {ApiUrl} from "src/app/constants/api-url";
import {catchError} from "rxjs/operators";
import {SignInDto} from "src/app/dto/request/sign-in-dto";
import {UserDto} from "src/app/dto/response/user-dto";
import {Response} from "src/app/dto/abstract-response";
import {SessionStorageKeys} from "src/app/constants/session-storage-keys";
import {SignUpDto} from "src/app/dto/request/sign-up-dto";

@Injectable({
    providedIn: 'root'
})
export class AuthenticatedService extends AbstractService {

    saveUserToLocal(signInDto: SignInDto): void {
        localStorage.setItem(SessionStorageKeys.USER, JSON.stringify(signInDto));
    }

    signUp(signUpDto: SignUpDto): Observable<Response<UserDto>> {
        return super.post<SignUpDto, Response<UserDto>>(ApiUrl.USER_SIGN_UP, signUpDto)
                    .pipe(catchError(super.handleError));
    }

    signIn(signInDto: SignInDto): Observable<Response<UserDto>> {
        return super.post<SignInDto, Response<UserDto>>(ApiUrl.USER_SIGN_IN, signInDto)
                    .pipe(catchError(super.handleError));
    }

    signOut(): void {
        localStorage.removeItem(SessionStorageKeys.USER);
    }

    isAuthenticated(): boolean {
        if (localStorage.getItem(SessionStorageKeys.USER)) {
            return true;
        }

        return false;
    }

    getCurrentUser(): Observable<Response<UserDto>> {
        if (!this.isAuthenticated()) {
            return null;
        }

        let username = JSON.parse(localStorage.getItem(SessionStorageKeys.USER)).username;
        return super.get<Response<UserDto>>(ApiUrl.USER_FIND_BY_USERNAME, {username: username})
                    .pipe(catchError(super.handleError));
    }

}
