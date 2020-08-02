import {Injectable} from '@angular/core';
import Swal, {SweetAlertResult} from "sweetalert2";

@Injectable({
    providedIn: 'root'
})
export class AlertService {

    constructor() {

    }

    success(message: string): Promise<SweetAlertResult> {
        return Swal.fire({
            icon: "success",
            html: message,
        })
    }

    error(message: string): Promise<SweetAlertResult> {
        return Swal.fire({
            icon: "error",
            html: message,
        })
    }

    warn(message: string): Promise<SweetAlertResult> {
        return Swal.fire({
            icon: "warning",
            html: message,
        })
    }

    ask(message: string): Promise<SweetAlertResult> {
        let title: string = "Are you sure";
        let yesMessage: string = "Ok";
        let cancelMessage: string = "Cancel";

        return Swal.fire({
            icon: "warning",
            title: `${title}?`,
            html: message,
            confirmButtonColor: '#3085d6',
            confirmButtonText: yesMessage,
            showCancelButton: true,
            cancelButtonColor: "#d33",
            cancelButtonText: cancelMessage,
            focusCancel: true
        });
    }

    loading(): Promise<SweetAlertResult> {
        return Swal.fire({
            title: "",
            allowOutsideClick: false,
            onBeforeOpen: () => {
                Swal.showLoading();
            },
        });
    }

    close(): void {
        Swal.close();
    }

}
