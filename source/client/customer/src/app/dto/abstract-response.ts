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
            list: T[];
            totalElements: number;
        };
        message: string;
        errorCode: number;
        errorData: any;
    };
}

export function getDataList<T>(paginationResponse: PaginationResponse): T[] {
    return paginationResponse.response.resultData.list;
}
