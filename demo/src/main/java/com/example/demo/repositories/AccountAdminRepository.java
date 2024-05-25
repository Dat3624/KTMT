package com.example.demo.repositories;

import com.example.demo.entities.AccountAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountAdminRepository extends JpaRepository<AccountAdmin, String>{
}
