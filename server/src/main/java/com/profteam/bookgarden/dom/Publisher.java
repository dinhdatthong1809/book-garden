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
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Publisher extends AbstractEntity {

    @Column
    @NotNull
    @NotBlank
    @Size(max = 256)
    private String name;

    @Column
    @Size(min = 11, max = 13)
    private String phoneNumber;

    @Column
    @NotNull
    @Size(max = 100)
    private String email;

    @Column
    @Size(max = 200)
    private String address;

    @Column
    @Size(max = 1000)
    private String introduce;
    
    @Column
    @NotNull
    private LocalDate createdDate;
    
}
