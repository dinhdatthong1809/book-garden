export class Response<T> {
    response: {
        resultData: T;
        message: string;
        errorCode: number;
        errorData: any;
    };
}

export class PaginationResponse<T> {
    response: {
        resultData: {
            list: T;
            totalElements: number;
        };
        message: string;
        errorCode: number;
        errorData: any;
    };
}

export function getPaginatedData<T>(paginationResponse: PaginationResponse<T>): T {
    return paginationResponse.response.resultData.list;
}

export function getPaginatedTotalElements<T>(paginationResponse: PaginationResponse<T>): number {
    return paginationResponse.response.resultData.totalElements;
}

export function getData<T>(response: Response<T>): T {
    return response.response.resultData;
}
