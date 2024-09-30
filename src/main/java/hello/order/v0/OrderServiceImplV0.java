package hello.order.v0;

import hello.order.OrderService;
import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.atomic.AtomicInteger;

@Slf4j
public class OrderServiceImplV0 implements OrderService {

    private AtomicInteger stock = new AtomicInteger(100);

    @Override
    public void order() {
        stock.decrementAndGet();
        log.info("주문, 현재 재고량 : {}", stock);
    }

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
