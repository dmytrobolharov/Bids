<%@ Page Language="vb" AutoEventWireup="false" Codebehind="month_popup.aspx.vb" Inherits="plmOnApp.Month_Popup" %>
<%@ Register TagPrefix="ysmonthview" Namespace="YSMonthView" Assembly="YSMonthView" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
	 <title runat="server" id="PageTitle"></title>
		
		<meta content="Microsoft Visual Studio.NET 7.0" name="GENERATOR">
		<meta content="Visual Basic 7.0" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script language="javascript"> 
		
		function ShowDateSelected(sDate,sTxtBox) 
		{
		opener.document.Form1[sTxtBox].value = sDate;
		self.close();
		}
		
		</script>
		<style type="text/css">
			.MonthView {
				FONT-SIZE: 9pt; COLOR: #000000; FONT-FAMILY: arial
			}
			A.MonthView:link {
				FONT-SIZE: 9pt; COLOR: #000000; FONT-FAMILY: arial; TEXT-DECORATION: none
			}
			A.MonthView:visited {
				FONT-SIZE: 9pt; COLOR: #000000; FONT-FAMILY: arial; TEXT-DECORATION: none
			}
			A.MonthView:hover {
				FONT-SIZE: 9pt; BACKGROUND: #808080; COLOR: #ffffff; FONT-FAMILY: arial; TEXT-DECORATION: none
			}
		</style>
	</HEAD>
	<body bgColor="whitesmoke" onLoad="self.focus();"> 
		<form id="Form1" method="post" runat="server">
			<YSMONTHVIEW:YSMONTHVIEW id="MonthView" runat="server" ShowToday="True"></YSMONTHVIEW:YSMONTHVIEW></form>
	</body>
</HTML>
