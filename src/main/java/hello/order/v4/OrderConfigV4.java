package hello.order.v4;

import hello.order.OrderService;
import hello.order.v3.OrderServiceImplV3;
import io.micrometer.core.aop.TimedAspect;
import io.micrometer.core.instrument.MeterRegistry;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OrderConfigV4 {
    @Bean
    OrderService orderService() {
        return new OrderServiceImplV4();
    }

    @Bean
    public TimedAspect timedAspect(MeterRegistry registry) {
        return new TimedAspect(registry);
    }
}
