package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.dom.abstraction.AbstractEntity;
import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.BatchSize;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Category extends AbstractEntity {

    @Column
    @NotNull
    @NotBlank
    @Size(max = 50)
    private String name;

    @Column
    @Size(max = 1000)
    private String description;

}
