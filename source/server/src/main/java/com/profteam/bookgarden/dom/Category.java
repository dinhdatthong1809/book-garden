
package com.profteam.bookgarden.dom;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "CATEGORY")
public class Category {

    @Id
    @Column(columnDefinition = "varchar(50)")
    private String id;

    private String categoryTitle;

    private String categoryDescription;

    @ManyToMany(mappedBy = "categories")
    private List<Book> books;

}
