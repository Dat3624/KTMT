package com.example.demo.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccountAdminDTO {
    private String username;
    private String password;
    private String ip;

    public AccountAdminDTO() {
    }

    public AccountAdminDTO(String username, String password, String ip) {
        this.username = username;
        this.password = password;
        this.ip = ip;
    }
}
