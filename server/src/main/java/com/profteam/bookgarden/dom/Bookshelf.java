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
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Bookshelf extends AbstractEntity {

    @Column(nullable = false)
    @Nationalized
    @NotNull
    @Size(max = 255)
    private String locationName;

    @Column
    @Min(1)
    private int maxStorage;

    @Column
    @Nationalized
    @Size(max = 255)
    private String description;

}
