package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.dom.abstraction.AbstractEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.BatchSize;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class Bookshelf extends AbstractEntity implements Serializable {

    @Column
    @NotNull
    @NotBlank
    @Size(max = 256)
    private String locationName;

    @Column
    @Min(1)
    private int maxStorage;

    @Column
    @Size(max = 256)
    private String description;
    
    @OneToMany(mappedBy = "bookshelf")
    private List<Book> books = new ArrayList<>();

}
