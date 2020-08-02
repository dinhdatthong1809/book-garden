export interface MenuItem {

    name: string;

    url: string;

    disabled?: boolean;

}

export interface MenuGroup {

    header: MenuItem

    items: MenuItem[]

}
