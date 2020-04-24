package com.sanguine.webpms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sanguine.service.clsGlobalFunctionsService;
import com.sanguine.webpms.bean.clsCheckInBean;
import com.sanguine.webpms.bean.clsCheckInDetailsBean;
import com.sanguine.webpms.bean.clsFolioHdBean;
import com.sanguine.webpms.bean.clsGuestMasterBean;
import com.sanguine.webpms.model.clsCheckInDtl;
import com.sanguine.webpms.model.clsCheckInHdModel;
import com.sanguine.webpms.model.clsFolioDtlModel;
import com.sanguine.webpms.model.clsFolioHdModel;
import com.sanguine.webpms.model.clsGuestMasterHdModel;
import com.sanguine.webpms.service.clsFolioService;


@Controller
public class clsReOpenFolioController 
{
	
	@Autowired
	private clsFolioController objFolioController;
	
	@Autowired
	private clsFolioService objFolioService;
	
	@Autowired
	private clsGlobalFunctionsService objGlobalFunctionsService;

	
	// Open ReOpen Folio
		@RequestMapping(value = "/frmReOpenFolio", method = RequestMethod.GET)
		public ModelAndView funOpenForm(Map<String, Object> model, HttpServletRequest request) {
			String urlHits = "1";
			String strBillNo="";
			if(request.getParameter("folioNo")!=null)
			{
				strBillNo=request.getParameter("folioNo").toString();
			}
			
			
			String sql="SELECT a.strFolioNo FROM tblbillhd a WHERE a.strBillNo='"+strBillNo+"' ";
			List list = objGlobalFunctionsService.funGetListModuleWise(sql, "sql");
			clsFolioHdBean objBean=new clsFolioHdBean();
			if(list.size()>0 && list!=null)
			{
				objBean.setStrFolioNo(list.get(0).toString());
			}
			try 
			{
				urlHits = request.getParameter("saddr").toString();
			} catch (NullPointerException e) {
				urlHits = "1";
			}
			model.put("urlHits", urlHits);
			if ("2".equalsIgnoreCase(urlHits)) {
				return new ModelAndView("frmReOpenFolio_1", "command", objBean);
			} else if ("1".equalsIgnoreCase(urlHits)) {
				return new ModelAndView("frmReOpenFolio", "command", objBean);
			} else {
				return null;
			}
		}
		
		@RequestMapping(value = "/loadReopenData", method = RequestMethod.GET)
		public @ResponseBody List funLoadQuotationExternalServiceData(@RequestParam("folioNo") String folioNo, HttpServletRequest req)
		{
			List list =null;
			try{
				String webStockDB=req.getSession().getAttribute("WebStockDB").toString();
				String clientCode = req.getSession().getAttribute("clientCode").toString();
				String 	sql="SELECT DATE_FORMAT(d.dteArrivalDate,'%d-%m-%Y'),DATE_FORMAT(d.dteDepartureDate,'%d-%m-%Y'),Concat(c.strFirstName,' ',c.strMiddleName,' ',c.strLastName) "
						+ "FROM tblbillhd a "
						+ "LEFT OUTER "
						+ "JOIN tblcheckinhd d ON a.strCheckInNo=d.strCheckInNo "
						+ "LEFT OUTER "
						+ "JOIN tblcheckindtl b ON d.strCheckInNo=b.strCheckInNo "
						+ "LEFT OUTER "
						+ "JOIN tblguestmaster c ON b.strGuestCode=c.strGuestCode "
						+ "WHERE a.strFolioNo='"+folioNo+"' and a.strClientCode='"+clientCode+"' group by d.strCheckInNo ";
				list= objGlobalFunctionsService.funGetListModuleWise(sql, "sql");
				}
			catch(Exception e)
				{
					e.printStackTrace();
				}
			return list;
		}
		
		// Save data in foliohd
		@RequestMapping(value = "/saveFolio", method = RequestMethod.POST)
		public ModelAndView funAddUpdate(@ModelAttribute("command") @Valid clsFolioHdBean objBean, BindingResult result, HttpServletRequest req) 
		{
			clsFolioHdBean objFolioBean = null;
			if (!result.hasErrors()) 
			{	
				
				String clientCode = req.getSession().getAttribute("clientCode").toString();
				String sql = "select a.strFolioNo, e.strRoomCode,a.strCheckInNo,a.strRegistrationNo,a.strReservationNo,b.strWalkInNo, "
						+ " b.dteArrivalDate,b.dteDepartureDate,b.tmeArrivalTime,b.tmeDepartureTime,b.strExtraBedCode,d.strGuestCode   "
						+ " from tblbillhd a, tblcheckinhd b,tblcheckindtl c,tblguestmaster d,tblroom e "
						+ " where a.strCheckInNo=b.strCheckInNo and b.strCheckInNo=c.strCheckInNo and  c.strGuestCode=d.strGuestCode  "
						+ " and a.strRoomNo=e.strRoomCode "
						//+ " and a.strBillNo  Not IN(select b.strBillNo from tblreceipthd b) and a.strFolioNo='"+objBean.getStrFolioNo()+"' "
						+ " and a.strFolioNo='"+objBean.getStrFolioNo()+"' "
						+ " group by a.strFolioNo AND a.strClientCode='"+clientCode+"' AND b.strClientCode='"+clientCode+"' AND c.strClientCode='"+clientCode+"' AND d.strClientCode='"+clientCode+"' AND e.strClientCode='"+clientCode+"'";
				List list = objGlobalFunctionsService.funGetListModuleWise(sql, "sql");
				for (int cnt = 0; cnt < list.size(); cnt++) 
				{
					Object[] arrObjData = (Object[]) list.get(cnt);
					objFolioBean = new clsFolioHdBean();
					objFolioBean.setStrFolioNo(objBean.getStrFolioNo());
					objFolioBean.setStrRoomNo(arrObjData[1].toString());
					objFolioBean.setStrCheckInNo(arrObjData[2].toString());
					objFolioBean.setStrRegistrationNo(arrObjData[3].toString());
					objFolioBean.setStrReservationNo(arrObjData[4].toString());
					objFolioBean.setStrWalkInNo(arrObjData[5].toString());
					objFolioBean.setDteArrivalDate(arrObjData[6].toString());
					objFolioBean.setDteDepartureDate(arrObjData[7].toString());
					objFolioBean.setTmeArrivalTime(arrObjData[8].toString());
					objFolioBean.setTmeDepartureTime(arrObjData[9].toString());
					objFolioBean.setStrExtraBedCode(arrObjData[10].toString());
					objFolioBean.setStrGuestCode(arrObjData[11].toString());
					clsFolioHdModel objFolioHdModel = objFolioController.funPrepareFolioModel(objFolioBean, clientCode, req);
					objFolioService.funAddUpdateFolioHd(objFolioHdModel);
				}
				
				req.getSession().setAttribute("success", true);
				req.getSession().setAttribute("successMessage", "ReOpened Folio No : ".concat(objBean.getStrFolioNo()) );
				return new ModelAndView("frmReOpenFolio", "command", new clsFolioHdBean());
			} else {
				return new ModelAndView("frmReOpenFolio", "command",new clsFolioHdBean());
			}
		}

}
