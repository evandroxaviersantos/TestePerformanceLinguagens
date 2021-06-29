package com.barth.performance.Controller;

import java.net.URI;
import java.util.List;

import javax.transaction.Transactional;

import com.barth.performance.Model.Cliente;
import com.barth.performance.Rerpository.ClienteRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/api/Clientes")
public class ClienteController {

    @Autowired
    private ClienteRepository clienteRepository;

    @GetMapping
    public List<Cliente> getClientes(){
       return clienteRepository.findAll();
    }

    @PostMapping
    @Transactional
    public ResponseEntity<Cliente> postCliente(@RequestBody Cliente cliente, UriComponentsBuilder uriBuilder) {		
		clienteRepository.save(cliente);
         		
        URI uri = uriBuilder.path("/api/Clientes").buildAndExpand().toUri();
		return ResponseEntity.created(uri).body(cliente);
	}
    
}
