package com.profteam.bookgarden.dom;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Address {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column
    @Size(max = 100)
    private String name;
    
    @Column
    @Size(max = 256)
    private String address;
    
    @OneToMany(mappedBy = "customerAddressId.address")
    private List<CustomerAddress> customerAddresses = new ArrayList<>();
    
    @OneToMany(mappedBy = "address")
    private List<OrderShipping> orderShippings = new ArrayList<>();
    
}
