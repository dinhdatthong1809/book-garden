package com.profteam.bookgarden.dom;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "AUTHOR")
public class Author {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String fullname;

    private Date dateOfBirth;

    private Date dateOfDeath;

    private String image;

    private String introduce;

    private Date createdDate;

    @ManyToMany(mappedBy = "authors")
    List<Book> books;
}
