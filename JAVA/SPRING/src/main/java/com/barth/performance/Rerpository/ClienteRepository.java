package com.barth.performance.Rerpository;

import com.barth.performance.Model.Cliente;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {
    
}
