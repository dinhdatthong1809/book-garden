package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.dom.abstraction.AbstractEntity;
import com.profteam.bookgarden.dom.validator.author.CheckAuthorDateOfDeath;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.BatchSize;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@CheckAuthorDateOfDeath

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class Author extends AbstractEntity implements Serializable {

    @Column
    @NotNull
    @NotBlank
    @Size(max = 50)
    private String fullName;

    @Column
    private LocalDate dateOfBirth;

    @Column
    private LocalDate dateOfDeath;

    @Column
    @Size(max = 256)
    private String image;

    @Column
    @Size(max = 1000)
    private String introduce;

    @Column
    private LocalDate createdDate;
    
    @OneToMany(mappedBy = "bookAuthorId.author")
    private List<BookAuthor> bookAuthors = new ArrayList<>();

}
