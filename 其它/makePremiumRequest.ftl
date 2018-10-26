<!--
	date:${.now?string("yyyy-MM-dd HH:mm:ss")}
	form:jscd
-->
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.channel.policy.pcis.isoftstone.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ws:channelMessageHandle>
         <arg0><![CDATA[<?xml version="1.0" encoding="GBK"?><PACKET type="REQUEST" version="1.0">
	    <HEAD>
	        <TRANS_TYPE>UB201</TRANS_TYPE>
	        <USER>${interface.username}</USER>
	        <PASSWORD>${interface.password}</PASSWORD>
	        <SERIALNO>${uuid}</SERIALNO>
	    </HEAD>
	    <BODY>
	        <POLICY_LIST>
	        	<#assign union = (makePremium?size > 1)><!--产品列表大于1算联合投保-->
	        	<#list makePremium as makePremium>
	        	<#assign isComm=false>
	        	<#assign isComp=false>
	        	<#if (makePremium.productComm && makePremium.productComm.coverage?size>0) >
	        		<#assign isComm=true>
	        	</#if>
	        	<#if (makePremium.productComp && makePremium.productComp.coverage?size>0) >
	        		<#assign isComp=true>
	        	</#if>
	            <POLICY_DATA>
	                <COMMON_PART>
	                	<#if isComm>
	                		<C_SEQUENCE_NO>${makePremium.productComm.code}</C_SEQUENCE_NO><!--请求次数-->
	                	</#if>
	                    <#if isComp>
	                		<C_SEQUENCE_NO>${makePremium.productComp.code}</C_SEQUENCE_NO><!--请求次数-->
	                	</#if>
	                </COMMON_PART>
	                <BASE_PART>
						<C_DPT_CDE>${makePremium.channelInfo.attributionOrg}</C_DPT_CDE><!--机构代码-->
						<C_OFFER_MRK>1</C_OFFER_MRK><!--报价标识-->
						<T_ISSUE_TM>${makePremium.channelInfo.signDate}</T_ISSUE_TM><!--投保日期-->
						<#if isComm >
							<C_PROD_NO>${makePremium.productComm.code}</C_PROD_NO><!--商业产品代码-->
							<C_IMMEFF_MRK>${makePremium.baseInfo.isNowFlagComm}</C_IMMEFF_MRK><!--即时生效-->
							<T_INSRNC_BGN_TM>${makePremium.baseInfo.startDateComm}</T_INSRNC_BGN_TM><!--保险起期-->
                            <T_INSRNC_END_TM>${makePremium.baseInfo.endDateComm}</T_INSRNC_END_TM><!--保险止期-->
                            <N_RATE_PRODUCT>${makePremium.baseInfo.productRate}</N_RATE_PRODUCT><!--自主核保与渠道系数乘积 +-->
                            <C_CALCULATION_FLAG>${makePremium.baseInfo.calculation_flag}</C_CALCULATION_FLAG><!--算费标识-->
                            <C_OFFER_NO>${makePremium.baseInfo.offerNoCommm}</C_OFFER_NO><!--报价单号商 -->
                            <C_APP_TYP>${makePremium.baseInfo.insuranceTypeComm}</C_APP_TYP><!-- 投保类型-->
						<#elseif isComp >
							<C_PROD_NO>${makePremium.productComp.code}</C_PROD_NO><!--交强产品代码-->
							<C_IMMEFF_MRK>${makePremium.baseInfo.isNowFlagComp}</C_IMMEFF_MRK><!--即时生效-->
							<T_INSRNC_BGN_TM>${makePremium.baseInfo.startDateComp}</T_INSRNC_BGN_TM><!--保险起期-->
                            <T_INSRNC_END_TM>${makePremium.baseInfo.endDateComp}</T_INSRNC_END_TM><!--保险止期-->
                            <C_OFFER_NO>${makePremium.baseInfo.offerNoCommp}</C_OFFER_NO><!--报价单号交-->
                            <C_APP_TYP>${makePremium.baseInfo.insuranceTypeComp}</C_APP_TYP><!-- 投保类型-->
                            <#if makePremium.baseInfo.handWorkNo >
								<C_MANUAL_MRK>1</C_MANUAL_MRK> <!-- 补录  0:否  1:是 -->
								<C_PRN_NO>${makePremium.baseInfo.handWorkNo}</C_PRN_NO><!-- 单证号 -->
							<#else>
								<C_MANUAL_MRK>0</C_MANUAL_MRK> <!-- 补录  0:否  1:是 -->
							</#if>
						</#if>
						<C_BSNS_TYP>${makePremium.channelInfo.businessType}</C_BSNS_TYP><!--业务来源-->
						<C_OPR_CDE>${makePremium.channelInfo.operatorCode}</C_OPR_CDE><!--操作员-->
						<C_SALE_NME>${makePremium.channelInfo.seller}</C_SALE_NME><!--销售员-->
						<C_SLS_CDE>${makePremium.channelInfo.salesmanNo}</C_SLS_CDE><!--业务员工号-->
						<C_SLS_NME>${makePremium.channelInfo.saleMan}</C_SLS_NME><!--业务员姓名-->
						<C_BRKR_CDE>${makePremium.channelInfo.agtagrNo}</C_BRKR_CDE><!--代理人-代理机构-->
						<C_AGENCY_CDE>${makePremium.channelInfo.agtagrNo}</C_AGENCY_CDE><!--中介机构代码-->
						<C_AGT_AGR_NO>${makePremium.channelInfo.agencyTocol}</C_AGT_AGR_NO><!--代理协议号-->
						<N_CHANGE_RATE></N_CHANGE_RATE><!--调整系数 +-->
						<C_SERVICE_CODE>${makePremium.channelInfo.coopBranch}</C_SERVICE_CODE><!--服务代码-->
						<#if union >
							<C_MULTI_APP_FLAG>2</C_MULTI_APP_FLAG><!--联合投保标识-->
						<#else>
							<C_MULTI_APP_FLAG>0</C_MULTI_APP_FLAG><!--联合投保标识-->
						</#if>
						<C_DISPT_STTL_ORG>${makePremium.channelInfo.arbitrationInstitution}</C_DISPT_STTL_ORG><!--仲裁机构-->
						<#if makePremium.vehicleInfo.usageCde == "309005" || makePremium.vehicleInfo.usageCde == "309041">
							<C_PROD_TYPE>0102</C_PROD_TYPE><!--产品体系代码-->
						<#elseif makePremium.vehicleInfo.usageCde == "309008" ||  makePremium.vehicleInfo.usageCde == "309009">
							<C_PROD_TYPE>0103</C_PROD_TYPE><!--产品体系代码-->
						<#else>
							<C_PROD_TYPE>0101</C_PROD_TYPE><!--产品体系代码-->
						</#if>
						<C_PLY_DPT_CDE>${makePremium.channelInfo.attributionOrg}</C_PLY_DPT_CDE><!--保单归属地-->
						<C_APPOINT_AREA_CDE>110000</C_APPOINT_AREA_CDE><!--指定查询地区代码 110000-->
						<C_OFFER_PLAN>${makePremium.baseInfo.offer_plan}</C_OFFER_PLAN><!-- 报价方案-->
						<C_SYSTEM_FLAG>J</C_SYSTEM_FLAG><!--渠道一级代码-->
						<C_DISP_STTL_CODE>${makePremium.channelInfo.disputeResolution}</C_DISP_STTL_CODE><!--争议处理-->
						<N_OFFLINE_NCD></N_OFFLINE_NCD><!--离线出单ncd系数 1.0-->
						<C_CONTI_OFFER_MRK></C_CONTI_OFFER_MRK><!--是否继续报价-->
						<C_BRKR_NME>${makePremium.channelInfo.agtagrName}</C_BRKR_NME><!--代理人名称-->
						<N_COMM_ADD_TAX_RATE>0.06</N_COMM_ADD_TAX_RATE><!--进项增值税率-->
						<C_THIRD_BUSSINESS>0</C_THIRD_BUSSINESS><!--是否第三方平台 默认否1-->
						<C_RECORD_CODE></C_RECORD_CODE><!--第三方平台备案代码-->
						<C_COMPUTER_IP>${makePremium.channelInfo.computer_ip}</C_COMPUTER_IP><!--出单点计算机ip地址-->
						<C_USB_KEY></C_USB_KEY><!--数字证书（USBKEY）-->
						<C_AGANT_PER></C_AGANT_PER><!--代理业务审批人-->
						<C_SLS_ID></C_SLS_ID><!--经办人-->
						<C_POS_NO></C_POS_NO><!--Pos机具编号-->
						<N_BUSINESS_INSUR_SE>${makePremium.baseInfo.salesExpenses}</N_BUSINESS_INSUR_SE><!--商业险SE-->
						<C_CI_MRK>0</C_CI_MRK><!--共保标识-->
						<C_CRIFAC_MRK>0</C_CRIFAC_MRK><!--临分标识-->
						<C_CHA_SUBTYPE>JSCD</C_CHA_SUBTYPE><!-- 渠道二级编码 -->
						<#-- 1、联合投保 2、单交强 3、单商业 4、交联商 5、商联交 -->
						<#if union >
							<C_UNION_SJ_MRK>1</C_UNION_SJ_MRK><!-- 交商同保标志 -->
						<#else>
							<#if isComp>
								<C_UNION_SJ_MRK>2</C_UNION_SJ_MRK><!-- 交商同保标志 -->
							</#if>
							<#if isComm>
								<C_UNION_SJ_MRK>3</C_UNION_SJ_MRK><!-- 交商同保标志 -->
							</#if>
						</#if>
						<C_POLICY_MRK></C_POLICY_MRK><!-- 是否为政策性农机保险 0:否  1:是  -->
						<N_PROV_SUBSIDY_RATE></N_PROV_SUBSIDY_RATE><!-- 省财政补贴比例（%） -->
						<N_CITY_SUBSIDY_RATE></N_CITY_SUBSIDY_RATE><!-- 市财政补贴比例（%） -->
						<N_COUNTY_SUBSIDY_RATE></N_COUNTY_SUBSIDY_RATE><!-- 县（区）财政补贴比例（%） -->
						<N_FARMER_RATE></N_FARMER_RATE><!-- 农户缴费比例（%） -->
					</BASE_PART>
	               	<VHL_INFO>
						<C_PLATE_NO>${makePremium.vehicleInfo.plateNo}</C_PLATE_NO><!--车牌号码-->
						<C_PLATE_TYP>${makePremium.vehicleInfo.plateTyp}</C_PLATE_TYP><!--号牌种类-->
						<#if makePremium.vehicleInfo.insuredManyYears == '1'>
							<C_NEW_MRK>1</C_NEW_MRK><!--是否新车-->
						<#else>
							<C_NEW_MRK>${makePremium.vehicleInfo.newVehicleFlag}</C_NEW_MRK><!--是否新车-->
						</#if>
						
						<C_NEW_VHL_FLAG>${makePremium.vehicleInfo.newVhlFlag}</C_NEW_VHL_FLAG><!--是否上牌-->
						<C_TRANSFER_MRK>${makePremium.vehicleInfo.changeOwnerFlag}</C_TRANSFER_MRK><!--是否过户-->
						<C_ECDEMIC_MRK>${makePremium.vehicleInfo.ecdemicVehicleFlag}</C_ECDEMIC_MRK><!--是否外地车-->
						<T_FST_REG_YM>${makePremium.vehicleInfo.fstRegYm}</T_FST_REG_YM><!--车辆初登日期-->
						<C_ENG_NO>${makePremium.vehicleInfo.engNo}</C_ENG_NO><!--发动机号-->
						<C_FRM_NO>${makePremium.vehicleInfo.frmNo}</C_FRM_NO><!--车架号-->
						<C_VIN>${makePremium.vehicleInfo.vin}</C_VIN><!--VIN码-->
						<C_PLATE_COLOR>${makePremium.vehicleInfo.plateColor}</C_PLATE_COLOR><!--车牌颜色-->
						<C_USE_YEAR>${makePremium.vehicleInfo.useYears}</C_USE_YEAR><!--车龄-->
						<N_YEAR_CAR_MILES></N_YEAR_CAR_MILES><!--平均年行驶里程-->
						<C_TRAVEL_AREA_CDE>${makePremium.vehicleInfo.runareacode}</C_TRAVEL_AREA_CDE><!--行驶区域-->
						<C_VEHICLE_MODEL>${makePremium.vehicleInfo.noticeType}</C_VEHICLE_MODEL><!--车辆型号(公告型号)-->
						<C_VEHICLE_BRAND>${makePremium.vehicleInfo.carBrand}</C_VEHICLE_BRAND><!--车辆品牌-->
						<C_NAT_OF_BUSINES>${makePremium.vehicleInfo.businessType}</C_NAT_OF_BUSINES><!--营业性质-->
						<C_REFINE_MODEL>${makePremium.vehicleInfo.refinedCarModel}</C_REFINE_MODEL><!--细化车型-->
						<C_USAGE_CDE>${makePremium.vehicleInfo.usageCde}</C_USAGE_CDE><!--车辆性质-->
						<#if isComm >
							<C_VHL_TYP>${makePremium.vehicleInfo.vhlTyp}</C_VHL_TYP><!--车辆类型-->
							<C_TFI_SPECIAL_MRK>${makePremium.vehicleInfo.tfiSpecialMrk}</C_TFI_SPECIAL_MRK><!--特殊车投保标志-->
							<N_CAR_AGE>${makePremium.vehicleInfo.carAge}</N_CAR_AGE><!--车龄等级-->
						</#if>
						<#if isComp >
							<C_VHL_TYP>${makePremium.vehicleInfo.vhlTypComp}</C_VHL_TYP><!--车辆类型-->
							<C_TFI_SPECIAL_MRK>${makePremium.vehicleInfo.tfiSpecialMrkComp}</C_TFI_SPECIAL_MRK><!--特殊车投保标志-->
							<N_CAR_AGE>${makePremium.vehicleInfo.carAgeComp}</N_CAR_AGE><!--车龄等级-->
						</#if>
						<C_MFG_YEAR></C_MFG_YEAR><!--制造年份-->
						<N_LIMIT_LOAD_PERSON>${makePremium.vehicleInfo.limitLoadPerson}</N_LIMIT_LOAD_PERSON><!--核定载客数-->
						<N_DISPLACEMENT_LVL>${makePremium.vehicleInfo.power}</N_DISPLACEMENT_LVL><!--功率-->
						<N_TONAGE>${makePremium.vehicleInfo.tonnage?number / 1000}</N_TONAGE><!--核定载质量 吨 -->
						<N_DISPLACEMENT>${makePremium.vehicleInfo.displacement?number / 1000}</N_DISPLACEMENT><!--排量 升-->
						<#if makePremium.channelInfo.attributionOrg?starts_with('11')>
							<N_PO_WEIGHT>${makePremium.vehicleInfo.vehicleQuality?number / 1000}</N_PO_WEIGHT><!--整备质量-->
						<#else>
							<N_PO_WEIGHT>${makePremium.vehicleInfo.vehicleQuality?number / 1000}</N_PO_WEIGHT><!--整备质量 吨-->
						</#if>
						<C_NEW_PURCHASE_VALUE>${makePremium.vehicleInfo.newPurchaseValue}</C_NEW_PURCHASE_VALUE><!--新车购置价-->
						<C_FUEL_TYPE>${makePremium.vehicleInfo.fuelType}</C_FUEL_TYPE><!--能源种类-->
						<C_MODEL_CDE>${makePremium.vehicleInfo.modelCde}</C_MODEL_CDE><!--车型代码-->
						<C_MODEL_NME>${makePremium.vehicleInfo.curModelNme}</C_MODEL_NME><!--车型名称 打印厂牌型号-->
						<C_PROD_PLACE>${makePremium.vehicleInfo.importType}</C_PROD_PLACE><!--国产/进口-->
						<C_BODY_COLOR>${makePremium.vehicleInfo.bodyColor}</C_BODY_COLOR><!--车身颜色-->
						<C_MON_DESP_RATE>${makePremium.vehicleInfo.coefficientRate}</C_MON_DESP_RATE><!--月折旧率-->
						<C_REG_DRI_TYP>${makePremium.vehicleInfo.vehicleType}</C_REG_DRI_TYP><!--行驶证车辆类型-->
						<C_REG_VHL_TYP>${makePremium.vehicleInfo.poCategory}</C_REG_VHL_TYP><!--交管车辆类型-->
						<C_LOAN_VEHICLE_FLAG>${makePremium.vehicleInfo.insuredManyYears}</C_LOAN_VEHICLE_FLAG><!--车贷投保多年-->
						<C_FLEET_MRK>${makePremium.policyHolder.motorcadeSign}</C_FLEET_MRK><!--车队标志-->
						<C_VHL_PKG_NO>${makePremium.policyHolder.motorcadeNumber}</C_VHL_PKG_NO><!--车队号-->
						<C_GLASS_TYP>${makePremium.vehicleInfo.glassTyp}</C_GLASS_TYP><!--玻璃类型-->
						<T_TRANSFER_DATE>${makePremium.vehicleInfo.registrationTransferedDate}</T_TRANSFER_DATE><!--转移登记日期-->
						<C_CARD_DETAIL>${makePremium.vehicleInfo.poCategory}</C_CARD_DETAIL><!--行驶证车辆类型明细-->
						<C_CHANGE></C_CHANGE><!--是否改装-->
						<C_POWER_TYPE>${makePremium.vehicleInfo.powerType}</C_POWER_TYPE><!--动力类型-->
						<#if isComp>
							<N_OF_PROV_NUM>${makePremium.rateComp.noClaimsOfProve}</N_OF_PROV_NUM><!--跨省投保未出险次数-->
						<#else>
							<N_OF_PROV_NUM></N_OF_PROV_NUM><!--跨省投保未出险次数-->
						</#if>
						<N_ACTUAL_VALUE>${makePremium.vehicleInfo.actualValue}</N_ACTUAL_VALUE><!--车辆实际价值-->
						<T_START_DATE>${makePremium.vehicleInfo.certDate}</T_START_DATE><!--发证日期-->
						<C_MODEL_CODE>${makePremium.vehicleInfo.ciModelCode}</C_MODEL_CODE><!--行业车型编码-->
						<C_CAR_NAME>${makePremium.vehicleInfo.carName}</C_CAR_NAME><!--车款名称-->
						<N_DISCUS_USEVAL>${makePremium.vehicleInfo.negotiatedActualValue}</N_DISCUS_USEVAL><!--协商确定的机动车使用价值-->
						<T_POLI_FIND_DATE></T_POLI_FIND_DATE><!--公安机关找回证明日期-->
						<C_REF_CODE1>${makePremium.vehicleInfo.modelCde}</C_REF_CODE1><!--车型参考代码1-->
						<C_REF_CODE2>${makePremium.vehicleInfo.modelCde2}</C_REF_CODE2><!--车型参考代码2-->
						<C_SEARCH_CODE></C_SEARCH_CODE><!--车型查询码-->
						<C_PAY_LOAN>0</C_PAY_LOAN><!--是否未还清贷款-->
					</VHL_INFO>
	                <VHLOWNER>
						<C_OWNER_NME>${makePremium.vehicleInfo.owner}</C_OWNER_NME><!--车主-->
						<C_CERTF_CLS>${makePremium.vehicleInfo.certfCls}</C_CERTF_CLS><!--证件类型-->
						<C_CERTF_CDE>${makePremium.vehicleInfo.certfCde}</C_CERTF_CDE><!--证件号码-->
						<C_COWNER_TYP>${makePremium.vehicleInfo.carOwnertype}</C_COWNER_TYP><!-- 车主性质 -->
						<C_OWNER_SEX>${makePremium.vehicleInfo.ownerGender}</C_OWNER_SEX><!--车主性别-->
						<C_AGE_LVL>${makePremium.vehicleInfo.ownerAgeLvl}</C_AGE_LVL><!-- 车主年龄档次-->
						<N_OWNER_AGE>${makePremium.vehicleInfo.ownerAge}</N_OWNER_AGE><!--车主年龄-->
						<C_CLNT_MRK>${makePremium.vehicleInfo.ownerClntMrk}</C_CLNT_MRK> <!-- 车主类型 -->
					</VHLOWNER>
					<POLICYHOLDER>
						<C_INSURED_NME>${makePremium.policyHolder.appName}</C_INSURED_NME><!--投保人名称-->
						<C_CLNT_MRK>${makePremium.policyHolder.appClntMrk}</C_CLNT_MRK><!--客户类型-->
						<C_CUS_TYP>${makePremium.policyHolder.appCusType}</C_CUS_TYP><!--客户分类-->
					</POLICYHOLDER>
					<INSURED>
						<C_INSURED_NME>${makePremium.insured.insuredName}</C_INSURED_NME>
						<C_CLNT_MRK>${makePremium.insured.insuredClntMrk}</C_CLNT_MRK>
						<C_CERT_NO>${makePremium.insured.insuredCertfCode}</C_CERT_NO>
						<C_CLNT_ADDR>${makePremium.insured.insuredAddr}</C_CLNT_ADDR>
					</INSURED>
					<CVRG_LIST>
				<#if isComm >
					<#assign coverageAmount = 0>
					<#list makePremium.productComm.coverage as cvrg>
						<#if (cvrg.coverageCode == "02")>
							<#assign coverageAmount = cvrg.coverageAmount>
							<#if (makePremium.channelInfo.attributionOrg && makePremium.channelInfo.attributionOrg?substring(0,2) == "31")>
								<#assign coverageAmount = (cvrg.coverageAmount?number * 2)?string("#.##")>
							</#if>
						</#if>
						<CVRG_INFO>
							<N_SEQ_NO>${cvrg.coverageSeq}</N_SEQ_NO> <!--序号-->
							<#if (cvrg.coverageCode?starts_with('00') && cvrg.coverageCode?length gt 2)>
								<C_CVRG_NO>0362${cvrg.coverageCode?substring(1)}</C_CVRG_NO> <!--险别代码-->
							<#else>
								<C_CVRG_NO>0360${cvrg.coverageCode}</C_CVRG_NO> <!--险别代码-->
							</#if>
							<#if (cvrg.coverageCode == "38")>
								<N_AMT>${coverageAmount}</N_AMT> <!--保额-->
							<#else>
								<N_AMT>${cvrg.coverageAmount}</N_AMT> <!--保额-->
							</#if>
							<N_AMT_PER>${cvrg.unitInsured}</N_AMT_PER> <!--每座限额-->
							<N_LIAB_DAYS_LMT>${cvrg.coverageNumber}</N_LIAB_DAYS_LMT> <!--承保座位数-->
							<T_INSRNC_BGN_TM>${makePremium.baseInfo.startDateComm}</T_INSRNC_BGN_TM> <!--保险起期-->
							<T_INSRNC_END_TM>${makePremium.baseInfo.endDateComm}</T_INSRNC_END_TM> <!--保险止期-->
							<C_GLASS_TYPE>${cvrg.glassType}</C_GLASS_TYPE> <!--玻璃类型-->
							<N_COMPEN_LIM_DAY>${cvrg.coverageNumber}</N_COMPEN_LIM_DAY> <!--最高赔偿天数-->
							<N_COMPEN_DAY_AMT>${cvrg.unitInsured}</N_COMPEN_DAY_AMT> <!--日补偿金额-->
							<#if cvrg.coverageCode=="06">
								<C_SPECGLASS_MRK>${cvrg.specglassMrk}</C_SPECGLASS_MRK> <!--防弹玻璃标志-->
							<#else>
								<C_SPECGLASS_MRK></C_SPECGLASS_MRK> <!--防弹玻璃标志-->
							</#if>
							<N_RATE>${cvrg.coverageRate}</N_RATE> <!--费率-->
							<N_DEDUCTIBLE>${cvrg.deductible}</N_DEDUCTIBLE> <!--绝对免赔额-->
							<C_IS_NEW_EQUIPMENT>${cvrg.isNewEquipment}</C_IS_NEW_EQUIPMENT> <!--是否新增设备-->
							<#if cvrg.coverageCode=="001">
								<N_NEW_EQUIPMENT_AMT>${cvrg.coverageRemark}</N_NEW_EQUIPMENT_AMT> <!--新增设备保额-->
								<C_DDUCTRATE_LVL></C_DDUCTRATE_LVL> <!--绝对免赔率-->
							<#elseif cvrg.coverageCode=="002">
								<N_NEW_EQUIPMENT_AMT></N_NEW_EQUIPMENT_AMT> <!--新增设备保额-->
								<C_DDUCTRATE_LVL>${cvrg.coverageRemark}</C_DDUCTRATE_LVL> <!--绝对免赔率-->
							<#else>
								<N_NEW_EQUIPMENT_AMT></N_NEW_EQUIPMENT_AMT> <!--新增设备保额-->
								<C_DDUCTRATE_LVL></C_DDUCTRATE_LVL> <!--绝对免赔率-->
							</#if>
						</CVRG_INFO>
					</#list>
				</#if>
				<#if isComp >
					<#list makePremium.productComp.coverage as cvrg>
						<CVRG_INFO>
							<N_SEQ_NO>${cvrg.coverageSeq}</N_SEQ_NO> <!--序号-->
							<C_CVRG_NO>0332${cvrg.coverageCode}</C_CVRG_NO> <!--险别代码-->
							<N_AMT>${cvrg.coverageAmount}</N_AMT> <!--保额-->
							<N_AMT_PER>${cvrg.unitInsured}</N_AMT_PER> <!--每座限额-->
							<N_LIAB_DAYS_LMT>${cvrg.coverageNumber}</N_LIAB_DAYS_LMT> <!--承保座位数-->
							<T_INSRNC_BGN_TM>${makePremium.baseInfo.startDateComp}</T_INSRNC_BGN_TM> <!--保险起期-->
							<T_INSRNC_END_TM>${makePremium.baseInfo.endDateComp}</T_INSRNC_END_TM> <!--保险止期-->
							<C_GLASS_TYPE>${cvrg.glassType}</C_GLASS_TYPE> <!--玻璃类型-->
							<N_COMPEN_LIM_DAY>${cvrg.coverageNumber}</N_COMPEN_LIM_DAY> <!--最高赔偿天数-->
							<N_COMPEN_DAY_AMT>${cvrg.unitInsured}</N_COMPEN_DAY_AMT> <!--日补偿金额-->
							<C_SPECGLASS_MRK>${cvrg.glassType}</C_SPECGLASS_MRK> <!--防弹玻璃标志-->
							<N_RATE>${cvrg.coverageRate}</N_RATE> <!--费率-->
							<N_DEDUCTIBLE>${cvrg.deductible}</N_DEDUCTIBLE> <!--绝对免赔额-->
						</CVRG_INFO>
					</#list>
				</#if>
					</CVRG_LIST>
					<#if isComp >
					<TAX_INFO>
						<#if makePremium.channelInfo.attributionOrg?starts_with('12')>
							<C_VS_TAX_MRK>${makePremium.vehicleTax.taxMrk}</C_VS_TAX_MRK><!--车船税标志 -->
							<C_PAYTAX_TYP>${makePremium.vehicleTax.taxCurrentType}</C_PAYTAX_TYP><!--纳税类型 -->
							<C_TAX_ITEM_CDE>${makePremium.vehicleTax.taxStandard}</C_TAX_ITEM_CDE><!--税目 -->
							<C_TAXPAYER_CERT_TYP>${makePremium.vehicleTax.idType}</C_TAXPAYER_CERT_TYP><!--纳税人证件类型-->
							<C_TAXPAYER_CERT_NO>${makePremium.vehicleTax.taxpayerCertNo}</C_TAXPAYER_CERT_NO><!--纳税人证件号码 -->
							<C_TAXPAYER_ID>${makePremium.vehicleTax.taxpayerNo}</C_TAXPAYER_ID><!--纳税人识别号 -->
							<N_TAXABLE_MONTHS>${makePremium.vehicleTax.taxableMonths}</N_TAXABLE_MONTHS><!--当年应缴应纳税月-->
							<C_TAXPAYER_ADDR>${makePremium.vehicleTax.taxpayerAddress}</C_TAXPAYER_ADDR><!--纳税人地址 -->
							<N_CURB_WT>${makePremium.vehicleTax.vehicleQuality?number / 1000}</N_CURB_WT><!--整备质量 吨-->
							<T_BILL_DATE>${makePremium.vehicleInfo.buyCarDate}</T_BILL_DATE><!--新车发票购买日期 -->
							<#if makePremium.vehicleTax.displacement != ''>
								<N_EXHAUST_CAPACITY>${makePremium.vehicleTax.displacement?number / 1000}</N_EXHAUST_CAPACITY><!--排量 升-->
							<#else>
								<N_EXHAUST_CAPACITY>0</N_EXHAUST_CAPACITY><!--排量 升-->
							</#if>
							<C_TAX_BELONG_TM>${makePremium.vehicleTax.taxPeriod}</C_TAX_BELONG_TM><!--税款所属期 -->
							<C_TAX_VCH_NO>${makePremium.vehicleTax.taxNum}</C_TAX_VCH_NO><!--税票号 -->
							<C_TAX_VCH_TYP>${makePremium.vehicleTax.taxType}</C_TAX_VCH_TYP><!--税票号码类型 -->
							<C_TRANSFER_CAR_MRK>1</C_TRANSFER_CAR_MRK><!--是否外地转籍车 -->
							<T_TRANSFER_DATE></T_TRANSFER_DATE>
							<C_PAY_TAX_MRK>${makePremium.vehicleTax.taxKo}</C_PAY_TAX_MRK><!-- 是否完税 -->
							<C_PAY_TAX_FLAG>${makePremium.vehicleTax.taxKo}</C_PAY_TAX_FLAG><!--已完税标志 -->
							<C_BRAND_NAME>${makePremium.vehicleTax.brandName}</C_BRAND_NAME><!--车辆品牌 -->
							<C_MODEL_CODE>${makePremium.vehicleTax.modelCode}</C_MODEL_CODE><!--车辆型号 车型代码 -->
							<C_ABATE_MRK>${makePremium.vehicleTax.abateMrk}</C_ABATE_MRK><!--是否减税 否-->
							<C_TAX_RELIEF_CERT_NO>${makePremium.vehicleTax.reduceNo}</C_TAX_RELIEF_CERT_NO><!--减免税证明号 -->
							<C_TAXITEM_CDE>${makePremium.vehicleTax.taxRegNumber}</C_TAXITEM_CDE><!--税务登记证号 -->
						<#else>
							<C_PAYTAX_TYP>${makePremium.vehicleTax.taxCurrentType}</C_PAYTAX_TYP><!--纳税类型 -->
							<C_TAX_SIGN>${makePremium.vehicleTax.taxesFlag}</C_TAX_SIGN><!--缴纳税款标志 -->
							<C_TAX_ITEM_CDE>${makePremium.vehicleTax.taxStandard}</C_TAX_ITEM_CDE><!--税目 -->
							<C_TAXPAYER_NME>${makePremium.vehicleTax.taxPayerName}</C_TAXPAYER_NME><!--纳税人名称 -->
							<C_TAXPAYER_CERT_NO>${makePremium.vehicleTax.taxpayerCertNo}</C_TAXPAYER_CERT_NO><!--纳税人证件号码 -->
							<C_TAXPAYER_ID>${makePremium.vehicleTax.taxpayerNo}</C_TAXPAYER_ID><!--纳税人识别号 -->
							<#if (makePremium.vehicleTax.taxCurrentType=='C')>
								<C_ABATE_MRK>001</C_ABATE_MRK><!--是否减税 是-->
							<#else>
								<C_ABATE_MRK>002</C_ABATE_MRK><!--是否减税 否-->
							</#if>
							<C_ABATE_RSN>${makePremium.vehicleTax.taxReduceRsn}</C_ABATE_RSN><!--减免税原因 -->
							<C_FREE_TYPE>${makePremium.vehicleTax.taxReduceType}</C_FREE_TYPE><!--减免税方案 -->
							<C_TAX_RELIEF_CERT_NO>${makePremium.vehicleTax.reduceNo}</C_TAX_RELIEF_CERT_NO><!--减免税证明号 -->
							<N_ABATE_AMT>${makePremium.vehicleTax.taxFreeAmount}</N_ABATE_AMT><!--减税金额 -->
							<N_ABATE_PROP>${makePremium.vehicleTax.taxReduceProp}</N_ABATE_PROP><!--减税比例 -->
							<#if makePremium.channelInfo.attributionOrg?starts_with('11')>
								<N_CURB_WT>${makePremium.vehicleTax.vehicleQuality?number / 1000}</N_CURB_WT><!--整备质量 -->
							<#else>
								<N_CURB_WT>${makePremium.vehicleTax.vehicleQuality?number / 1000}</N_CURB_WT><!--整备质量 -->
							</#if>
							<C_LAST_TAX_YEAR>${makePremium.vehicleTax.lastPaidYear}</C_LAST_TAX_YEAR><!--前次纳税年度 -->
							<C_LAST_SALI_END_DATE>${makePremium.vehicleTax.payLastEndDate}</C_LAST_SALI_END_DATE><!--前次交强险截止日期-->
							<T_DECLEARE_DATE>${.now?string("yyyy-MM-dd")}</T_DECLEARE_DATE><!--纳税申报日期 -->
							<C_VS_TAX_MRK>${makePremium.vehicleTax.taxMrk}</C_VS_TAX_MRK><!--车船税标志 -->
							<T_CERTIFICATE_DATE></T_CERTIFICATE_DATE><!--发证日期 -->
							<N_CHARGE_PROP></N_CHARGE_PROP><!--手续费比例 -->
							<N_TAXABLE_MONTHS>${makePremium.vehicleTax.taxableMonths}</N_TAXABLE_MONTHS><!--当年应缴应纳税月-->
							<C_TAXPAYER_ADDR>${makePremium.vehicleTax.taxpayerAddress}</C_TAXPAYER_ADDR><!--纳税人地址 -->
							<C_TAXPAYER_CERT_TYP>${makePremium.vehicleTax.idType}</C_TAXPAYER_CERT_TYP><!--纳税人证件类型-->
							<T_BILL_DATE>${makePremium.vehicleInfo.buyCarDate}</T_BILL_DATE><!--新车发票购买日期 -->
							<N_EXHAUST_CAPACITY>${makePremium.vehicleInfo.displacement?number / 1000}</N_EXHAUST_CAPACITY><!--排量（北京） -->
							<N_LAST_YEAR_TAXABLE_MONTHS>${makePremium.vehicleTax.taxableMonthsLast}</N_LAST_YEAR_TAXABLE_MONTHS><!--往年应缴月份数 -->
							<T_TAX_EFF_BGN_TM>${makePremium.vehicleTax.taxPeriodStart}</T_TAX_EFF_BGN_TM> <!--税款所属起期 -->
							<T_TAX_EFF_END_TM>${makePremium.vehicleTax.taxPeriodEnd}</T_TAX_EFF_END_TM> <!--税款所属止期 -->
							<N_OVERDUE_DAYS></N_OVERDUE_DAYS><!--滞纳天数 -->
							<C_DRAWBACK_OPR>${makePremium.vehicleTax.drawbackOpr}</C_DRAWBACK_OPR><!--是否修改往年应缴-->
							<N_OVERDUE_AMT></N_OVERDUE_AMT><!--滞纳金 -->
							<C_COM_TAX_ORG>${makePremium.vehicleTax.taxDepartmentName}</C_COM_TAX_ORG><!--本地车开具税务机-->
							<C_TAX_BELONG_TM>${makePremium.vehicleTax.taxPeriod}</C_TAX_BELONG_TM><!--税款所属期 -->
							<C_TAX_VCH_NO>${makePremium.vehicleTax.reduceNo}</C_TAX_VCH_NO><!--税票号 -->
							<C_TAX_VCH_TYP></C_TAX_VCH_TYP><!--税票号码类型 -->
							<C_TRANSFER_CAR_MRK>${makePremium.vehicleInfo.ecdemicVehicleFlag}</C_TRANSFER_CAR_MRK><!--是否外地转籍车 -->
							<T_TRANSFER_DATE>${makePremium.vehicleInfo.registrationTransferedDate}</T_TRANSFER_DATE><!--转籍时间 -->
							<C_BRAND_NAME>${makePremium.vehicleInfo.carBrand}</C_BRAND_NAME><!--车辆品牌 -->
							<C_MODEL_CODE>${makePremium.vehicleInfo.modelCde}</C_MODEL_CODE><!--车辆型号 车型代码 -->
							<C_TAXITEM_CDE>${makePremium.vehicleTax.taxRegNumber}</C_TAXITEM_CDE><!--税务登记证号 -->
							<C_PAY_ID>${makePremium.vehicleTax.payTaxFlag}</C_PAY_ID><!--完税标识（缴税方）-->
							<C_TAX_ORG_NOLOCAL>${makePremium.vehicleTax.departmentNonlocal}</C_TAX_ORG_NOLOCAL><!--外地车开具税务机关名称-->
							<C_PAY_TAX_FLAG>${makePremium.vehicleTax.taxKo}</C_PAY_TAX_FLAG><!--已完税标志 -->
							<#if (makePremium.vehicleTax.taxKo=='1')>
								<C_PAY_TAX_MRK>1</C_PAY_TAX_MRK><!--是否完税 是 -->
							<#else>
								<C_PAY_TAX_MRK>0</C_PAY_TAX_MRK><!--是否完税 否-->
							</#if>
							<C_TAX_PAYMENT_RECPT_NO>${makePremium.vehicleTax.payNo}</C_TAX_PAYMENT_RECPT_NO><!--完税凭证号 -->
						</#if>
					</TAX_INFO>	
					</#if>
					<#if makePremium.reinsuranceComm && isComm >
						<CHKDATA>
							<C_CHECK_STATUS>${makePremium.reinsuranceComm.check_status}</C_CHECK_STATUS>
							<C_QUERY_CDE>${makePremium.reinsuranceComm.query_cde}</C_QUERY_CDE>
							<C_CHECK_QUESTION>${makePremium.reinsuranceComm.check_question}</C_CHECK_QUESTION>
							<C_USER_CODE>${makePremium.reinsuranceComm.check_answer}</C_USER_CODE>
						</CHKDATA>
					</#if>
					<#if makePremium.reinsuranceComp && isComp>
						<CHKDATA>
							<C_CHECK_STATUS>${makePremium.reinsuranceComp.check_status}</C_CHECK_STATUS>
							<C_QUERY_CDE>${makePremium.reinsuranceComp.query_cde}</C_QUERY_CDE>
							<C_CHECK_QUESTION>${makePremium.reinsuranceComp.check_question}</C_CHECK_QUESTION>
							<C_USER_CODE>${makePremium.reinsuranceComp.check_answer}</C_USER_CODE>
						</CHKDATA>
					</#if>
	            </POLICY_DATA>
	        	</#list>
	        </POLICY_LIST>
	    </BODY>
</PACKET>]]></arg0>
      </ws:channelMessageHandle>
   </soapenv:Body>
</soapenv:Envelope>