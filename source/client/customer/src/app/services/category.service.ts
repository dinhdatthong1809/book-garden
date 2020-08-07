import {Injectable} from '@angular/core';
import {AbstractService} from "src/app/services/abstract.service";
import {Observable} from "rxjs";
import {Response} from "src/app/dto/abstract-response";
import {ApiUrl} from "src/app/constants/api-url";
import {catchError} from "rxjs/operators";
import {CategoryDto} from "src/app/dto/response/category-dto";

@Injectable({
    providedIn: 'root'
})
export class CategoryService extends AbstractService {

    findAll(): Observable<Response<CategoryDto>> {
        return super.get<Response<CategoryDto>>(ApiUrl.CATEGORY_FIND_ALL)
                    .pipe(catchError(super.handleError));
    }

}
