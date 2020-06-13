package com.profteam.bookgarden.dom;

import com.profteam.bookgarden.constants.AppConstants;
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
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@BatchSize(size = 20)

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class Customer extends AbstractEntity implements Serializable {
    
    @Column
    @NotNull
    @NotBlank
    @Size(max = 100)
    private String username;
    
    @Column
    @NotNull
    @NotBlank
    @Size(max = 100)
    private String password;
    
    @Column
    @NotBlank
    @Size(max = 50)
    private String fullName;
    
    @Column
    private LocalDate dateOfBirth;
    
    @Column
    @NotBlank
    @Size(max = 100)
    @Email(regexp = AppConstants.EMAIL_REGEX)
    private String email;
    
    @Size(min = 11, max = 14)
    private String phoneNumber;
    
    @Column
    private Boolean sex;
    
    @Column
    private Boolean isActive;
    
    @Column
    private LocalDate createdDate;
    
    @OneToMany(mappedBy = "customer")
    private List<OrderRent> orderRents = new ArrayList<>();
    
    @OneToMany(mappedBy = "customer")
    private List<OrderSell> orderSells = new ArrayList<>();
    
    @OneToMany(mappedBy = "customerAddressId.customer")
    private List<CustomerAddress> customerAddresses = new ArrayList<>();
    
    @OneToMany(mappedBy = "customer")
    private List<OrderShipping> orderShippings = new ArrayList<>();
    
    @OneToMany(mappedBy = "customer")
    private List<RatingShipping> ratingShippings = new ArrayList<>();
    
}
