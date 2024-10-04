package com.beetmarket.stock.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CashVO {
    private Long cash_No;
    private Date create_Date;
    private Long money;
    private String id;
}
