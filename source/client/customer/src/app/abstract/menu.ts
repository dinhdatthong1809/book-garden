export interface MenuItem {

    name: string;

    url: string;

    disableRouter?: boolean;

}

export interface MenuGroup {

    header: MenuItem

    items: MenuItem[]

}
