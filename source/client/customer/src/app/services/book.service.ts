import {Injectable} from '@angular/core';
import {AbstractService} from "./abstract.service";
import {catchError} from "rxjs/operators";
import {Observable} from "rxjs";
import {BookDto} from "src/app/dto/response/book-dto";
import {ApiUrl} from "src/app/constants/api-url";
import {BookListCriteriaDto} from "src/app/dto/request/book-list-criteria-dto";
import {PaginationResponse, Response} from "src/app/dto/abstract-response";

@Injectable({
    providedIn: 'root'
})
export class BookService extends AbstractService {

    findChunkWithTitleKeywordAndPriceAndCategory(bookListCriteriaDto: BookListCriteriaDto): Observable<PaginationResponse<BookDto[]>> {
        return super.post<BookListCriteriaDto, PaginationResponse<BookDto[]>>(ApiUrl.BOOK_FILTER, bookListCriteriaDto)
                    .pipe(catchError(super.handleError));
    }

    findOne(id: String): Observable<Response<BookDto>> {
        return super.get<Response<BookDto>>(ApiUrl.BOOK, {id: id})
                    .pipe(catchError(super.handleError));
    }

}
