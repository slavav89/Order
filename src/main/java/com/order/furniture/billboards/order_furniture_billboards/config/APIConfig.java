package com.order.furniture.billboards.order_furniture_billboards.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class APIConfig {

    @Bean
    public GroupedOpenApi clientApi() {
        return GroupedOpenApi
                .builder()
                .group("Client API")
                .pathsToMatch("/client/**")
                .build();
    }

    @Bean
    public GroupedOpenApi sellerApi() {
        return GroupedOpenApi
                .builder()
                .group("Seller API")
                .pathsToMatch("/seller/**")
                .build();
    }

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Order Furniture Billboards API")
                        .version("1.0")
                        .description("API для управления заказами мебельных билбордов"));
    }
}
