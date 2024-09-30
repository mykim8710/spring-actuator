package hello.order.v2;

import hello.order.OrderService;
import io.micrometer.core.annotation.Counted;
import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.atomic.AtomicInteger;

@Slf4j
public class OrderServiceImplV2 implements OrderService {

    private AtomicInteger stock = new AtomicInteger(100);

    @Counted("my.order")
    @Override
    public void order() {
        stock.decrementAndGet();
        log.info("주문, 현재 재고량 : {}", stock);
    }

    @Counted("my.order")
    @Override
    public void cancel() {
        stock.incrementAndGet();
        log.info("취소, 현재 재고량 : {}", stock);
    }

    @Override
    public AtomicInteger getStock() {
        return stock;
    }
}
