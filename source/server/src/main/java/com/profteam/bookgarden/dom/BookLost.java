package com.profteam.bookgarden.dom;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class BookLost {
    
    @Id
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private Employee employee;
    
    @Column
    private Double costLost;
    
    @Column
    private LocalDate createdDate;
    
    @Version
    private int version;
    
    @OneToMany(mappedBy = "bookLostDetailId.bookLost")
    private List<BookLostDetail> bookLostDetails = new ArrayList<>();
    
}
