/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.equity.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 股票卖Entity
 * @author 陈世杰
 * @version 2017-05-22
 */
public class EquitySell extends DataEntity<EquitySell> {
	
	private static final long serialVersionUID = 1L;
	private String tradingId;		// 交易人id
	private String tradingNum;		// 交易数量
	private String buyNum;			// 已购买数量
	private String tradingMoney;		// 交易金额
	private String repealFlag;		//撤销标志
	private Date startDate;			//开始时间
	private Date endDate;			//结束时间
	private User user;				
	
	public EquitySell() {
		super();
	}

	public EquitySell(String id){
		super(id);
	}

	@Length(min=1, max=64, message="交易人id长度必须介于 1 和 64 之间")
	public String getTradingId() {
		return tradingId;
	}

	public void setTradingId(String tradingId) {
		this.tradingId = tradingId;
	}
	
	@Length(min=0, max=100, message="交易数量长度必须介于 0 和 100 之间")
	public String getTradingNum() {
		return tradingNum;
	}

	public void setTradingNum(String tradingNum) {
		this.tradingNum = tradingNum;
	}
	
	public String getBuyNum() {
		return buyNum;
	}

	public void setBuyNum(String buyNum) {
		this.buyNum = buyNum;
	}

	@Length(min=1, max=100, message="交易金额长度必须介于 1 和 100 之间")
	public String getTradingMoney() {
		return tradingMoney;
	}

	public void setTradingMoney(String tradingMoney) {
		this.tradingMoney = tradingMoney;
	}
	

	public String getRepealFlag() {
		return repealFlag;
	}

	public void setRepealFlag(String repealFlag) {
		this.repealFlag = repealFlag;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}