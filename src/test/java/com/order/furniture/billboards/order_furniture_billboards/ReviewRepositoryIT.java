package com.order.furniture.billboards.order_furniture_billboards;

import com.order.furniture.billboards.order_furniture_billboards.entity.Review;
import com.order.furniture.billboards.order_furniture_billboards.repository.ReviewRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.ActiveProfiles;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@ActiveProfiles("test")
@Transactional
public class ReviewRepositoryIT {

    @Autowired
    private ReviewRepository reviewRepository;

    @Test
    @Rollback // чтобы изменения не сохранились после теста (определено транзакцией)
    public void testSaveAndFind() {
        // Создаем новый Review
        Review review = Review.builder()
                .chatId(12345)
                .name("Иван")
                .message("Отличный сервис")
                .build();

        // Сохраняем
        Review saved = reviewRepository.save(review);
        int id = saved.getId();  // id присвоится после save

        // Получаем из базы
        Optional<Review> retrievedOpt = reviewRepository.findById(id);
        assertTrue(retrievedOpt.isPresent());

        Review retrieved = retrievedOpt.get();
        assertEquals("Иван", retrieved.getName());
        assertEquals("Отличный сервис", retrieved.getMessage());
        assertEquals(12345, retrieved.getChatId());
    }
}
