package com.example.demo.services.impl;

import com.example.demo.dto.AccountAdminDTO;
import com.example.demo.entities.AccountAdmin;
import com.example.demo.repositories.AccountAdminRepository;
import com.example.demo.services.AccountAdminService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountAdminImpl implements AccountAdminService {
    @Autowired
    private AccountAdminRepository accountAdminRepository;
    @Autowired
    private ModelMapper modelMapper;

    @Override
    public AccountAdminDTO getAccountAdminById(String accountAdminID) {
        AccountAdmin accountAdmin = accountAdminRepository.findById(accountAdminID).orElse(null);
        if (accountAdmin == null) {
            return null;
        }
        AccountAdminDTO accountAdminDTO = modelMapper.map(accountAdmin, AccountAdminDTO.class);
        return accountAdminDTO;
    }
}
