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

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Publisher extends AbstractEntity {

    @Column(length = )
    @Nationalized
    @NotNull
    private String name;

    @Column(length = 13)
    @Size(min = 13, max = 13)
    private String phoneNumber;

    @Column(length = 100)
    @NotNull
    @Size(max = 100)
    private String email;

    @Column
    @Nationalized
    @NotNull
    private String address;


    private String introduce;
}
