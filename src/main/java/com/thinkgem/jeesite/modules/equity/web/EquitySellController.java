/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.equity.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.equity.entity.EquityBuy;
import com.thinkgem.jeesite.modules.equity.entity.EquitySell;
import com.thinkgem.jeesite.modules.equity.service.EquitySellService;
import com.thinkgem.jeesite.modules.etd.entity.EquityTrading;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 股票卖Controller
 * @author 陈世杰
 * @version 2017-05-22
 */
@Controller
@RequestMapping(value = "${adminPath}/equity/equitySell")
public class EquitySellController extends BaseController {

	@Autowired
	private EquitySellService equitySellService;
	
	@ModelAttribute
	public EquitySell get(@RequestParam(required=false) String id) {
		EquitySell entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = equitySellService.get(id);
		}
		if (entity == null){
			entity = new EquitySell();
		}
		return entity;
	}
	
	@RequiresPermissions("equity:equitySell:view")
	@RequestMapping(value = {"list", ""})
	public String list(EquitySell equitySell, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EquitySell> page = equitySellService.findPage(new Page<EquitySell>(request, response), equitySell); 
		model.addAttribute("page", page);
		return "modules/equity/equitySellList";
	}

	@RequiresPermissions("equity:equitySell:view")
	@RequestMapping(value = "form")
	public String form(EquitySell equitySell, Model model) {
		model.addAttribute("equitySell", equitySell);
		return "modules/equity/equitySellForm";
	}

	@RequiresPermissions("equity:equitySell:edit")
	@RequestMapping(value = "save")
	public String save(EquitySell equitySell, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, equitySell)){
			return form(equitySell, model);
		}
		User user = UserUtils.getUser();
		equitySell.setTradingId(user.getId());
		equitySellService.save(equitySell);
		addMessage(redirectAttributes, "保存股票卖成功");
		return "redirect:"+Global.getAdminPath()+"/equity/equitySell/list";
	}
	
	@RequiresPermissions("equity:equitySell:edit")
	@RequestMapping(value = "delete")
	public String delete(EquitySell equitySell, RedirectAttributes redirectAttributes) {
		equitySellService.delete(equitySell);
		addMessage(redirectAttributes, "删除股票卖成功");
		return "redirect:"+Global.getAdminPath()+"/equity/equitySell/?repage";
	}

	@ResponseBody
	@RequiresPermissions("equity:equitySell:view")
	@RequestMapping(value = "getMoney")
	public EquitySell getMoney(EquitySell equitySell) {
		
		EquitySell es = equitySellService.getMoney(equitySell);
		
//		List<Map<String, Object>> mapList = Lists.newArrayList();
//		List<EquitySell> list = equitySellService.getMoney(equitySell);
//		float tradingMoney = 0.0f;
//		String tradingNum = "";
//		String buyNum = "";
//		String tradingId = "";
//		int num = 0;
//		Map<String, Object> map = Maps.newHashMap();
//		if(list.size()>0){
//			tradingMoney = Float.parseFloat(list.get(0).getTradingMoney());
//			tradingNum = list.get(0).getTradingNum();
//			buyNum = list.get(0).getBuyNum();
//			tradingId = list.get(0).getId();
//			for(int i=1;i<list.size();i++){
//				
//				EquitySell et = list.get(i);
//				float mm = Float.parseFloat(et.getTradingMoney());
//				if(tradingMoney > mm){
//					tradingMoney = mm;
//					tradingNum = et.getTradingNum();
//					buyNum = et.getBuyNum();
//					tradingId = et.getId();
//				}
//			}
//			num = Integer.parseInt(tradingNum)-Integer.parseInt(buyNum);
//		}
//		
//		map.put("tradingId", tradingId);
//		map.put("tradingMoney", tradingMoney);
//		map.put("tradingNum", tradingNum);
//		map.put("buyNum", String.valueOf(num));
//		mapList.add(map);
		return es;
	}
	
	@RequiresPermissions("equity:equitySell:edit")
	@RequestMapping(value = "repealSell")
	public String repealSell(EquitySell equitySell, RedirectAttributes redirectAttributes) {
		List<EquitySell> list = equitySellService.getSellList(equitySell);
		if(list.size()>0){
			addMessage(redirectAttributes, "该股票已有人购买不能撤销");
		}else {
			equitySellService.repealSell(equitySell);
			addMessage(redirectAttributes, "撤销股票成功");
		}
		
		return "redirect:"+Global.getAdminPath()+"/equity/equitySell/?repage";
	}
	
	@RequiresPermissions("equity:equitySell:view")
	@RequestMapping(value = {"sellList", ""})
	public String sellList(EquitySell equitySell, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EquitySell> page = equitySellService.findPage(new Page<EquitySell>(request, response), equitySell); 
		model.addAttribute("page", page);
		return "modules/equity/equityGencyList";
	}
}