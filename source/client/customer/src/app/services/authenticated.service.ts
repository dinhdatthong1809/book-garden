import {Injectable} from '@angular/core';
import {AbstractService} from "src/app/services/abstract.service";
import {Observable} from "rxjs";
import {ApiUrl} from "src/app/constants/api-url";
import {catchError} from "rxjs/operators";
import {SignInDto} from "src/app/dto/request/sign-in-dto";
import {UserDto} from "src/app/dto/response/user-dto";
import {Response} from "src/app/dto/abstract-response";
import {SessionStorageKeys} from "src/app/constants/session-storage-keys";

@Injectable({
    providedIn: 'root'
})
export class AuthenticatedService extends AbstractService {

    saveUserToLocal(signInDto: SignInDto): void {
        sessionStorage.setItem(SessionStorageKeys.USER, JSON.stringify(signInDto));
    }

    signIn(signInDto: SignInDto): Observable<Response<UserDto>> {
        return super.post<SignInDto, Response<UserDto>>(ApiUrl.USER_SIGN_IN, signInDto)
                    .pipe(catchError(super.handleError));
    }

    signOut(): void {
        sessionStorage.removeItem(SessionStorageKeys.USER);
    }

    isAuthenticated(): boolean {
        if (sessionStorage.getItem(SessionStorageKeys.USER)) {
            return true;
        }

        return false;
    }

    getUserData(): void {
        // if (sessionStorage.getItem(SessionStorageKeys.USER)) {
        //     return true;
        // }
    }

}
