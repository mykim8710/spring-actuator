package hello.order.v4;

import hello.order.OrderService;
import io.micrometer.core.annotation.Timed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

@Timed("my.order")
@Slf4j
@RequiredArgsConstructor
public class OrderServiceImplV4 implements OrderService {
    private AtomicInteger stock = new AtomicInteger(100);

    @Override
    public void order() {
        stock.decrementAndGet();
        log.info("주문, 현재 재고량 : {}", stock);
        sleep(500);
    }

    @Override
    public void cancel() {
        stock.incrementAndGet();
        log.info("취소, 현재 재고량 : {}", stock);
        sleep(200);
    }

    @Override
    public AtomicInteger getStock() {
        return stock;
    }

    private static void sleep(int l) {
        try {
            Thread.sleep(l + new Random().nextInt(200));
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}
