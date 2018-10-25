define("frontEnd/insure/carInfoADAS",function(require, exports, module){
	"use strict"; 
	var util = require("util");
	var datepicker = require("datepicker");
	var U = require("common/b2b.util");
	var a = _.Class.extend({
		construct: function(t) {
			this.init();
		},
		init: function() {
			this.initElements(),this.initEvent(),this.validator(),
			"10" in pageConfig.isdebug?this.test():void 0;
		},
		/**
		 * 初始化元素
		 */
		initElements: function() {
			var that = this;
			$(function(){
				datepicker({
					container:$("[name='vehDTO.installDate']"),
					maxDate:'+270D',
					minDate:'-100Y',
					//readOnly:true,
					dateFormat: 'yy-mm-dd',
					onSelect: function(dateText, inst) {
						$('#vehDTO\\.installDate').trigger("change");
					}
				});
				var appArray = new Array("44","32","51","41","13","14","62","37");
				console.log(deptCode);
				if($.inArray(deptCode,appArray) == '-1'){
					$('#vehDTO\\.cooPartner').children().get(1).remove();
				}
				if($('#vehDTO\\.procureMothed').val() == '4'){
					$('#proportion').attr('style','');
				}
			})
		},
		/**
		 * 初始化事件
		 */
		initEvent:function(){
			var that = this;
			$(function(){
				//置空函数
				function valueToEmpty(arrObj){
					$.each(arrObj, function(i, obj){
						$(obj).val('');
					});
				}
				//是否校验转换
				function requireSwitch(arrObj,isTrue){
					$.each(arrObj, function(i, obj){
						util.required($(obj),isTrue);
					});
				}
				var cooPartner = $('#vehDTO\\.cooPartner');//合作伙伴ID
				cooPartner.change(function(){
					//当合作伙伴为空时，其它字段同步置空
					if(cooPartner.val() == ""){
						var adasSonPutArr = $('#ADAS input');
						valueToEmpty(adasSonPutArr);
						var adasSonSelectArr = $('#ADAS select');
						valueToEmpty(adasSonSelectArr);
						requireSwitch($('#ADAS .a'),false);
					//当合作伙伴选择不为空时，设备状态、采购方式、设备型号、设备编号、初次安装日期字段均为必填项
					}else{
						$("#vehDTO\\.equipStatus").val('1');
						requireSwitch($('#ADAS .a'),true);
					}
				})
				//当采购方式选择“多方承担”时显示投保人承担比例、保险人承担比例、其他方承担比例
				var procureMothed = $('#vehDTO\\.procureMothed');//采购方式ID
				procureMothed.change(function(){
					if(procureMothed.val() == "4"){
						$('#proportion').attr('style','');
						/*requireSwitch($('#ADAS .b'),true);*/
					}else{
						$('#proportion').attr('style','display:none');
						valueToEmpty($('#ADAS .b'));
						requireSwitch($('#ADAS .b'),false);
					}
				})
				//投保人承担比例、保险人承担比例、其他方承担比例的输入值应该为0-100
				$.each($('#ADAS .b'),function(i, obj){
					$(obj).blur(function(){
						var digital = $(obj).val();
						if($(obj).val() != '' && $(obj).val() != null){
							if(parseFloat(digital)<0 || parseFloat(digital)>100){
								$(obj).val('')
								$.msg.alert('请输入0-100之间的数字！')
							}
						}
					})
				})
				$('#vehDTO\\.installDate').bind("blur",function(){
					var _t = $(this);
					if($(this).val()==""){
						return;
					}
					if(!U.isDate($(this).val())){
						$.msg.alert("初次安装日期格式错误！",function(){
							_t.focus();
						});
					}
				})
			})
		},
		validator:function(){
			var that = this;
			$.validator.addMethod("data-rule-commUndertakePercentage", function(value, element) {
				var sum = 0;
				var arrObj = $('#ADAS .b');
				$.each(arrObj, function(i, obj){
					if($(obj).val() != '' && $(obj).val() != null){
						 var figure = parseFloat($(obj).val());
						 sum = sum + figure;
					};
				});
				if($('#vehDTO\\.procureMothed').val()=='4' && sum != 100){
					return false;
				}else{
					$.each(arrObj, function(i, obj){
						util.required($(obj),false);
					});
					return true;
				}
			},function(value){
				return "合计承担比例必须为100%";
			});
		},
	})
	return a;
});