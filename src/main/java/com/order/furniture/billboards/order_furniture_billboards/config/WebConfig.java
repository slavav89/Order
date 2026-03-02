package com.order.furniture.billboards.order_furniture_billboards.config;

import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.thymeleaf.spring6.SpringTemplateEngine;
import org.thymeleaf.spring6.templateresolver.SpringResourceTemplateResolver;
import org.thymeleaf.spring6.view.ThymeleafViewResolver;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ITemplateResolver;


@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    @Bean
    public MessageConverter jsonMessageConverter() {
        return new Jackson2JsonMessageConverter();
    }

    // ThymeleafViewResolver с приоритетом 1 и проверкой наличия файла
    @Bean
    public ThymeleafViewResolver thymeleafViewResolver() {
        ThymeleafViewResolver resolver = new ThymeleafViewResolver() {
            @Override
            protected org.springframework.web.servlet.View loadView(String viewName, java.util.Locale locale) throws Exception {
                // Проверяем, существует ли файл templates/{viewName}.html в classpath
                Resource resource = new ClassPathResource("templates/" + viewName + ".html");
                if (!resource.exists()) {
                    return null;  // Если файла нет, возвращаем null — fallback к jspViewResolver
                }
                return super.loadView(viewName, locale);
            }
        };
        resolver.setTemplateEngine(templateEngine());
        resolver.setOrder(1);  // Приоритет для Thymeleaf
        resolver.setCache(false);  // Отключить кеш для разработки
        resolver.setCharacterEncoding("UTF-8");  // Явная кодировка для Thymeleaf
        return resolver;
    }

    // TemplateEngine для Thymeleaf
    @Bean
    public SpringTemplateEngine templateEngine() {
        SpringTemplateEngine engine = new SpringTemplateEngine();
        engine.setTemplateResolver(templateResolver());
        return engine;
    }

    // TemplateResolver для поиска шаблонов в classpath:/templates/
    @Bean
    public ITemplateResolver templateResolver() {
        SpringResourceTemplateResolver resolver = new SpringResourceTemplateResolver();
        resolver.setPrefix("classpath:/templates/");  // Папка с Thymeleaf-шаблонами
        resolver.setSuffix(".html");
        resolver.setTemplateMode(TemplateMode.HTML);
        resolver.setCacheable(false);  // Отключить кеш для разработки
        resolver.setCharacterEncoding("UTF-8");  // Явная кодировка для чтения файлов
        return resolver;
    }

    // jspViewResolver с приоритетом 2 (fallback для JSP)
    @Bean
    public InternalResourceViewResolver jspViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/jsp/");
        resolver.setSuffix(".jsp");
        resolver.setOrder(2);  // Приоритет ниже Thymeleaf
        return resolver;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/");
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }
}