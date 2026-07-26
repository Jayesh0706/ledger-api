package com.fincorp.ledgerapi;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class AccountController {

    @GetMapping("/api/accounts")
    public List<Map<String, Object>> listAccounts() {
        return List.of(
            Map.of("id", 1, "name", "Checking", "balance", 2500.00),
            Map.of("id", 2, "name", "Savings", "balance", 10000.00)
        );
    }
}
