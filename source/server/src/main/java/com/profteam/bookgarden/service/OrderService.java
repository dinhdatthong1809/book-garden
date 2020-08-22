package com.profteam.bookgarden.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.profteam.bookgarden.constants.Constants;
import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.dom.Book;
import com.profteam.bookgarden.dom.Order;
import com.profteam.bookgarden.dom.OrderDetail;
import com.profteam.bookgarden.dom.User;
import com.profteam.bookgarden.dto.OrderDto;
import com.profteam.bookgarden.dto.request.OrderDetailRequestDto;
import com.profteam.bookgarden.dto.request.OrderRequestDto;
import com.profteam.bookgarden.enums.OrderStatusEnum;
import com.profteam.bookgarden.exception.BookNotEnoughExeption;
import com.profteam.bookgarden.exception.BookNotFoundException;
import com.profteam.bookgarden.exception.BookPriceNotCorrectException;
import com.profteam.bookgarden.mapper.OrderMapper;
import com.profteam.bookgarden.repository.BookRepository;
import com.profteam.bookgarden.repository.OrderDetailRepository;
import com.profteam.bookgarden.repository.OrderRepository;
import com.profteam.bookgarden.utils.CommonUtil;

@Service
@Transactional(rollbackFor = Throwable.class)
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private BookRepository bookRepository;

    private final OrderMapper orderMapper = Mappers.getMapper(OrderMapper.class);

    public List<OrderDto> getListOrderHistory() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Long userId = (Long) authentication.getPrincipal();

        List<Order> listOrder = orderRepository.findByUserId(userId);
        List<OrderDto> listOrderDto = orderMapper.toListOrderDto(listOrder);

        listOrderDto.stream().forEach(orderDto -> {
            double totalAmount = orderDto.getOrderDetails().stream().mapToDouble(orderDetail -> orderDetail.getAmount()*orderDetail.getPrice()).sum();
            orderDto.setTotalAmount(totalAmount);
        });

        return listOrderDto;
    }

    public String order(OrderRequestDto request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Long userId = (Long) authentication.getPrincipal();
        
        request.getItems().forEach(orderDetailRequest -> {
            validateBook(orderDetailRequest);
        });

        Order order = new Order();
        order.setUser(new User(userId));
        order.setStatus(OrderStatusEnum.OPEN.getStatus());
        order.setAdminId(Constants.ADMIN_ORDER_ID);
        order = orderRepository.save(order);

        List<OrderDetail> listOrderDetail = toListOrderDetail(request.getItems(), order);
        orderDetailRepository.saveAll(listOrderDetail);

        return CommonUtil.getMessageWithCode(MessageConstants.CONST_MESSAGE_SUCCESS);
    }

    private List<OrderDetail> toListOrderDetail(List<OrderDetailRequestDto> orderDetailRequestDtos, Order order) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        orderDetailRequestDtos.forEach(orderDetailRequest -> orderDetails.add(toOrderDetail(orderDetailRequest, order)));
        return orderDetails;
    }

    private OrderDetail toOrderDetail(OrderDetailRequestDto orderDetailRequestDto, Order order) {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setBook(new Book(orderDetailRequestDto.getBookId()));
        orderDetail.setOrder(order);
        orderDetail.setAmount(orderDetailRequestDto.getAmount());
        orderDetail.setPrice(orderDetailRequestDto.getPrice());
        return orderDetail;
    }

    private void validateBook(OrderDetailRequestDto orderDetailRequestDto) {
        Optional<Book> bookOpt = bookRepository.findById(orderDetailRequestDto.getBookId());
        // Check book exist
        if (!bookOpt.isPresent()) {
            throw new BookNotFoundException(orderDetailRequestDto.getBookId());
        }
        
        Book book = bookOpt.get();
        // Check book amount
        if (book.getAmount() < orderDetailRequestDto.getAmount()) {
            throw new BookNotEnoughExeption(book.getTitle());
        }

        // Check book price
        if (book.getPrice() != orderDetailRequestDto.getPrice()) {
            throw new BookPriceNotCorrectException(orderDetailRequestDto.getBookId());
        }
    }

}

