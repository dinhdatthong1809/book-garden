package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.dom.abstraction.AbstractEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.BatchSize;
import org.hibernate.annotations.Nationalized;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Author extends AbstractEntity {

    @Column(nullable = false, length = 50)
    @Nationalized
    @NotNull
    @Size(max = 50)
    private String fullName;

    @Column
    private LocalDate dateOfBirth;

    @Column
    private LocalDate dateOfDeath;

    @Column
    @Size(max = 255)
    private String image;

    @Column
    @Nationalized
    private String introduce;

    @Column
    @NotNull
    private LocalDate createdDate = LocalDate.now();

}
