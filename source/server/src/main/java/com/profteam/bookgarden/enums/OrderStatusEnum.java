package com.profteam.bookgarden.enums;

import com.profteam.bookgarden.utils.CommonUtil;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum OrderStatusEnum {

	OPEN("OPEN", "order.status.open"), 
	IN_PROGRESS("IN PROGRESS", "order.status.in.progress"), 
	IN_SHIPPING("IN SHIPPING", "order.status.in.shipping"),
	DONE("DONE", "order.status.done"),
	REJECT("REJECT", "order.status.reject");

	private String status;
	private String messageCode;
	
	public static String findStatusMessage(String statusFromDB) {
		for (OrderStatusEnum orderStatusEnum : OrderStatusEnum.values()) {
			if (orderStatusEnum.status.equalsIgnoreCase(statusFromDB)) {
				return CommonUtil.getMessageWithCode(orderStatusEnum.messageCode);
			}
		}
		return "";
	}

}
