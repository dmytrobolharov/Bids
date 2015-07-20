<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_PredefinedSampleTechPack_Add.aspx.vb" Inherits="plmOnApp.Control_PredefinedSampleTechPack_Add" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Add Workflow Type</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <style>
            #lstSelect::-webkit-scrollbar { width: 0 !important }
            #lstSelected::-webkit-scrollbar { width: 0 !important }
            #lstSelect{overflow: hidden; -ms-overflow-style: none; overflow: -moz-scrollbars-none;}
            #lstSelected{overflow: hidden; -ms-overflow-style: none; overflow: -moz-scrollbars-none;}
        </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400">
						    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
					    </TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD colSpan="4">
						<TABLE width="100%" align="center">
							<TR>
								<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
                                    <asp:Label ID="lblAvailable" runat="server" ></asp:Label></B></FONT></TD>
								<TD width="10%"></TD>
								<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
                                    <asp:Label ID="lblSelected" runat="server" ></asp:Label>
										</B></FONT>
								</TD>
								<TD width="10%"></TD>
							</TR>
							<TR>
								<TD align="center" width="40%">
                                    <div id="scrollL" style="width:350px; height:405px; overflow:scroll; border:1px solid darkgrey; background-color:White;">
                                        <asp:listbox id="lstSelect" runat="server"  SelectionMode="Multiple" CssClass="fonthead" style="overflow: hidden; border:none; height: 425px; width:350px;" ></asp:listbox>
                                        <div id="scrollhL" style='font-size: 1px'>&nbsp</div>
                                    </div>
                                </TD>
								<TD align="center" width="10%" class="fonthead">(+/-)<br>
									<br>
									<asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
								</TD>
								<TD align="center" width="40%">
									<div id="scrollR" style="width:350px; height:405px; overflow:scroll; border:1px solid darkgrey; background-color:White;">
									    <asp:ListBox id="lstSelected" SelectionMode="Multiple" Runat="server"
										CssClass="fonthead" style="overflow:hidden; border:none;" ></asp:ListBox>
                                        <div id="scrollhR" style='font-size: 1px'>&nbsp</div>
                                    </div>
                                </TD>
								<TD align="center" width="10%" class="fonthead">
                                    <asp:Label ID="lblSort" runat="server"></asp:Label><br>
									<br>
									<asp:imagebutton id="btnColmoveup" Runat="server"  /><BR>
									<asp:imagebutton id="btnColmovedwn" Runat="server"  />
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
        <div class="scrollSizeLeft" style="display:inline-block; visibility:hidden"></div>
        <div class="scrollSizeRight" style="display:inline-block; visibility:hidden"></div>
        <script>
            var strL = "";
            var strR = "";
            var objectL = document.getElementById('lstSelect');
            var objectR = document.getElementById('lstSelected');
            for (var childItem in objectL.childNodes) {
                if (objectL.childNodes[childItem].nodeType == 1) {
                    var objL = $(objectL.childNodes[childItem]).text();
                    if (objL.length > strL.length)
                        strL = objL;
                }
            }
            for (var childItem in objectR.childNodes) {
                if (objectR.childNodes[childItem].nodeType == 1) {
                    var objR = $(objectR.childNodes[childItem]).text();
                    if (objR.length > strR.length)
                        strR = objR;
                }
            }
            $('.scrollSizeLeft').text(strL);
            $('.scrollSizeRight').text(strR);
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");
            var isSafari = navigator.vendor.indexOf("Apple") == 0 && /\sSafari\//.test(navigator.userAgent); // true or false
            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
                $('#lstSelect').css('height', $('#lstSelect option').size() * $('.scrollSizeLeft').outerHeight() + 30);
                $('#lstSelected').css('height', $('#lstSelected option').size() * $('.scrollSizeRight').outerHeight() + 30);
            } else if (isSafari) {
                $('#lstSelect').css('height', $('#lstSelect option').size() * ($('.scrollSizeLeft').outerHeight() + 1));
                $('#lstSelected').css('height', $('#lstSelected option').size() * ($('.scrollSizeRight').outerHeight() + 1));
            }
            else {
                $('#lstSelect').css('height', $('#lstSelect option').size() * $('#lstSelect option').outerHeight() + 30);
                $('#lstSelected').css('height', $('#lstSelected option').size() * $('#lstSelected option').outerHeight() + 30);
            }
            if ($('.scrollSizeRight').outerWidth() < 350) {
                $('#lstSelected').css('width', 350);
                document.getElementById("scrollR").style.overflowX = "hidden";
            }
            else
                $('#lstSelected').css('width', $('.scrollSizeRight').outerWidth() + 30);
            if ($('.scrollSizeLeft').outerWidth() < 350) {
                $('#lstSelect').css('width', 350);
                document.getElementById("scrollL").style.overflowX = "hidden";
            }
            else
                $('#lstSelect').css('width', $('.scrollSizeLeft').outerWidth() + 30);
        </script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
