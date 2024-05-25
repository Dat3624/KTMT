package com.example.demo.controller;

import com.example.demo.dto.AccountAdminDTO;
import com.example.demo.services.AccountAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AccountAdminController {
    @Autowired
    private AccountAdminService accountAdminService;

    @GetMapping("/accountAdmin/{accountID}")
    public AccountAdminDTO getAccountAdminById(String accountID){
        return accountAdminService.getAccountAdminById(accountID);
    }
}
