<!--
	date:${.now?string("yyyy-MM-dd HH:mm:ss")}
	form:jscd
-->
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.channel.policy.pcis.isoftstone.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ws:channelMessageHandle>
         <arg0><![CDATA[<?xml version="1.0" encoding="GBK" ?><PACKET type="REQUEST" version="1.0">
		<HEAD>
			<TRANS_TYPE>V7623</TRANS_TYPE>
			<USER>${interface.username}</USER>
			<PASSWORD>${interface.password}</PASSWORD>
			<SYSTEMFLAG>J</SYSTEMFLAG>
			<SERIALDECIMAL>${uuid}</SERIALDECIMAL>
		</HEAD>
		<BODY>
	        <POLICY_LIST>
	        	<#assign union = (savePolicy?size > 1)><!--产品列表大于1算联合投保-->
	        	<#list savePolicy as savePolicy>
	        	<#assign isComm=false>
	        	<#assign isComp=false>
	        	<#if (savePolicy.productComm && savePolicy.productComm.coverage?size>0) >
	        		<#assign isComm=true>
	        	</#if>
	        	<#if (savePolicy.productComp && savePolicy.productComp.coverage?size>0) >
	        		<#assign isComp=true>
	        	</#if>
	            <POLICY_DATA>
					<COMMON_PART>
	                    <#if isComm>
							<C_SEQUENCE_NO>${savePolicy.productComm.code}</C_SEQUENCE_NO><!--商业产品代码-->
						</#if>
						<#if isComp>
							<C_SEQUENCE_NO>${savePolicy.productComp.code}</C_SEQUENCE_NO><!--交强产品代码-->
						</#if>
						<C_UNDER_WRITE>${savePolicy.baseInfo.preliminary}</C_UNDER_WRITE><!-- 预核保 -->
	                </COMMON_PART>
					<BASE_PART>
						<C_DPT_CDE>${savePolicy.channelInfo.attributionOrg}</C_DPT_CDE><!--机构代码11010500 ${savePolicy.channelInfo.attributionOrg}-->
						<#if isComm>
							<C_PROD_NO>${savePolicy.productComm.code}</C_PROD_NO><!--商业产品代码-->
							<#if savePolicy.baseInfo.reNewMrkComm == '1'>
								<C_ORIG_PLY_NO>${savePolicy.baseInfo.lastPolicyNoComm}</C_ORIG_PLY_NO><!--原保单号-->
							<#else>
								<C_ORIG_PLY_NO></C_ORIG_PLY_NO>
							</#if>	
							<C_IMMEFF_MRK>${savePolicy.baseInfo.isNowFlagComm}</C_IMMEFF_MRK><!--即时生效-->
							<C_APP_TYP>${savePolicy.baseInfo.insuranceTypeComm}</C_APP_TYP><!-- 投保类型-->
							<C_PRISK_PREM_FLAG>${savePolicy.baseInfo.pureRiskPremium}</C_PRISK_PREM_FLAG><!-- 纯风险保费标志 0360 0361-->
						</#if>
						<#if isComp>
							<C_PROD_NO>${savePolicy.productComp.code}</C_PROD_NO><!--交强产品代码-->
							<#if savePolicy.baseInfo.reNewMrkComp == '1'>
								<C_ORIG_PLY_NO>${savePolicy.baseInfo.lastPolicyNoComp}</C_ORIG_PLY_NO><!--原保单号-->
							<#else>
								<C_ORIG_PLY_NO></C_ORIG_PLY_NO>
							</#if>
							<C_IMMEFF_MRK>${savePolicy.baseInfo.isNowFlagComp}</C_IMMEFF_MRK><!--即时生效-->
							<C_APP_TYP>${savePolicy.baseInfo.insuranceTypeComp}</C_APP_TYP><!-- 投保类型-->
							<#if savePolicy.baseInfo.handWorkNo >
								<C_MANUAL_MRK>1</C_MANUAL_MRK> <!-- 补录  0:否  1:是 -->
								<C_PRN_NO>${savePolicy.baseInfo.handWorkNo}</C_PRN_NO><!-- 单证号 -->
							<#else>
								<C_MANUAL_MRK>0</C_MANUAL_MRK> <!-- 补录  0:否  1:是 -->
							</#if>
						</#if>
						<C_OFFER_MRK>0</C_OFFER_MRK><!--报价标识-->
						<T_ISSUE_TM>${savePolicy.channelInfo.signDate}</T_ISSUE_TM><!--投保日期-->
						<C_OPR_CDE>${savePolicy.channelInfo.operatorCode}</C_OPR_CDE><!--操作员-->
						<C_SALE_NME>${savePolicy.channelInfo.seller}</C_SALE_NME><!--销售员-->
						<C_SLS_CDE>${savePolicy.channelInfo.salesmanNo}</C_SLS_CDE><!--业务员工号-->
						<C_SLS_NME>${savePolicy.channelInfo.saleMan}</C_SLS_NME><!--业务员姓名-->
                        <C_BRKR_NME>${savePolicy.channelInfo.agtagrName}</C_BRKR_NME><!--代理人名称-->
						<C_BRKR_CDE>${savePolicy.channelInfo.agtagrNo}</C_BRKR_CDE><!--代理人-代理机构-->
						<C_AGENCY_CDE>${savePolicy.channelInfo.agtagrNo}</C_AGENCY_CDE><!--中介机构代码-->
						<C_AGT_AGR_NO>${savePolicy.channelInfo.agencyTocol}</C_AGT_AGR_NO><!--代理协议号-->
						<N_CHANGE_RATE></N_CHANGE_RATE><!--调整系数 +-->
						<C_SERVICE_CODE>${savePolicy.channelInfo.coopBranch}</C_SERVICE_CODE><!--服务代码-->
						<#if union >
							<C_MULTI_APP_FLAG>2</C_MULTI_APP_FLAG><!--联合投保标识-->
						<#else>
							<C_MULTI_APP_FLAG>0</C_MULTI_APP_FLAG><!--联合投保标识-->
						</#if>
						
						<C_DISPT_STTL_ORG>${savePolicy.channelInfo.arbitrationInstitution}</C_DISPT_STTL_ORG><!--仲裁机构-->
						<#if savePolicy.vehicleInfo.usageCde == "309005" || savePolicy.vehicleInfo.usageCde == "309041">
							<C_PROD_TYPE>0102</C_PROD_TYPE><!--产品体系代码-->
						<#elseif savePolicy.vehicleInfo.usageCde == "309008" ||  savePolicy.vehicleInfo.usageCde == "309009">
							<C_PROD_TYPE>0103</C_PROD_TYPE><!--产品体系代码-->
						<#else>
							<C_PROD_TYPE>0101</C_PROD_TYPE><!--产品体系代码-->
						</#if>
						<C_PLY_DPT_CDE>${savePolicy.channelInfo.attributionOrg}</C_PLY_DPT_CDE><!--保单归属地-->
						<C_APPOINT_AREA_CDE>110000</C_APPOINT_AREA_CDE><!--指定查询地区代码 110000-->
						<#if isComm>
							<C_CALCULATION_FLAG>${savePolicy.baseInfo.calculation_flag}</C_CALCULATION_FLAG><!--算费标识-->
							<C_OFFER_PLAN>${savePolicy.baseInfo.offer_plan}</C_OFFER_PLAN><!-- 报价方案-->
						</#if>
						<N_RATE_PRODUCT></N_RATE_PRODUCT><!--自主核保与渠道系数乘积 +-->
						<C_SYSTEM_FLAG>J</C_SYSTEM_FLAG><!--系统标志-->
						<C_DISP_STTL_CODE>${savePolicy.channelInfo.disputeResolution}</C_DISP_STTL_CODE><!--争议处理-->
						<N_OFFLINE_NCD></N_OFFLINE_NCD><!--离线出单ncd系数 1.0-->
						<C_CONTI_OFFER_MRK></C_CONTI_OFFER_MRK><!--是否继续报价-->
						<N_COMM_ADD_TAX_RATE>0.06</N_COMM_ADD_TAX_RATE><!--进项增值税率-->
						<C_THIRD_BUSSINESS>0</C_THIRD_BUSSINESS><!--是否第三方平台 默认否1-->
						<C_UNDR_MRK>${savePolicy.baseInfo.underwritingInstructions}</C_UNDR_MRK><!--提核意见-->
						<C_RECORD_CODE></C_RECORD_CODE><!--第三方平台备案代码-->
						<C_COMPUTER_IP>${savePolicy.channelInfo.computer_ip}</C_COMPUTER_IP><!--出单点计算机ip地址-->
						<C_USB_KEY></C_USB_KEY><!--数字证书（USBKEY）-->
						<C_AGANT_PER></C_AGANT_PER><!--代理业务审批人-->
						<C_SLS_ID></C_SLS_ID><!--经办人-->
						<C_POS_NO></C_POS_NO><!--Pos机具编号-->
						<N_COST_RATE_A></N_COST_RATE_A>
						<C_BSNS_TYP>1900202</C_BSNS_TYP><!--业务来源-->
						<C_NEW_BSNS_TYP>${savePolicy.channelInfo.businessType}</C_NEW_BSNS_TYP><!--新业务来源-->
						<C_CHA_SUBTYPE>JSCD</C_CHA_SUBTYPE><!--渠道子类来源-->
						<C_ORDER_NO>${savePolicy.baseInfo.orderNum}</C_ORDER_NO><!--订单号-->
						<#if isComm>
							<C_APP_NO>${savePolicy.baseInfo.appNoComm}</C_APP_NO><!--投保单号商-->
						</#if>
						<#if isComp>
							<C_APP_NO>${savePolicy.baseInfo.appNoComp}</C_APP_NO><!--投保单号交-->
						</#if>
						<C_SLS_TEL>${savePolicy.channelInfo.sellerPhone}</C_SLS_TEL><!--业务员电话-->
						<C_AGENT_MANAGER_NME>${savePolicy.channelInfo.agentSeller}</C_AGENT_MANAGER_NME><!-- 代理经办人 -->
						<C_AGENT_MANAGER_ID>${savePolicy.channelInfo.sellerCard}</C_AGENT_MANAGER_ID><!-- 代理人证件号码 -->
						<C_SLS_IDENTITY_NO>${savePolicy.channelInfo.salesCard}</C_SLS_IDENTITY_NO><!-- 销售人员证件号码(深圳机构 必填) -->
						<T_OPR_TM>${savePolicy.channelInfo.signDate}</T_OPR_TM><!--签单日期（业务确认）-->
						<#if isComm>
							<T_INSRNC_BGN_TM>${savePolicy.baseInfo.startDateComm}</T_INSRNC_BGN_TM><!--保险起期-->
							<T_INSRNC_END_TM>${savePolicy.baseInfo.endDateComm}</T_INSRNC_END_TM><!--保险止期-->
						</#if>
						<#if isComp>
							<T_INSRNC_BGN_TM>${savePolicy.baseInfo.startDateComp}</T_INSRNC_BGN_TM><!--保险起期-->
							<T_INSRNC_END_TM>${savePolicy.baseInfo.endDateComp}</T_INSRNC_END_TM><!--保险止期-->
						</#if>
						<T_PAY_BGN_TM></T_PAY_BGN_TM><!--缴费起期-->
						<T_PAY_END_TM></T_PAY_END_TM><!--缴费止期-->
						<T_APP_TM>${savePolicy.baseInfo.appDate}</T_APP_TM><!--投保日期（业务确认）-->
						<#-- 转保 》》》 续保 》》》 新保 -->
						<#if savePolicy.productComm>
							<#if savePolicy.baseInfo.trunMrkComm == '1'>
								<C_NEW_FLG>0</C_NEW_FLG><!--新保标志-->
								<C_RENEW_MRK>0</C_RENEW_MRK><!--续保标志-->
							<#else>
								<#if (savePolicy.baseInfo.reNewMrkComm == '1')>
									<C_NEW_FLG>0</C_NEW_FLG><!--新保标志-->
									<C_RENEW_MRK>1</C_RENEW_MRK><!--续保标志-->
								<#else>
									<C_NEW_FLG>1</C_NEW_FLG><!--新保标志-->
									<C_RENEW_MRK>0</C_RENEW_MRK><!--续保标志-->
								</#if>
							</#if>
						</#if>
						<#if savePolicy.productComp>
							<#if savePolicy.baseInfo.trunMrkComp == '1'>
								<C_NEW_FLG>0</C_NEW_FLG><!--新保标志-->
								<C_RENEW_MRK>0</C_RENEW_MRK><!--续保标志-->
							<#else>
								<#if (savePolicy.baseInfo.reNewMrkComp == '1')>
									<C_NEW_FLG>0</C_NEW_FLG><!--新保标志-->
									<C_RENEW_MRK>1</C_RENEW_MRK><!--续保标志-->
								<#else>
									<C_NEW_FLG>1</C_NEW_FLG><!--新保标志-->
									<C_RENEW_MRK>0</C_RENEW_MRK><!--续保标志-->
								</#if>
							</#if>
						</#if>
						<C_INTERFER_FLAG></C_INTERFER_FLAG><!--电销干预标志-->
						<#if isComm>
							<C_UNFIX_SPC><#rt>
								<#list savePolicy.appointListComm as appoint>
									<#lt>${(appoint?index+1)+"."+appoint.specialAppoint}
								</#list><#lt></C_UNFIX_SPC>
						</#if>
						<#if isComp>
							<C_UNFIX_SPC><#rt>
								<#list savePolicy.appointListComp as appoint>
									<#lt>${(appoint?index+1)+"."+appoint.specialAppoint}
								</#list><#lt></C_UNFIX_SPC>
						</#if>
						<C_DISPT_STTL_CDE>${savePolicy.channelInfo.disputeResolution}</C_DISPT_STTL_CDE><!--争议解决方法-->
						<#if isComm>
							<N_AMT>${savePolicy.baseInfo.amountComm}</N_AMT><!--总保额-->
							<N_PRM>${savePolicy.baseInfo.premiumComm}</N_PRM><!--总保费-->
							<BN_BASE_PRM>${savePolicy.baseInfo.noShortBchPrm}</BN_BASE_PRM><!--总基础保费-->
							<C_OFFER_NO>${savePolicy.baseInfo.offerNoCommm}</C_OFFER_NO><!--报价单号-->
							<N_CAR_LOSS_PRM>${savePolicy.baseInfo.carLossPrmComm}</N_CAR_LOSS_PRM><!--纯风险保费-->
							<N_RATIO_COEF>${savePolicy.baseInfo.ratioCoef}</N_RATIO_COEF><!--短期系数-->
						</#if>
						<#if isComp>
							<N_AMT>${savePolicy.baseInfo.amountComp}</N_AMT><!--总保额-->
							<N_PRM>${savePolicy.baseInfo.premiumComp}</N_PRM><!--总保费-->
							<BN_BASE_PRM>${savePolicy.baseInfo.basePremiumComp}</BN_BASE_PRM><!--总基础保费-->
							<C_OFFER_NO>${savePolicy.baseInfo.offerNoCommp}</C_OFFER_NO><!--报价单号-->
							<N_CAR_LOSS_PRM>${savePolicy.baseInfo.carLossPrmComp}</N_CAR_LOSS_PRM><!--纯风险保费-->
							<N_COEF>${savePolicy.baseInfo.totalCoefComp}</N_COEF><!--系数-->
							<N_RATIO_COEF>${savePolicy.baseInfo.ratioCoefComp}</N_RATIO_COEF><!--短期系数-->
						</#if>
						<N_COMM_RATE></N_COMM_RATE><!--手续费比例-->
						<C_FIN_TYP>001</C_FIN_TYP><!--缴费方式-->
						<C_RATIO_TYP>D</C_RATIO_TYP><!--费率类型-->
						<N_PROFIT_RATIO></N_PROFIT_RATIO><!--利润率-->
						<N_PAY_RATIO></N_PAY_RATIO><!--赔付率-->
						<N_COST_RATE></N_COST_RATE><!--整单市场费用率-->
						<N_COST_RATIO></N_COST_RATIO><!--整单全成本率-->
						<C_COST_RATIO_LEVEL></C_COST_RATIO_LEVEL><!--整单全成本率等级-->
						<#if isComm>
							<N_TAX_PRM>${savePolicy.baseInfo.extComm.excl_tax_prm}</N_TAX_PRM><!--不含税保费-->
							<N_ADD_RATE>${savePolicy.baseInfo.extComm.add_tax_prm}</N_ADD_RATE><!--增值税额-->
						</#if>
						<#if isComp>
							<N_TAX_PRM>${savePolicy.baseInfo.extComp.excl_tax_prm}</N_TAX_PRM><!--不含税保费-->
							<N_ADD_RATE>${savePolicy.baseInfo.extComp.add_tax_prm}</N_ADD_RATE><!--增值税额-->
						</#if>
						<N_INPUT_VAT>0.06</N_INPUT_VAT><!--进项增值税率-->
						<SIN_CHANNEL_NAM></SIN_CHANNEL_NAM><!--出单渠道（合作方）名称-->


						<C_CLAIM_AMOUNT></C_CLAIM_AMOUNT><!--理赔金额-->
						<C_LAST_COMPANY></C_LAST_COMPANY><!--上年保险公司-->
						<C_NO_CLAIM_YEAR></C_NO_CLAIM_YEAR><!--未出险年数-->
						<C_PECC_TIME></C_PECC_TIME><!--违法次数-->
						<N_COMRAT_UPPER></N_COMRAT_UPPER><!--手续费支付比例上限-->
						<N_ADDITIONAL_COST_RATE>0.35</N_ADDITIONAL_COST_RATE><!--附加费用率-->
						<C_IS_INVOICE>1</C_IS_INVOICE><!--是否需要电子发票-->
						<C_IS_CHIT_MRK>1</C_IS_CHIT_MRK><!--是否需要电子保单-->
						<#if isComm>
							<C_TRUN_MRK>${savePolicy.baseInfo.trunMrkComm}</C_TRUN_MRK><!-- 转保标志 -->
							<C_PLY_TYP_INSURE>${savePolicy.baseInfo.electronicPolicyComm}</C_PLY_TYP_INSURE><!--是否电子投保-->
						</#if>
						<#if isComp>
							<C_TRUN_MRK>${savePolicy.baseInfo.trunMrkComp}</C_TRUN_MRK><!-- 转保标志 -->
							<C_PLY_TYP_INSURE>${savePolicy.baseInfo.electronicPolicyComp}</C_PLY_TYP_INSURE><!--是否电子投保-->
						</#if>
						<C_TEAM_CODE>${savePolicy.channelInfo.teamCode}</C_TEAM_CODE><!-- 团队编码 -->
						<C_TEAM_NAME>${savePolicy.channelInfo.teamName}</C_TEAM_NAME><!-- 团队名称 -->
						<#if isComm>
							<N_F_VALUE>${savePolicy.baseInfo.ciFValue}</N_F_VALUE><!-- 车险F值(商业险) -->
							<N_EXPECT_PAYRATE>${savePolicy.baseInfo.ciExpectPayrate}</N_EXPECT_PAYRATE><!-- 预期赔付率(商业险) -->
							<N_RISK_COST>${savePolicy.baseInfo.ciRiskCost}</N_RISK_COST><!-- 风险成本(商业险) -->
						</#if>
						<#if isComp>
							<N_F_VALUE>${savePolicy.baseInfo.saliFValue}</N_F_VALUE><!-- 车险F值(交强险) -->
							<N_EXPECT_PAYRATE>${savePolicy.baseInfo.saliExpectPayrate}</N_EXPECT_PAYRATE><!-- 预期赔付率(交强险) -->
							<N_RISK_COST>${savePolicy.baseInfo.saliRiskCost}</N_RISK_COST><!-- 风险成本(交强险) -->
						</#if>
						<C_BRKR_PHONE>${savePolicy.channelInfo.agentPhone}</C_BRKR_PHONE>
						<N_SALE_EXPENSE>${savePolicy.baseInfo.salesExpenses}</N_SALE_EXPENSE><!-- 商业险SE -->
						<C_DATA_SRC>9</C_DATA_SRC><!-- 数据来源 -->
						<C_CHA_TYPE></C_CHA_TYPE><!-- 渠道中级来源 -->
						<N_COMMISSION_RATEUPPER></N_COMMISSION_RATEUPPER><!-- 平台返回手续费比例上 -->
						<C_ELE_FLAG></C_ELE_FLAG><!-- 新旧电销标 -->
						<C_DOUBLE_NO></C_DOUBLE_NO><!-- 电销合并支付流水号 -->
						<C_OPER_DPT></C_OPER_DPT><!-- 业务操作机构 -->
						<C_FI_MRK></C_FI_MRK><!-- 车意联合出单标志 -->
						<N_JS_PRM></N_JS_PRM><!-- 驾驶险总保费 -->
						<N_JS_AMT></N_JS_AMT><!-- 驾驶险总保额 -->
						<N_JC_PRM></N_JC_PRM><!-- 驾乘险总保费 -->
						<N_JC_AMT></N_JC_AMT><!-- 驾乘险总保额 -->
						<C_PROPERTY_MRK></C_PROPERTY_MRK><!-- 车财联合出单标志 -->
						<N_PROPERTY_AMT></N_PROPERTY_AMT><!-- 财产险总保额 -->
						<N_PROPERTY_PRM></N_PROPERTY_PRM><!-- 财产险总保费 -->
						<C_BRKR_CERTF_CDE>${savePolicy.channelInfo.agentIdNo}</C_BRKR_CERTF_CDE><!-- 代理人身份证号 -->
						<FEE_LIST></FEE_LIST><!-- 费用信息列表节点（电销用） -->
						<UNDR_OPN_LIST></UNDR_OPN_LIST><!-- 核保信息列表节点（电销用） -->
						<IMG_UPLOAD_LIST></IMG_UPLOAD_LIST><!-- 规则引擎返回违反信息（电销用 ）-->
						<#-- 1、联合投保 2、单交强 3、单商业 4、交联商 5、商联交 -->
						<#if union >
							<C_UNION_SJ_MRK>1</C_UNION_SJ_MRK><!-- 交商同保标志 -->
							<C_UNION_APP_SERIAL_NO>JSCD${.now?string("yyyyMMddHHmmssSS")}</C_UNION_APP_SERIAL_NO> <!-- 联合投保流水号 -->
							<#if isComm>
								<C_UNION_APP_NO>${savePolicy.baseInfo.appNoComp}</C_UNION_APP_NO> <!-- 关联投保单号 -->
							</#if>
							<#if isComp>
								<C_UNION_APP_NO>${savePolicy.baseInfo.appNoComm}</C_UNION_APP_NO> <!-- 关联投保单号 -->
							</#if>
						<#else>
							<#if isComp>
								<C_UNION_SJ_MRK>2</C_UNION_SJ_MRK><!-- 交商同保标志 -->
								<C_UNION_APP_NO></C_UNION_APP_NO>
							</#if>
							<#if isComm>
								<C_UNION_SJ_MRK>3</C_UNION_SJ_MRK><!-- 交商同保标志 -->
								<C_UNION_APP_NO></C_UNION_APP_NO>
							</#if>
						</#if>
						<C_POLICY_MRK></C_POLICY_MRK><!-- 是否为政策性农机保险 0:否  1:是  -->
						<N_PROV_SUBSIDY_RATE></N_PROV_SUBSIDY_RATE><!-- 省财政补贴比例（%） -->
						<N_CITY_SUBSIDY_RATE></N_CITY_SUBSIDY_RATE><!-- 市财政补贴比例（%） -->
						<N_COUNTY_SUBSIDY_RATE></N_COUNTY_SUBSIDY_RATE><!-- 县（区）财政补贴比例（%） -->
						<N_FARMER_RATE></N_FARMER_RATE><!-- 农户缴费比例（%） -->
						<C_IS_TENDER></C_IS_TENDER><!-- 业务类型  "38602","政府采购业务" "38603","统保业务" -->
						<C_TENDER_NO></C_TENDER_NO><!-- 政府采购协议单号 -->
						<N_PROV_SUBSIDY_PRM></N_PROV_SUBSIDY_PRM><!-- 省财政补贴应收保费 -->
						<N_CITY_SUBSIDY_PRM></N_CITY_SUBSIDY_PRM><!-- 市财政补贴应收保费 -->
						<N_COUNTY_SUBSIDY_PRM></N_COUNTY_SUBSIDY_PRM><!-- 县（区）财政补贴应收保费 -->
						<N_FARMER_PRM></N_FARMER_PRM><!-- 农户缴费应收保费 -->
						<N_FARMER_REAL_PRM></N_FARMER_REAL_PRM><!-- 农户缴纳实收保费 -->
						<#if isComm>
							<#if savePolicy.channelInfo.feeMaxRate_0360>
								<N_FEE_PROD_MAX>${savePolicy.channelInfo.feeMaxRate_0360?number / 100}</N_FEE_PROD_MAX><!--商业产品销管手续费协议上限-->
							<#else>
								<N_FEE_PROD_MAX></N_FEE_PROD_MAX>
							</#if>
							<#if savePolicy.channelInfo.feeMinRate_0360>
								<N_FEE_PROD_MIN>${savePolicy.channelInfo.feeMinRate_0360?number / 100}</N_FEE_PROD_MIN><!--商业产品销管手续费协议下限-->
							<#else>
								<N_FEE_PROD_MIN></N_FEE_PROD_MIN>
							</#if>
						</#if>
						<#if isComp>
							<#if savePolicy.productComp.code =='0332'>
								<#if savePolicy.channelInfo.feeMaxRate_0332>
									<N_FEE_PROD_MAX>${savePolicy.channelInfo.feeMaxRate_0332?number / 100}</N_FEE_PROD_MAX><!--交强0332产品销管手续费协议上限-->
								<#else>
									<N_FEE_PROD_MAX></N_FEE_PROD_MAX>
								</#if>
								<#if savePolicy.channelInfo.feeMinRate_0332>
									<N_FEE_PROD_MIN>${savePolicy.channelInfo.feeMinRate_0332?number / 100}</N_FEE_PROD_MIN><!--交强0332产品销管手续费协议下限-->
								<#else>
									<N_FEE_PROD_MIN></N_FEE_PROD_MIN>
								</#if>
							</#if>
							<#if savePolicy.productComp.code =='0334'>
								<#if savePolicy.channelInfo.feeMaxRate_0334>
									<N_FEE_PROD_MAX>${savePolicy.channelInfo.feeMaxRate_0334?number / 100}</N_FEE_PROD_MAX><!--交强0334产品销管手续费协议上限-->
								<#else>
									<N_FEE_PROD_MAX></N_FEE_PROD_MAX>
								</#if>
								<#if savePolicy.channelInfo.feeMinRate_0334>
									<N_FEE_PROD_MIN>${savePolicy.channelInfo.feeMinRate_0334?number / 100}</N_FEE_PROD_MIN><!--交强0334产品销管手续费协议下限-->
								<#else>
									<N_FEE_PROD_MIN></N_FEE_PROD_MIN>
								</#if>
							</#if>
						</#if>
					</BASE_PART>
					<VEHICLE>
						<#if isComm>
							<C_QRY_CDE>${savePolicy.baseInfo.querySequenceNoComm}</C_QRY_CDE><!--查询码-->
						</#if>
						<#if isComp>
							<C_QRY_CDE>${savePolicy.baseInfo.querySequenceNoComp}</C_QRY_CDE><!--查询码-->
						</#if>
						<C_PLATE_NO>${savePolicy.vehicleInfo.plateNo}</C_PLATE_NO><!--车牌号码-->
						<C_PLATE_TYP>${savePolicy.vehicleInfo.plateTyp}</C_PLATE_TYP><!--号牌种类-->
						<#if savePolicy.vehicleInfo.insuredManyYears == '1'>
							<C_NEW_MRK>1</C_NEW_MRK><!--是否新车-->
						<#else>
							<C_NEW_MRK>${savePolicy.vehicleInfo.newVehicleFlag}</C_NEW_MRK><!--是否新车-->
						</#if>
						<C_ECDEMIC_MRK>${savePolicy.vehicleInfo.ecdemicVehicleFlag}</C_ECDEMIC_MRK><!--是否外地车-->
						<C_NEW_VHL_FLAG>${savePolicy.vehicleInfo.newVhlFlag}</C_NEW_VHL_FLAG><!--是否上牌-->
						<C_DEVICE_1_MRK>${savePolicy.vehicleInfo.changeOwnerFlag}</C_DEVICE_1_MRK><!--是否过户-->
						<C_FST_REG_YM>${savePolicy.vehicleInfo.fstRegYm}</C_FST_REG_YM><!--车辆初登日期-->
						<T_START_DATE>${savePolicy.vehicleInfo.certDate}</T_START_DATE><!-- 发证日期 -->
						<C_FRM_NO>${savePolicy.vehicleInfo.frmNo}</C_FRM_NO><!--车架号-->
						<C_VIN>${savePolicy.vehicleInfo.vin}</C_VIN><!--VIN码-->
						<C_ENG_NO>${savePolicy.vehicleInfo.engNo}</C_ENG_NO><!--发动机号-->
						<C_PLATE_COLOR>${savePolicy.vehicleInfo.plateColor}</C_PLATE_COLOR><!--车牌底色-->
						<C_USE_YEAR>${savePolicy.vehicleInfo.useYears}</C_USE_YEAR><!--车龄-->
						<C_YEAR_RUN_MIL></C_YEAR_RUN_MIL><!--平均年行驶里程-->
						<C_TRAVEL_AREA_CDE>${savePolicy.vehicleInfo.runareacode}</C_TRAVEL_AREA_CDE><!--行驶区域-->
						<C_BRAND_ID>${savePolicy.vehicleInfo.carBrand}</C_BRAND_ID><!--品牌车型-->
						<C_PLATE_BRAND_ID>${savePolicy.vehicleInfo.carBrand}</C_PLATE_BRAND_ID><!--车辆品牌-->
						
						<#if isComm>
							<C_MODEL_NME>${savePolicy.vehicleInfo.curModelNme}</C_MODEL_NME><!--商车型名称 北京-->
							<C_SPECIAL_MRK>${savePolicy.vehicleInfo.tfiSpecialMrk}</C_SPECIAL_MRK><!--特殊车投保标志-->
						</#if>
						<#if isComp>
							<C_MODEL_NME>${savePolicy.vehicleInfo.curModelNme}</C_MODEL_NME><!--交车型名称 打印厂牌型号 北京-->
							<C_SPECIAL_MRK>${savePolicy.vehicleInfo.tfiSpecialMrkComp}</C_SPECIAL_MRK><!--特殊车投保标志-->
						</#if>
						
						<C_USAGE_CDE>${savePolicy.vehicleInfo.usageCde}</C_USAGE_CDE><!--使用性质-->
						
						<#if isComm>
							<C_VHL_TYP>${savePolicy.vehicleInfo.vhlTyp}</C_VHL_TYP><!--车辆类型-->
						</#if>
						<#if isComp>
							<C_VHL_TYP>${savePolicy.vehicleInfo.vhlTypComp}</C_VHL_TYP><!--车辆类型-->
						</#if>
						
						<C_MFG_YEAR></C_MFG_YEAR><!--出厂日期-->
						<N_SEAT_NUM>${savePolicy.vehicleInfo.limitLoadPerson}</N_SEAT_NUM><!--座位数-->
						<#if savePolicy.vehicleInfo.tonnage>
							<N_TONAGE>${savePolicy.vehicleInfo.tonnage?number / 1000}</N_TONAGE><!--核定载质量吨-->
						</#if>
						<N_DISPLACEMENT>${savePolicy.vehicleInfo.displacement?number / 1000}</N_DISPLACEMENT><!--排量升-->
						<#if savePolicy.vehicleInfo.vehicleQuality != ''>
							<N_PO_WEIGHT>${savePolicy.vehicleInfo.vehicleQuality?number / 1000}</N_PO_WEIGHT><!--整备质量-->
						<#else>
							<N_PO_WEIGHT>0</N_PO_WEIGHT><!--整备质量-->
						</#if>
						<C_DISPLACEMENT_LVL>${savePolicy.vehicleInfo.power}</C_DISPLACEMENT_LVL><!--功率-->
						<C_SAFETY_DEVICE></C_SAFETY_DEVICE><!--安全装置-->
						<C_STOP_SITE></C_STOP_SITE><!--固定停放地点-->
						<C_NEW_PURCHASE_VALUE>${savePolicy.vehicleInfo.newPurchaseValue}</C_NEW_PURCHASE_VALUE><!--新车购置价-->
						<N_ACTUAL_VALUE>${savePolicy.vehicleInfo.actualValue}</N_ACTUAL_VALUE><!--车辆实际价值-->
						<C_MADE_FACTORY>${savePolicy.vehicleInfo.madeFactory}</C_MADE_FACTORY><!--制造厂名称-->
						<C_FUEL_TYPE>${savePolicy.vehicleInfo.fuelType}</C_FUEL_TYPE><!--能源种类-->
						<C_MODEL_CDE>${savePolicy.vehicleInfo.modelCde}</C_MODEL_CDE><!--车型代码-->
						<C_MODEL_CDE_2>${savePolicy.vehicleInfo.modelCde2}</C_MODEL_CDE_2><!--车型代码Ⅱ-->
						<C_PROD_PLACE>${savePolicy.vehicleInfo.importType}</C_PROD_PLACE><!--国产/进口-->
						<C_BODY_COLOR></C_BODY_COLOR><!--车身颜色-->
						<#if isComm>
							<C_MON_DESP_RATE>${savePolicy.vehicleInfo.coefficientRate}</C_MON_DESP_RATE><!--商月折旧率-->
						</#if>
						<#if isComp>
							<C_MON_DESP_RATE>${savePolicy.vehicleInfo.coefficientRateComp}</C_MON_DESP_RATE><!--交月折旧率-->
						</#if>
						<C_REG_DRI_TYP>${savePolicy.vehicleInfo.vehicleType}</C_REG_DRI_TYP><!--行驶证车辆类型-->
						<C_REG_VHL_TYP>${savePolicy.vehicleInfo.poCategory}</C_REG_VHL_TYP><!--交管车辆种类-->
						<C_LOAN_VEHICLE_FLAG>${savePolicy.vehicleInfo.insuredManyYears}</C_LOAN_VEHICLE_FLAG><!--车贷投保多年-->
						<#if isComm>
							<C_CAR_AGE>${savePolicy.vehicleInfo.carAge}</C_CAR_AGE><!--车主年龄-->
						<#else>
							<C_CAR_AGE>${savePolicy.vehicleInfo.carAgeComp}</C_CAR_AGE><!--车主年龄-->
						</#if>
						<C_DRV_LCN_ISSUE_DATE></C_DRV_LCN_ISSUE_DATE><!--行驶证发证日期-->
						<C_LAST_YEAR_CLM_TMS></C_LAST_YEAR_CLM_TMS><!--上年赔款次数-->
						<C_GLASS_TYP>${savePolicy.vehicleInfo.glassTyp}</C_GLASS_TYP><!--玻璃类型-->
						<T_TRANSFER_TM>${savePolicy.vehicleInfo.registrationTransferedDate}</T_TRANSFER_TM><!--转移登记日期-->
						<C_CHANGE_FLAG></C_CHANGE_FLAG><!--是否改装-->
						<C_POWER_TYPE>${savePolicy.vehicleInfo.powerType}</C_POWER_TYPE><!--动力类型-->
						<#if isComp><!--交强系数-->
							<#list savePolicy.rateListComp as rate>
								<C_PROV_NUM>${rate.noClaimsOfProve}</C_PROV_NUM><!--跨省投保未出险次数-->
							</#list>
							<#if savePolicy.baseInfo.lastEndDateComp != ''>
								<C_LAST_END_DATE>${savePolicy.baseInfo.lastEndDateComp}</C_LAST_END_DATE><!--上一交强险保险止期-->
							<#else>
								<C_LAST_END_DATE></C_LAST_END_DATE>
							</#if>
						<#else>
							<C_PROV_NUM></C_PROV_NUM><!--跨省投保未出险次数-->
						</#if>
						
						<C_CAREFUL_DATE></C_CAREFUL_DATE><!--审验止期-->
						<#if isComm>
							<#if savePolicy.baseInfo.reNewMrkComm == '1' || savePolicy.baseInfo.lastEndDateComm != ''>
								<C_CHECK_TIME>${savePolicy.baseInfo.lastEndDateComm}</C_CHECK_TIME><!--上一商业险保险止期-->
							<#else>
								<C_CHECK_TIME></C_CHECK_TIME>
							</#if>
						</#if>
						<C_INSPECT_REC>${savePolicy.vehicleInfo.checkVehCode}</C_INSPECT_REC><!--验车情况-->
						<T_INSPECT_TM>${savePolicy.vehicleInfo.checkVehTime}</T_INSPECT_TM><!--验车时间-->
						<C_CAR_BY_CITY></C_CAR_BY_CITY><!--车籍省-->
						<C_CAR_BY_AREA></C_CAR_BY_AREA><!--车籍地-->
						<C_NAT_OF_BUSINES>${savePolicy.vehicleInfo.businessType}</C_NAT_OF_BUSINES><!--营业性质-->
						<C_RESV_TXT_6>${savePolicy.vehicleInfo.refinedCarModel}</C_RESV_TXT_6><!--细化车型-->
						<C_FLEET_MRK>${savePolicy.policyHolder.motorcadeSign}</C_FLEET_MRK><!--车队标志-->
						<C_VHL_PKG_NO>${savePolicy.policyHolder.motorcadeNumber}</C_VHL_PKG_NO><!--车队号-->
						<C_INDUSTRY_MODEL_CODE>${savePolicy.vehicleInfo.ciModelCode}</C_INDUSTRY_MODEL_CODE><!--行业车型编码-->
						<C_INDUSTRY_MODEL_NAME>${savePolicy.vehicleInfo.vehicleModelName}</C_INDUSTRY_MODEL_NAME><!--行业车型名称(车款名称)-->
						<C_NOTICE_TYPE>${savePolicy.vehicleInfo.noticeType}</C_NOTICE_TYPE><!--公告类型-->
						<N_DISCUSS_ACTUAL_VALUE>${savePolicy.vehicleInfo.negotiatedActualValue}</N_DISCUSS_ACTUAL_VALUE><!--协商实际价值-->
						<C_MODEL_ID_CODE></C_MODEL_ID_CODE><!--车型标识编码-->
						<C_CAR_NAME>${savePolicy.vehicleInfo.carName}</C_CAR_NAME><!--车款名称-->
						<T_POLI_FIND_DATE></T_POLI_FIND_DATE><!--公安机关找回证明日期-->
						<C_PAY_LOAN>0</C_PAY_LOAN><!--是否未还清贷款-->
						<C_SEARCH_CODE></C_SEARCH_CODE><!--车型查询码-->
						<C_FAMILY_CODE></C_FAMILY_CODE><!--车系编码-->
						<C_INDUSTRY_CLASS>${savePolicy.vehicleInfo.c_industry_class}</C_INDUSTRY_CLASS><!--车系分类-->
						<C_IS_NEW_ENERGY_CAR>${savePolicy.vehicleInfo.newEnergyCar}</C_IS_NEW_ENERGY_CAR><!--是否新能源-->
						<C_TRACTOR_TYPE>${savePolicy.vehicleInfo.tractorType}</C_TRACTOR_TYPE><!--牵引车类型-->
						<C_HF_CODE>${savePolicy.vehicleInfo.hfcode}</C_HF_CODE><!--能源类型-->
					</VEHICLE>
					<VALIDATEVHL>
						<C_VALIDATE_FLAG>1</C_VALIDATE_FLAG> <!-- 是否需要验车 -->
						<C_FINISH_MRK>1</C_FINISH_MRK>       <!-- 是否已验车 -->
						<C_OPER_USER></C_OPER_USER>          <!-- 验车人     -->
						<T_VALIDATE_DATE></T_VALIDATE_DATE>  <!-- 验车时间    -->
					</VALIDATEVHL>
					<OFFER_SPEC_AGMT_LIST><!-- 特别约定 -->
						<#if isComm>
							<#list savePolicy.appointListComm as appoint>
								<OFFER_SPEC_AGMT_DATA>
								    <C_CODE>${appoint.appointNo}</C_CODE><!--特约代码-->
									<C_USE_FLAG>0</C_USE_FLAG><!--是否强制使用-->
									<C_IS_MODIFY>1</C_IS_MODIFY><!--是否可修改-->
									<C_SPEC>${appoint.specialAppoint}</C_SPEC><!--特约内容-->
								</OFFER_SPEC_AGMT_DATA>
							</#list>
						</#if>
						<#if isComp>
							<#list savePolicy.appointListComp as appoint>
							    <OFFER_SPEC_AGMT_DATA>
								    <C_CODE>${appoint.appointNo}</C_CODE><!--特约代码-->
									<C_USE_FLAG>0</C_USE_FLAG><!--是否强制使用-->
									<C_IS_MODIFY>1</C_IS_MODIFY><!--是否可修改-->
									<C_SPEC>${appoint.specialAppoint}</C_SPEC><!--特约内容-->
								</OFFER_SPEC_AGMT_DATA>
							</#list>
						</#if>
					</OFFER_SPEC_AGMT_LIST>
					<APPLICANT><!-- 投保人 -->
						<C_APP_CDE>${savePolicy.policyHolder.appCode}</C_APP_CDE><!--投保人编码-->
						<C_APP_NME>${savePolicy.policyHolder.appName}</C_APP_NME><!--投保人名称-->
						<C_CLNT_MRK>${savePolicy.policyHolder.appClntMrk}</C_CLNT_MRK><!--投保人类型-->
						<C_APPLICANT_TYP>${savePolicy.policyHolder.applicantType}</C_APPLICANT_TYP><!--投保人性质-->
						<C_CERTF_CLS>${savePolicy.policyHolder.appCertfCls}</C_CERTF_CLS><!--证件类型-->
						<T_ID_CARD_BGN_TM>${savePolicy.policyHolder.appIdentifyStartDate}</T_ID_CARD_BGN_TM><!-- 投保人证件有效起期 -->
						<T_ID_CARD_END_TM>${savePolicy.policyHolder.appIdentifyEndDate}</T_ID_CARD_END_TM><!-- 投保人证件有效止期 -->
						<C_CERTF_CDE>${savePolicy.policyHolder.appCertNo}</C_CERTF_CDE><!--证件号码-->
						<C_CLNT_ADDR>${savePolicy.policyHolder.appClntAddr}</C_CLNT_ADDR><!--通讯地址-->
						<C_COUNTRY>${savePolicy.policyHolder.appCountry}</C_COUNTRY><!--国家-->
						<C_CUS_TYPE>${savePolicy.policyHolder.appCusType}</C_CUS_TYPE><!--客户分类-->
						<C_MOBILE>${savePolicy.policyHolder.appMobile}</C_MOBILE><!--联系电话-->
						<C_GRP_FLAG>${savePolicy.policyHolder.appGroupFlag}</C_GRP_FLAG><!--个/团单标识-->
						<C_CUST_RISK_RANK>${savePolicy.policyHolder.appRiskRank}</C_CUST_RISK_RANK><!--客户洗钱风险标识-->
						<C_COUNTRY_NAM>${savePolicy.policyHolder.appCountryName}</C_COUNTRY_NAM><!--投保人国籍-->
						<#if savePolicy.channelInfo.attributionOrg?starts_with('65') && isComp>
							<C_PLY_TYP>1</C_PLY_TYP><!--保单类型-->
						<#else>
							<C_PLY_TYP>${savePolicy.policyHolder.appPolicyType}</C_PLY_TYP><!--保单类型-->
						</#if>
						<C_TEL>${savePolicy.policyHolder.appTel}</C_TEL><!--投保人移动电话-->
						<C_EMAIL_CODE>${savePolicy.policyHolder.appEmail}</C_EMAIL_CODE><!--投保人邮箱-->
						<C_TRANSACTOR_NAME>${savePolicy.policyHolder.transactorName}</C_TRANSACTOR_NAME><!--经办人-->
						<C_TRANSACTOR_MOBILE>${savePolicy.policyHolder.transactorCellphone}</C_TRANSACTOR_MOBILE><!--经办人移动电话-->
						<C_TRANSACTOR_EMAIL>${savePolicy.policyHolder.transactorEmail}</C_TRANSACTOR_EMAIL><!--经办人电子邮箱-->
						<C_OCCUP_CDE>${savePolicy.policyHolder.appOccupCode}</C_OCCUP_CDE><!--投保人职业或行业-->
						<C_LEGAL_NME></C_LEGAL_NME><!--法定代表人姓名-->
						<C_TRANSACTOR_NO>${savePolicy.policyHolder.transactorCertiCode}</C_TRANSACTOR_NO><!--经办人证件号码-->
						<C_TRANSACTOR_NO_TYP>${savePolicy.policyHolder.transactorCertiType}</C_TRANSACTOR_NO_TYP><!--经办人证件类型-->
						<C_PAY_ACCOUNT_NME>${savePolicy.policyHolder.payerName}</C_PAY_ACCOUNT_NME><!--付款人账户名称-->
						<C_PAY_REL_TYP>${savePolicy.policyHolder.payerRelationship}</C_PAY_REL_TYP><!--投保人与付款人关系类型-->
						<C_APP_REMARK>${savePolicy.policyHolder.payerRemark}</C_APP_REMARK><!--备注-->
						<C_REL_CDE></C_REL_CDE><!--投保人与被保险人关系-->
						<C_REL_BEN></C_REL_BEN><!--受益人与被保险人关系-->
						<#if savePolicy.channelInfo.attributionOrg?starts_with('61')>
							<C_SUFFIX_ADDR></C_SUFFIX_ADDR><!--投保人地址-->
						<#else>
							<C_SUFFIX_ADDR>${savePolicy.policyHolder.appClntAddr}</C_SUFFIX_ADDR><!--投保人地址-->
						</#if>
						<C_ZIP_CDE>${savePolicy.policyHolder.appZipCode}</C_ZIP_CDE><!--投保人邮编-->
						<C_CONTACT_WAY>1</C_CONTACT_WAY><!--联系方式-->
						<C_GRPPOLICY_ID>${savePolicy.policyHolder.groupPolicyId}</C_GRPPOLICY_ID><!--团单标识码-->
						<T_CRT_GRP_POLICY_ID_TM>${savePolicy.policyHolder.groupPolicyIdTime}</T_CRT_GRP_POLICY_ID_TM><!--团单标识码时间-->
						<C_VHL_PKG_NO>${savePolicy.policyHolder.motorcadeNumber}</C_VHL_PKG_NO><!--车队号-->
					</APPLICANT>
					<INSURED><!-- 被保险人 -->
						<N_SEQ_NO>1</N_SEQ_NO><!--被保人序号-->
						<C_INSURED_NME>${savePolicy.insured.insuredName}</C_INSURED_NME><!--被保人名称-->
						<C_INSURED_TYP>${savePolicy.insured.insuredType}</C_INSURED_TYP><!--被保人性质-->
						<C_CLNT_MRK>${savePolicy.insured.insuredClntMrk}</C_CLNT_MRK><!--被保人类型-->
						<C_CERTF_CLS>${savePolicy.insured.insuredCertfCls}</C_CERTF_CLS><!--证件类型-->
						<C_CERTF_CDE>${savePolicy.insured.insuredCertfCode}</C_CERTF_CDE><!--证件号码-->
						<C_ZIP_CDE>${savePolicy.insured.insuredZipCode}</C_ZIP_CDE><!--邮政编码-->
						<C_MOBILE>${savePolicy.insured.insuredMobile}</C_MOBILE><!--手机号码-->
						<C_INSURED_TEL>${savePolicy.insured.insuredTel}</C_INSURED_TEL><!--电话号码-->
						<C_CLNT_ADDR>${savePolicy.insured.insuredAddr}</C_CLNT_ADDR><!--通讯地址-->
						<C_COUNTRY_NAM>${savePolicy.insured.insuredCountryName}</C_COUNTRY_NAM><!--被保人国籍-->
						<C_EMAIL_CODE>${savePolicy.insured.insuredEmail}</C_EMAIL_CODE><!--被保人邮箱-->
						<C_TRANSACTOR_NAME>${savePolicy.insured.insuredtransactorName}</C_TRANSACTOR_NAME><!--经办人-->
						<C_TRANSACTOR_MOBILE>${savePolicy.insured.insuredtransactorCellphone}</C_TRANSACTOR_MOBILE><!--经办人移动电话-->
						<C_TRANSACTOR_EMAIL>${savePolicy.insured.insuredtransactorEmail}</C_TRANSACTOR_EMAIL><!--经办人电子邮箱-->
						<C_CONTACT_WAY>1</C_CONTACT_WAY><!--联系方式-->
						<C_COUNTRY>${savePolicy.insured.insuredCountry}</C_COUNTRY><!--国家-->
					</INSURED>
					<VHLOWNER><!-- 车主信息 -->
						<C_OWNER_NME>${savePolicy.vehicleInfo.owner}</C_OWNER_NME><!--车主-->
						<C_CERTF_CLS>${savePolicy.vehicleInfo.certfCls}</C_CERTF_CLS><!--证件类型-->
						<C_CERTF_CDE>${savePolicy.vehicleInfo.certfCde}</C_CERTF_CDE><!--证件号码-->
						<C_COWNER_TYP>${savePolicy.vehicleInfo.carOwnertype}</C_COWNER_TYP><!--车主性质-->
						<C_OWNER_CLS>${savePolicy.vehicleInfo.ownerClntMrk}</C_OWNER_CLS><!--车主类型-->
						<C_OWNER_AGE>${savePolicy.vehicleInfo.ownerAgeLvl}</C_OWNER_AGE><!--车主年龄-->
						<C_GENDER>${savePolicy.vehicleInfo.ownerGender}</C_GENDER><!--车主性别-->
					</VHLOWNER>
					<PRM_COEF><!--系数 -->
						<#if isComm><!--商业系数-->
							<C_IS_FIT>${savePolicy.baseInfo.calculation_flag}</C_IS_FIT><!--手动调整-->
							
							
							<C_DISCOUNT_AMOUNT>${savePolicy.baseInfo.extComm.discount_amount}</C_DISCOUNT_AMOUNT><!-- 优惠额 -->
							
							<#list savePolicy.rateListComm as rate>
								<#if rate.rateCode=='F01'>
									<N_CHANNEL_FACTOR>${rate.rateValue}</N_CHANNEL_FACTOR><!--自主渠道系数-->
									<#assign F01rateValue="${rate.rateValue}">
									<C_NO_CLAIM_ADJUST_REASON>${rate.noClaimAdjustReason}</C_NO_CLAIM_ADJUST_REASON>
								</#if>
								<#if rate.rateCode=='F02'>
									<N_INDEPT_UNDER_FACTOR>${rate.rateValue}</N_INDEPT_UNDER_FACTOR><!--自主核保系数-->
								</#if>
								<#if rate.rateCode=='F03'>
									<N_CLAIM_ADJUST_VALUE>${rate.rateValue}</N_CLAIM_ADJUST_VALUE><!--无赔款优待系数-->
								</#if>
								<#if rate.rateCode=='F04'>
									<N_TRAFFIC_VIOLATE_RAT>${rate.rateValue}</N_TRAFFIC_VIOLATE_RAT><!--交通违法系数-->
								</#if>
								<#if rate.rateCode=='F05'>
									<#assign F05rateValue="${rate.rateValue}">
									<N_UNDER_CHANNEL_RAT_PRODUCT>${rate.rateValue}</N_UNDER_CHANNEL_RAT_PRODUCT><!--自主核保系数和渠道系数乘积 F01*F02-->
								</#if>
								<#if rate.rateCode=='F06'>
									<N_COEF>${rate.rateValue}</N_COEF><!--系数F01*F02*F03*F04-->
								</#if>
							</#list>
							<#if savePolicy.baseInfo.calculation_flag == "A04">
								<N_MANUAL_PRODUCT>${savePolicy.baseInfo.manualProduct}</N_MANUAL_PRODUCT><!-- 手工调整乘积系数 -->
								<N_PRE_CHANNEL_FACTOR>${savePolicy.baseInfo.channelFactor}</N_PRE_CHANNEL_FACTOR><!-- 自动报价模式返回的自主渠道系数 -->
								<N_PRE_UNDER_FACTOR>${savePolicy.baseInfo.underFactor}</N_PRE_UNDER_FACTOR><!-- 自动报价模式返回的自主核保系数 -->
							<#else>
								<N_MANUAL_PRODUCT>${F05rateValue}</N_MANUAL_PRODUCT><!-- 手工调整乘积系数 -->
								<N_PRE_CHANNEL_FACTOR>${savePolicy.baseInfo.channelFactor}</N_PRE_CHANNEL_FACTOR><!-- 自动报价模式返回的自主渠道系数 -->
								<N_PRE_UNDER_FACTOR>${savePolicy.baseInfo.underFactor}</N_PRE_UNDER_FACTOR><!-- 自动报价模式返回的自主核保系数 -->
							</#if>
							<#--  <N_DPT_AUTO_UNDER_RAT>0.78947368</N_DPT_AUTO_UNDER_RAT><!--机构自主核保系数
							<N_BUSINESS_SOURCE_RAT>1.0</N_BUSINESS_SOURCE_RAT><!--业务来源系数
							<N_ALL_SAME_TIME>0.95</N_ALL_SAME_TIME><!--多险别投保系数
							<N_VHLOWNER_GENDER_RAT>1.0</N_VHLOWNER_GENDER_RAT><!--车主性别系数
							<N_VHLOWNER_COTY_RAT>1.0</N_VHLOWNER_COTY_RAT><!--车主车龄系数
							<N_HIS_CVRG_SITU_RAT>1.0</N_HIS_CVRG_SITU_RAT><!--历史出险情况系数
							<N_LOSS_RATIO_CLASS_RAT>1.0</N_LOSS_RATIO_CLASS_RAT><!--赔付率等级系数-->
						</#if>
						<#if isComp><!--交强系数-->
							<#list savePolicy.rateListComp as rate>
								<N_COEF>${rate.rateValue}</N_COEF><!--系数-->
								<C_DISCOUNT_AMOUNT>${savePolicy.baseInfo.extComp.discount_amount}</C_DISCOUNT_AMOUNT><!--优惠额-->
								<C_ACCIDENT_INFO>00</C_ACCIDENT_INFO><!--责任事故问询-->
								<C_DANGER_INFO></C_DANGER_INFO><!--出险信息-->
								<C_NDISC_RSN></C_NDISC_RSN><!--是否浮动-->
								<C_SAFETY_VIOLA>00</C_SAFETY_VIOLA><!--安全违法行为问询-->
								<N_RECORD_RISE_RAT></N_RECORD_RISE_RAT><!--上一保险年度道路交通安全违法行为记录浮动比例-->
								<N_LY_REP_RISE_RAT></N_LY_REP_RISE_RAT><!--上一保险年度有责交通事故或有责任赔款记录浮动比率-->
								<N_DRUNK_DRI></N_DRUNK_DRI><!--饮酒后驾驶机动车次数-->
								<N_NO_GOOD></N_NO_GOOD><!--无证驾驶，扣证期间驾驶或驾驶与驾照不符的机动车-->
								<N_SPEED_NUM></N_SPEED_NUM><!--机动车行驶超过规定时速50%上的次数-->
								<N_BREAK_RUL></N_BREAK_RUL><!--违反交通信号、闯红灯、闯禁行-->
								<N_OVERLOAD_NUM></N_OVERLOAD_NUM><!--超载次数-->
								<N_OTHER_NUM></N_OTHER_NUM><!--其他次数(按每次上浮1%)-->
								<N_DEATH_TOLL></N_DEATH_TOLL><!--死亡人数-->
								<N_ONE_YEAR_NO_DANGER>${rate.noClaimsOfProve}</N_ONE_YEAR_NO_DANGER><!--跨省首年投保未出险证明年数-->
								<N_PECCANCY_ADJUST_VALUE>${rate.peccancyAdjust}</N_PECCANCY_ADJUST_VALUE><!--违法调整系数-->
								<N_CLAIM_ADJUST_VALUE>${rate.claimAdjust}</N_CLAIM_ADJUST_VALUE><!--理赔调整系数-->
								<N_DRIVER_RATE>${rate.driverRate}</N_DRIVER_RATE><!--指定驾驶员调整系数-->
								<N_DISTRICT_RATE>${rate.districtRate}</N_DISTRICT_RATE><!--地区系数-->
								<N_ADDITION_RATE>${rate.additionRate}</N_ADDITION_RATE><!--附加手续费比例-->
								<C_PECCANCY_ADJUST_REASON>${rate.peccancyAdjustReason}</C_PECCANCY_ADJUST_REASON><!--违法浮动原因代码-->
								<C_CLAIM_ADJUST_REASON>${rate.claimAdjustReason}</C_CLAIM_ADJUST_REASON><!--理赔浮动原因代码-->
								<C_NO_FLOAT_REASON>${rate.noFloatReason}</C_NO_FLOAT_REASON><!--不浮动原因代码-->
								<N_CLAIM_TIME></N_CLAIM_TIME><!--上年度出险次数-->
								<C_NDISC_RSN_CODE>${rate.noFloatReason}</C_NDISC_RSN_CODE><!--交强险不浮动原因码-->
							</#list>
						</#if>
					</PRM_COEF>
					<CVRG_LIST><!-- 险别 -->
						<#if isComm><!--商业-->
							<#list savePolicy.productComm.coverage as cvrg>
                            <CVRG_DATA>
								<N_SEQ_NO>${cvrg.coverageSeq}</N_SEQ_NO><!--序号-->
								<#if (cvrg.coverageCode?starts_with('00') && cvrg.coverageCode?length gt 2)>
									<C_CVRG_NO>0362${cvrg.coverageCode?substring(1)}</C_CVRG_NO> <!--险别代码-->
									<#if cvrg.coverageCode=="001">
										<N_NEW_EQUIPMENT_AMT>${cvrg.coverageRemark}</N_NEW_EQUIPMENT_AMT><!--新增设备保额-->
										<C_DDUCT_RATE_LVL></C_DDUCT_RATE_LVL><!--绝对免赔率-->
									<#elseif cvrg.coverageCode=="002">
										<N_NEW_EQUIPMENT_AMT></N_NEW_EQUIPMENT_AMT><!--新增设备保额-->
										<C_DDUCT_RATE_LVL>${cvrg.coverageRemark}</C_DDUCT_RATE_LVL><!--绝对免赔率-->
									<#else>
										<N_NEW_EQUIPMENT_AMT></N_NEW_EQUIPMENT_AMT><!--新增设备保额-->
										<C_DDUCT_RATE_LVL></C_DDUCT_RATE_LVL><!--绝对免赔率-->
									</#if>
								<#else>
									<C_CVRG_NO>0360${cvrg.coverageCode}</C_CVRG_NO> <!--险别代码-->
									<N_NEW_EQUIPMENT_AMT></N_NEW_EQUIPMENT_AMT><!--新增设备保额-->
									<C_DDUCT_RATE_LVL></C_DDUCT_RATE_LVL><!--绝对免赔率-->
								</#if>
								<C_IS_NEW_EQUIPMENT>${cvrg.isNewEquipment}</C_IS_NEW_EQUIPMENT><!--是否新增设备-->
								<N_NEW_EQUIPMENT_BASEPRM>${cvrg.newEquipmentBasePremium}</N_NEW_EQUIPMENT_BASEPRM><!--新增设备基础保费-->
								<N_NEWEQUIPMENT_PRM>${cvrg.newEquipmentPremium}</N_NEWEQUIPMENT_PRM><!--新增设备保单保费-->
								
								<#if cvrg.coverageCode=="01"><#-- 车损险 -->
									<N_DEDUCTIBLE>${cvrg.deductible}</N_DEDUCTIBLE><!--绝对免赔额-->
									<N_DEDUCTIBLE_DISCOUNT>${cvrg.deductibleRate}</N_DEDUCTIBLE_DISCOUNT><!--绝对免赔额费率折扣系数-->
									<N_LIAB_DAYS_LMTT>${cvrg.coverageNumber}</N_LIAB_DAYS_LMTT>
									<C_PER_AMT>${cvrg.insuredAmt}</C_PER_AMT><!--投保人数-->
								<#elseif cvrg.coverageCode=="02">
									<N_LIAB_DAYS_LMTT>${cvrg.coverageNumber}</N_LIAB_DAYS_LMTT>
									<C_PER_AMT>${cvrg.insuredAmt}</C_PER_AMT><!--投保人数-->
								<#elseif cvrg.coverageCode=="03" || cvrg.coverageCode=="04">
									<C_PER_AMT>${cvrg.unitInsured}</C_PER_AMT>
									<N_LIAB_DAYS_LMTT>${cvrg.coverageNumber}</N_LIAB_DAYS_LMTT><!--投保人数-->
								<#elseif cvrg.coverageCode=="09"><#-- 修理期间 -->
									<C_PER_AMT>${cvrg.unitInsured}</C_PER_AMT><!--赔偿限额-->
									<N_LIAB_DAYS_LMTT>${cvrg.coverageNumber}</N_LIAB_DAYS_LMTT><!--保险天数-->
								<#else>
									<C_PER_AMT>${cvrg.coverageAmount}</C_PER_AMT><!--投保人数-->
									<N_LIAB_DAYS_LMTT>${cvrg.coverageNumber}</N_LIAB_DAYS_LMTT>
								</#if>
								<N_AMT>${cvrg.insuredAmt}</N_AMT><!--保额-->
								
								<#--
								<N_DDUCT_RATE>${cvrg.deductibleRate}</N_DDUCT_RATE>免赔率
								<C_DDUCT_MRK>${cvrg.deductible}</C_DDUCT_MRK>免赔额
								--> 
								
								<C_GLASS_TYPE>${cvrg.glassType}</C_GLASS_TYPE><!--玻璃类型(商)-->
								<#if cvrg.coverageCode=="06">
									<C_SPECGLASS_MRK>${cvrg.specglassMrk}</C_SPECGLASS_MRK> <!--防弹玻璃标志-->
								<#else>
									<C_SPECGLASS_MRK></C_SPECGLASS_MRK> <!--防弹玻璃标志-->
								</#if>
								<N_BASE_PRM>${cvrg.basicPremium}</N_BASE_PRM><!--基本保费  -->
								<N_PER_PRM_SHORT>${cvrg.beforeDiscountPremium}</N_PER_PRM_SHORT> <!--乘过短期系数基准保费-->
								<N_BEF_ANN_PRM>${cvrg.coverageExt.noshort_bchprm}</N_BEF_ANN_PRM><!--未乘短期系数基准保费-->
								<N_PRM>${cvrg.coveragePremium}</N_PRM><!--应缴总保费-->
								<N_RATE>${cvrg.premiumRate}</N_RATE><!--费率-->
								
								<C_COST_RATE></C_COST_RATE><#--险别市场费用率-->
								<C_COST_RATIO>${cvrg.costDiscount}</C_COST_RATIO><#--险别全成本率-->
								<N_COST_RATIO_LEVEL>${cvrg.coverageExt.cost_ratio_level}</N_COST_RATIO_LEVEL><!--险别全成本率等级-->
								<N_PURE_RISK_PREMIUM>${cvrg.coverageExt.bch_risk_prm}</N_PURE_RISK_PREMIUM><!--主险基准纯风险保费-->
								<N_NON_DEDUCT_PURE_RISK_PRM>${cvrg.coverageExt.non_deduct_pure_risk_prm}</N_NON_DEDUCT_PURE_RISK_PRM><#--不计免赔基准纯风险保费-->
								<N_ADDT_COST_RATE>${cvrg.coverageExt.addt_cost_rate}</N_ADDT_COST_RATE><!--附加费用率-->
								<N_CVRG_RISK_COST></N_CVRG_RISK_COST><#--险种风险成本-->
								<N_CVRG_PAY_RATIO>${cvrg.coverageExt.cvrg_pay_ratio}</N_CVRG_PAY_RATIO><#--险种赔付率-->
								<C_CVRG_PAY_LEVEL></C_CVRG_PAY_LEVEL><#--险种赔付率等级-->
							</CVRG_DATA>
							</#list>
						</#if>
						<#if isComp><!--交强-->
							<#list savePolicy.productComp.coverage as cvrg>
                            <CVRG_DATA>
								<N_SEQ_NO>1</N_SEQ_NO><!--序号-->
								<C_CVRG_NO>0332${cvrg.coverageCode}</C_CVRG_NO> <!--险别代码-->
								<C_PER_AMT>${cvrg.coverageAmount}</C_PER_AMT><!--投保人数 赔偿限额-->
								<N_LIAB_DAYS_LMTT>${cvrg.coverageNumber}</N_LIAB_DAYS_LMTT><!--保险天数-->
								<N_AMT>${cvrg.insuredAmt}</N_AMT><!--保额-->
								<N_DDUCT_RATE></N_DDUCT_RATE><!--免赔率-->
								<C_DDUCT_MRK></C_DDUCT_MRK><!--免赔额-->
								<C_GLASS_TYPE>${cvrg.glassType}</C_GLASS_TYPE><!--玻璃类型(交)-->
								<N_BASE_PRM>${cvrg.basicPremium}</N_BASE_PRM><!--基本保费-->
								<N_BEF_ANN_PRM>${cvrg.beforeDiscountPremium}</N_BEF_ANN_PRM><!--基准保费-->
								<N_PRM>${cvrg.coveragePremium}</N_PRM><!--应缴总保费-->
								<N_RATE>${cvrg.premiumRate}</N_RATE><!--费率-->
								<C_COST_RATE></C_COST_RATE><!--险别市场费用率-->
								<C_COST_RATIO>${cvrg.costDiscount}</C_COST_RATIO><!--险别全成本率-->
								<N_COST_RATIO_LEVEL>${cvrg.coverageExt.cost_ratio_level}</N_COST_RATIO_LEVEL><!--险别全成本率等级-->
								<N_PURE_RISK_PREMIUM>${cvrg.coverageExt.bch_risk_prm}</N_PURE_RISK_PREMIUM><!--主险基准纯风险保费-->
								<N_NON_DEDUCT_PURE_RISK_PRM></N_NON_DEDUCT_PURE_RISK_PRM><!--不计免赔基准纯风险保费-->
								<N_DEDUCTIBLE>${cvrg.deductible}</N_DEDUCTIBLE><!--绝对免赔额-->
								<N_DEDUCTIBLE_DISCOUNT>${cvrg.expDiscount}</N_DEDUCTIBLE_DISCOUNT><!--绝对免赔额费率折扣系数-->
								<N_ADDT_COST_RATE>${cvrg.coverageExt.addt_cost_rate}</N_ADDT_COST_RATE><!--附加费用率-->
								<N_CVRG_RISK_COST>${cvrg.coverageExt.cvrg_risk_cost}</N_CVRG_RISK_COST><!--险种风险成本-->
								<N_CVRG_PAY_RATIO>${cvrg.coverageExt.cvrg_pay_ratio}</N_CVRG_PAY_RATIO><!--险种赔付率-->
								<C_CVRG_PAY_LEVEL>${cvrg.coverageExt.pay_ratio_level}</C_CVRG_PAY_LEVEL><!--险种赔付率等级-->
							</CVRG_DATA>
							</#list>
						</#if>
					</CVRG_LIST>
					<#if (savePolicy.channelInfo.attributionOrg && savePolicy.channelInfo.attributionOrg?substring(0,2) == "44")>
					<SALE_LIST>
						<#list savePolicy.channelInfoGD as channelInfoGD>
						<SALE_DATA>
							<N_SEQ_NO>${channelInfoGD_index+1}</N_SEQ_NO><!--序号-->
							<C_EMP_TYP>${channelInfoGD.sellerType}</C_EMP_TYP><!--销售员类型-->
							<C_EMP_CDE>${channelInfoGD.saleMan}</C_EMP_CDE><!--业务员-->
							<C_SALE_NAME>${channelInfoGD.seller}</C_SALE_NAME><!--销售员-->
							<C_JOB_NO>${channelInfoGD.permitNo}</C_JOB_NO><!--执行证号-->
							<C_BEHAVIOR>${channelInfoGD.personType}</C_BEHAVIOR><!--人员类型-->
						</SALE_DATA>
						</#list>
					</SALE_LIST>
					</#if>
					<#if isComp>
						<TAXATION><!-- 车船税-交强专用  -->
							<#if savePolicy.channelInfo.attributionOrg?starts_with('12')>
								<C_TAX_ITEM_CDE>${savePolicy.vehicleTax.taxStandard}</C_TAX_ITEM_CDE><!--税目-->
								<C_TAXPAYER_NME>${savePolicy.vehicleTax.taxPayerName}</C_TAXPAYER_NME><!--纳税人名称-->
								<C_TAXPAYER_CERT_NO>${savePolicy.vehicleTax.taxpayerCertNo}</C_TAXPAYER_CERT_NO><!--纳税人身份证号码-->
								<C_TAXPAYER_ID>${savePolicy.vehicleTax.taxpayerNo}</C_TAXPAYER_ID><!--纳税人识别号-->
								<C_TAXPAYER_ADDR>${savePolicy.vehicleTax.taxpayerAddress}</C_TAXPAYER_ADDR><!--纳税人地址-->
								<C_ABATE_MRK>${savePolicy.vehicleTax.abateMrk}</C_ABATE_MRK><!--是否减税-->
								<#if savePolicy.vehicleTax.abateMrk == '1'>
									<C_TAX_RELIEF_CERT_NO>${savePolicy.vehicleTax.reduceNo}</C_TAX_RELIEF_CERT_NO><!--减免税证明号-->
								</#if>
								<C_TAXABLE_AMT>${savePolicy.vehicleTax.currentTax}</C_TAXABLE_AMT><!--当年应缴金额-->
								<N_LAST_YEAR>${savePolicy.vehicleTax.payLastYear}</N_LAST_YEAR><!--往年补缴金额-->
								<N_OVERDUE_AMT>${savePolicy.vehicleTax.lateFee}</N_OVERDUE_AMT><!--滞纳金-->
								<C_VS_TAX_MRK>${savePolicy.vehicleTax.taxMrk}</C_VS_TAX_MRK><!--车船税标志-->
								<C_TAXPAYER_CERT_TYP>${savePolicy.vehicleTax.idType}</C_TAXPAYER_CERT_TYP>
								<N_TAXABLE_MONTHS>${savePolicy.vehicleTax.taxableMonths}</N_TAXABLE_MONTHS><!--当年应缴应纳税月份数-->
								<C_PAYTAX_TYP>${savePolicy.vehicleTax.taxCurrentType}</C_PAYTAX_TYP><!--纳税类型-->
								<T_BILL_DATE>${savePolicy.vehicleInfo.buyCarDate}</T_BILL_DATE><!--新车发票购买日期月份-->
								<C_TAX_BELONG_TM>${savePolicy.vehicleTax.taxPeriod}</C_TAX_BELONG_TM><!--税款所属期-->
								<C_TAX_VCH_TYP>${savePolicy.vehicleTax.taxType}</C_TAX_VCH_TYP><!-- 税票号码类型 -->
								<C_TAX_VCH_NO>${savePolicy.vehicleTax.taxNum}</C_TAX_VCH_NO><!-- 税票号 -->
								<C_TAXITEM_CDE>${savePolicy.vehicleTax.taxRegNumber}</C_TAXITEM_CDE><!--税务登记证号-->
								<C_FREE_TAX_ORG>${savePolicy.vehicleTax.taxDepartment}</C_FREE_TAX_ORG><!--开具税务机关代码 -->
								<C_TRANSFER_CAR_MRK>1</C_TRANSFER_CAR_MRK><!--是否外地转籍车-->
								<C_CITIZENSHIP>${savePolicy.vehicleTax.taxPayerConruty}</C_CITIZENSHIP><!-- 国籍 -->
								<C_POSTAL_CODE>${savePolicy.vehicleTax.taxPayerZip}</C_POSTAL_CODE><!--邮编-->
								<C_TEL>${savePolicy.vehicleTax.taxPayerTel}</C_TEL><!--电话-->
								<N_AGG_TAX>${savePolicy.vehicleTax.sumUpTax}</N_AGG_TAX><!--合计税款-->
								<#if savePolicy.vehicleTax.vehicleQuality != ''>
									<C_CURB_WT>${savePolicy.vehicleTax.vehicleQuality}</C_CURB_WT><!--整备质量 吨-->
								<#else>
									<C_CURB_WT>0</C_CURB_WT><!--整备质量-->
								</#if>
								<#if savePolicy.vehicleTax.displacement != ''>
									<N_EXHAUST_CAPACITY>${savePolicy.vehicleTax.displacement?number / 1000}</N_EXHAUST_CAPACITY><!--排量-->
								<#else>
									<N_EXHAUST_CAPACITY>0</N_EXHAUST_CAPACITY><!--排量-->
								</#if>
								<N_CUR_TOTAL_AMOUNT>${savePolicy.vehicleTax.taxTotalAmount}</N_CUR_TOTAL_AMOUNT><!--本期合计税款-->
								<C_TAX_AUTH_CDE>${savePolicy.vehicleTax.taxCounty}</C_TAX_AUTH_CDE><!-- 税务机关坐落区县 -->
								<C_TAX_COUNTRY_CDE>${savePolicy.vehicleTax.taxTown}</C_TAX_COUNTRY_CDE><!-- 街道乡镇代码 -->
								<C_PAY_ID>${savePolicy.vehicleTax.taxKo}</C_PAY_ID><!--完税标识 -->
								<#if savePolicy.vehicleTax.taxKo == '1'>
									<C_TAX_PAYMENT_RECPT_NO>${savePolicy.vehicleTax.payNo}</C_TAX_PAYMENT_RECPT_NO><!--完税凭证号-->
								</#if>
								
								<!-- 营业性质  营业100，非营业200 -->
								<#if savePolicy.vehicleInfo.businessType == "359001"><!-- 营业 -->
									<C_TAX_USE_TYPE>100</C_TAX_USE_TYPE><!--使用性质-->
								<#else><!-- 非营业 -->
									<C_TAX_USE_TYPE>200</C_TAX_USE_TYPE><!--使用性质-->
								</#if>
								
								<C_BRAND_NAME>${savePolicy.vehicleTax.brandName}</C_BRAND_NAME><!--车辆品牌 -->
								<C_MODEL_CODE>${savePolicy.vehicleTax.modelCode}</C_MODEL_CODE><!--车辆型号 车型代码 -->
							<#else>
								<C_CALC_TAX_FLAG>${savePolicy.vehicleTax.calcFlag}</C_CALC_TAX_FLAG><!--算税标识-->
								<C_DECLARE_STATUS></C_DECLARE_STATUS><!--车船税申报状态-->
								<C_TAX_SIGN>${savePolicy.vehicleTax.taxesFlag}</C_TAX_SIGN><!--缴纳税款标志 北京-->
								<C_TAX_ITEM_CDE>${savePolicy.vehicleTax.taxStandard}</C_TAX_ITEM_CDE><!--税目-->
								
								<C_TAXPAYER_NME>${savePolicy.vehicleTax.taxPayerName}</C_TAXPAYER_NME><!--纳税人名称-->
								<C_TAXPAYER_CERT_NO>${savePolicy.vehicleTax.taxpayerCertNo}</C_TAXPAYER_CERT_NO><!--纳税人身份证号码-->
								<C_TAXPAYER_ID>${savePolicy.vehicleTax.taxpayerCertNo}</C_TAXPAYER_ID><!--纳税人识别号-->
								<#if (savePolicy.vehicleTax.taxCurrentType=='C')>
									<C_ABATE_MRK>001</C_ABATE_MRK><!--是否减税 是-->
								<#else>
									<C_ABATE_MRK>002</C_ABATE_MRK><!--是否减税 否 ${savePolicy.vehicleTax.taxCurrentType}-->
								</#if>
								<C_ABATE_RSN>${savePolicy.vehicleTax.taxReduceRsn}</C_ABATE_RSN><!--减免税原因-->
								<C_ABATE_PROP>${savePolicy.vehicleTax.taxReduceProp}</C_ABATE_PROP><!--减税比例-->
								<C_ABATE_AMT>${savePolicy.vehicleTax.taxFreeAmount}</C_ABATE_AMT><!--减税金额-->
								<C_FREE_TYPE>${savePolicy.vehicleTax.taxReduceType}</C_FREE_TYPE><!--减免税方案-->
								<C_TAX_UNIT>${savePolicy.vehicleTax.unitRate}</C_TAX_UNIT><!--单位计税金额-->
								<#if savePolicy.channelInfo.attributionOrg?starts_with('11')>
									<C_CURB_WT>${savePolicy.vehicleTax.vehicleQuality}</C_CURB_WT><!--整备质量-->
								<#else>
									<#if savePolicy.vehicleInfo.vehicleQuality != ''>
										<C_CURB_WT>${savePolicy.vehicleTax.vehicleQuality}</C_CURB_WT><!--整备质量 吨-->
									<#else>
										<C_CURB_WT>0</C_CURB_WT><!--整备质量-->
									</#if>
								</#if>
								<C_LAST_TAX_YEAR>${savePolicy.vehicleTax.lastPaidYear}</C_LAST_TAX_YEAR><!--前次缴费年度-->
								<C_LAST_SALI_END_DATE>${savePolicy.vehicleTax.payLastEndDate}</C_LAST_SALI_END_DATE><!--前次保单终止日期-->
								<N_ANN_UNIT_TAX_AMT>${savePolicy.vehicleTax.annualTaxamt}</N_ANN_UNIT_TAX_AMT><!--年单位税额-->
								<C_TAXABLE_AMT>${savePolicy.vehicleTax.currentTax}</C_TAXABLE_AMT><!--当年应缴金额-->
								<N_LAST_YEAR>${savePolicy.vehicleTax.payLastYear}</N_LAST_YEAR><!--往年补缴金额-->
								<N_OVERDUE_AMT>${savePolicy.vehicleTax.lateFee}</N_OVERDUE_AMT><!--滞纳金-->
								<N_OVERDUE_DAYS>${savePolicy.vehicleTax.lateDay}</N_OVERDUE_DAYS><!--滞纳天数-->
								<N_OVERDUE_FINE_PROP>0.0005</N_OVERDUE_FINE_PROP><!--滞纳金比例-->
								<N_AGG_TAX>${savePolicy.vehicleTax.sumUpTax}</N_AGG_TAX><!--合计税款-->
								<C_DECLEARE_DATE></C_DECLEARE_DATE><!--纳税申报日期-->
								<C_VS_TAX_MRK>${savePolicy.vehicleTax.taxMrk}</C_VS_TAX_MRK><!--车船税标志-->
								<C_CERTIFICATE_DATE>${savePolicy.vehicleInfo.certDate}</C_CERTIFICATE_DATE><!--发证日期-->
								<N_CHARGE_AMT>${savePolicy.vehicleTax.poundage}</N_CHARGE_AMT><!--手续费-->
								<N_CHARGE_PROP>${savePolicy.vehicleTax.poundageProportion}</N_CHARGE_PROP><!--手续费比例-->
								<N_TAXABLE_MONTHS>${savePolicy.vehicleTax.taxableMonths}</N_TAXABLE_MONTHS><!--当年应缴应纳税月份数-->
								<C_TAXPAYER_ADDR>${savePolicy.vehicleTax.taxpayerAddress}</C_TAXPAYER_ADDR><!--纳税人地址-->
								<C_TAXPAYER_CERT_TYP>${savePolicy.vehicleTax.idType}</C_TAXPAYER_CERT_TYP><!--证照类型-->
								<C_PAYTAX_TYP>${savePolicy.vehicleTax.taxCurrentType}</C_PAYTAX_TYP><!--纳税类型-->
								<#if savePolicy.vehicleTax.displacement != ''>
									<N_EXHAUST_CAPACITY>${savePolicy.vehicleTax.displacement?number / 1000}</N_EXHAUST_CAPACITY><!--排量-->
								<#else>
									<N_EXHAUST_CAPACITY>0</N_EXHAUST_CAPACITY><!--排量-->
								</#if>
								<T_BILL_DATE>${savePolicy.vehicleInfo.buyCarDate}</T_BILL_DATE><!--新车发票购买日期月份-->
								<C_DRAWBACK_OPR>${savePolicy.vehicleTax.drawbackOpr}</C_DRAWBACK_OPR><!--是否修改往年应缴-->
								<N_LAST_YEAR_TAXABLE_MONTHS>${savePolicy.vehicleTax.taxableMonthsLast}</N_LAST_YEAR_TAXABLE_MONTHS><!--往年应缴月份数-->
								<N_BEFOR_TAX></N_BEFOR_TAX><!--往年税目-->
								<N_BEFOR_UNIT_TAX></N_BEFOR_UNIT_TAX><!--往年单位税额-->
								<C_TAX_PAYMENT_RECPT_NO>${savePolicy.vehicleTax.payNo}</C_TAX_PAYMENT_RECPT_NO><!--完税凭证号-->
								<C_PAYTAX_FLAG>${savePolicy.vehicleTax.taxKo}</C_PAYTAX_FLAG><!--已完税标志（北京）-->
								<C_PAY_ID>${savePolicy.vehicleTax.payTaxFlag}</C_PAY_ID><!--完税标识 -->
								<C_VEHICLE_NUMBER>${savePolicy.vehicleTax.unitTypeCode}</C_VEHICLE_NUMBER><!--车辆编号 全国的是好将计税单位代码 传到此处-->
								<C_TAX_EFF_BGN_TM>${savePolicy.vehicleTax.taxPeriodStart}</C_TAX_EFF_BGN_TM><!--税款所属起期-->
								<C_TAX_EFF_END_TM>${savePolicy.vehicleTax.taxPeriodEnd}</C_TAX_EFF_END_TM><!--税款所属止期-->
								<#-- <C_DEPARTMENT_NO_O_LOCAL>02</C_DEPARTMENT_NO_O_LOCAL>
								<C_TAX_ORG_NOLOCAL>02</C_TAX_ORG_NOLOCAL>  -->
								<C_TAX_BELONG_TM>${savePolicy.vehicleTax.taxPeriod}</C_TAX_BELONG_TM><!--税款所属期-->
								<C_TAX_VCH_TYP></C_TAX_VCH_TYP><!--税票号码类型-->
								<C_TAX_VCH_NO></C_TAX_VCH_NO><!--税票号${savePolicy.vehicleTax.taxCurrentType}-->
								<#-- 鸡毛的
								<#if savePolicy.vehicleTax.taxCurrentType=='C' || savePolicy.vehicleTax.taxCurrentType=='E'>
								-->
									<C_FREE_TAX_ORG>${savePolicy.vehicleTax.taxDepartmentNameFreeOrg}</C_FREE_TAX_ORG><!--开具税务机关代码-->
									<C_TAX_AUTHORITIES>${savePolicy.vehicleTax.taxDepartmentName}</C_TAX_AUTHORITIES><!--开具税务机关名称-->
								<#--
								<#else>
									<C_FREE_TAX_ORG>${savePolicy.vehicleTax.taxDepartmentNameFreeOrg}</C_FREE_TAX_ORG>
									<C_TAX_AUTHORITIES>${savePolicy.vehicleTax.taxDepartmentName}</C_TAX_AUTHORITIES>
								</#if>
								-->
								
								<C_TRANSFER_CAR_MRK></C_TRANSFER_CAR_MRK><!--是否外地转籍车-->
								<C_CITIZENSHIP></C_CITIZENSHIP><!--国籍-->
								<C_POSTAL_CODE>${savePolicy.vehicleTax.taxPayerZip}</C_POSTAL_CODE><!--邮编-->
								<C_TEL>${savePolicy.vehicleTax.taxPayerTel}</C_TEL><!--电话-->
								<N_CUR_TOTAL_AMOUNT>${savePolicy.vehicleTax.taxTotalAmount}</N_CUR_TOTAL_AMOUNT><!--本期合计税款-->
								<N_TAX_DUE>${savePolicy.vehicleTax.taxDue}</N_TAX_DUE><!--当期应纳税额-->
								<C_TAX_RELIEF_CERT_NO>${savePolicy.vehicleTax.reduceNo}</C_TAX_RELIEF_CERT_NO><!--减免税证明号-->
								<C_TAX_COUNTRY_CDE></C_TAX_COUNTRY_CDE><!--街道乡镇代码-->
								<C_TAX_USE_TYPE>${savePolicy.vehicleInfo.usageCde}</C_TAX_USE_TYPE><!--使用性质-->
								<C_TAXITEM_CDE>${savePolicy.vehicleTax.taxRegNumber}</C_TAXITEM_CDE><!--税务登记证号-->
								<C_DEPARTMENT_NONLOCAL>${savePolicy.vehicleTax.departmentNonlocal}</C_DEPARTMENT_NONLOCAL><!--外地车开具税务机关名称-->
							</#if>
						</TAXATION>
					</#if>
					<SIGN_INFO>
						<C_SIGN_FLAG>${savePolicy.baseInfo.signFlag}</C_SIGN_FLAG><#--是否签报业务-->
						<C_SIGN_SERI_NUM>${savePolicy.baseInfo.signTheWatermark}</C_SIGN_SERI_NUM><#--签报流水号-->
					</SIGN_INFO>
				</POLICY_DATA>
				</#list>
			</POLICY_LIST>
		</BODY>
</PACKET>]]></arg0>
      </ws:channelMessageHandle>
   </soapenv:Body>
</soapenv:Envelope>