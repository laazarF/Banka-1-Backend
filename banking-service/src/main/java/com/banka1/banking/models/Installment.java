package com.banka1.banking.models;

import com.banka1.banking.models.helper.CurrencyType;
import com.banka1.banking.models.helper.PaymentStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Installment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Double amount; // Iznos rate

    @Column(nullable = false)
    private Double interestRate; // Iznos kamatne stope

    @Column(nullable = false)
    private CurrencyType currencyType; // Valuta rate i kredita

    @Column(nullable = false)
    private Long expectedDueDate; // Očekivani datum dospeća

    @Column
    private Long actualDueDate; // Pravi datum dospeća

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PaymentStatus paymentStatus;

    @ManyToOne
    @JoinColumn(name = "loan_id", nullable = false)
    private Loan loan;

}
