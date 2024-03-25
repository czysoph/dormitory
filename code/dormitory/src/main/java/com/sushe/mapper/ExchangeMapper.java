package com.sushe.mapper;

import java.util.List;
import java.util.Map;

import com.sushe.entity.Exchange;
import com.sushe.entity.User;


public interface ExchangeMapper {

	public int create(Exchange exchange);

	public int delete(Integer id);

	public int update(Exchange exchange);

	public int updateOut(Exchange exchange);

	public int updateEX(Exchange exchange);

	public int updateSelective(Exchange exchange);

	public List<Exchange> query(Exchange exchange);

	public Exchange detail(Integer id);

	public int count(Exchange exchange);

}