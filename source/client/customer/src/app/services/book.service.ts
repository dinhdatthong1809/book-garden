import {Injectable} from '@angular/core';
import {AbstractService} from "./abstract.service";
import {catchError} from "rxjs/operators";
import {Observable} from "rxjs";
import {BookListDto} from "src/app/dto/response/book-list-dto";
import {ApiUrl} from "src/app/constants/api-url";
import {BookListCriteriaDto} from "src/app/dto/request/book-list-criteria-dto";

@Injectable({
    providedIn: 'root'
})
export class BookService extends AbstractService {

    findChunkWithTitleKeywordAndPriceAndCategory(bookListCriteriaDto: BookListCriteriaDto): Observable<BookListDto[]> {
        return super.post<BookListCriteriaDto, PaginationResponse<BookListDto>>(ApiUrl.BOOK, bookListCriteriaDto)
                    .pipe(catchError(super.handleError));
    }

}
