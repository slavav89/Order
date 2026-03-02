package com.order.furniture.billboards.order_furniture_billboards.config;

import com.order.furniture.billboards.order_furniture_billboards.entity.Review;
import com.order.furniture.billboards.order_furniture_billboards.entity.User;
import com.order.furniture.billboards.order_furniture_billboards.repository.ReviewRepository;
import com.order.furniture.billboards.order_furniture_billboards.repository.UserRepository;
import com.rabbitmq.client.Channel;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class ReviewMessageConsumer {

    @Autowired
    private ReviewRepository reviewRepository;

    // Адаптируйте под вашу модель Client/User
    @Autowired
    private UserRepository userRepository;  // Или UserRepository

    @RabbitListener(queues = "${rabbitmq.queue.name}", ackMode = "MANUAL")
    public void receiveMessage(@Payload ReviewMessage message,
                               Channel channel, @Header(AmqpHeaders.DELIVERY_TAG) long tag) {
        // Десериализуем сообщение (предполагаем JSON)
        // Если сообщение — String, используйте ObjectMapper для парсинга

        // Пример: находим Client по ID (или создаём новый, если нужно)
       // User user = userRepository.findById(message.getId())
               // .orElseThrow(() -> new RuntimeException("Client not found"));

        try {
            AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext();
            // Создаём Review
            Review review = new Review();
            review.setName(message.getName());
            review.setMessage(message.getReview());
            review.setChatId(message.getChatId());

            // Сохраняем в БД
            reviewRepository.save(review);
            channel.basicAck(tag, false);
            System.out.println("Saved review: " + review.getName());
        } catch (Exception e) {
            try {
                channel.basicNack(tag, false, true);
            } catch (IOException ioException) {
                // Лог или обработка
            }
        }

    }
}