/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ch.cern.hazle.demo.demo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.cache.annotation.Cacheable;

@Cacheable("customers")
public interface CustomerRepository extends JpaRepository<Customer, Long> {
	
  List<Customer> findByLastName(String lastName);

  Customer findById(long id);
}
