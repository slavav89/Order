package com.order.furniture.billboards.order_furniture_billboards.config;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;

@Getter
@Setter
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
@NoArgsConstructor
public class ReviewMessage implements Serializable {
    int chatId;
    String name;
    String review;
}

