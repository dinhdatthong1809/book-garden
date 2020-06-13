package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.constants.AppConstants;
import com.profteam.bookgarden.dom.abstraction.AbstractEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.BatchSize;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

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
    @Size(min = 11, max = 14)
    private String phoneNumber;

    @Column
    @NotNull
    @NotBlank
    @Size(max = 100)
    @Email(regexp = AppConstants.EMAIL_REGEX)
    private String email;

    @Column
    @Size(max = 200)
    private String address;

    @Column
    @Size(max = 1000)
    private String introduce;
    
    @Column
    private LocalDate createdDate;
    
    @OneToMany(mappedBy = "publisher")
    private List<Book> books = new ArrayList<>();
    
    @OneToMany(mappedBy = "bookPublisherId.publisher")
    private List<BookPublisher> bookPublishers = new ArrayList<>();
    
}
