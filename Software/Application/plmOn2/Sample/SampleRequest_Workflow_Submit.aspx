<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		  <title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/mamagi.css" type="text/css" rel="stylesheet">
                 <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
          <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src='../System/Jscript/YSCalendarFunctions.js'></script>
		
	
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
    <script language="javascript" type="text/javascript" src='../System/Jscript/YSCustomFunctions.js'></script>
	<script language="javascript" type="text/javascript">


	    function doubleclickEnd() {
	        var obj = null
	        var obj1 = null
	        if (document.getElementById('Spec_txtEndBy') != null) {
	            obj = document.getElementById('Spec_txtEndBy')
	            obj1 = document.getElementById('Spec_txtEndDate')
	        }
	        else if (document.getElementById('Material_txtEndBy') != null) {
	            obj = document.getElementById('Material_txtEndBy')
	            obj1 = document.getElementById('Material_txtEndDate')
	        }
	        else if (document.getElementById('Color_txtEndBy') != null) {
	            obj = document.getElementById('Color_txtEndBy')
	            obj1 = document.getElementById('Color_txtEndDate')
	        }
	        else if (document.getElementById('Custom_txtEndBy') != null) {
	            obj = document.getElementById('Custom_txtEndBy')
	            obj1 = document.getElementById('Custom_txtEndDate')
	        }


	        if (obj != null) {
	            obj.value = document.getElementById('hd_UserName').value;
	        }
	        if (obj1 != null) {
	            obj1.value = document.getElementById('hd_UserDate').value;
	            //document.Form1['Spec$txtEndBy'].value = document.Form1['Spec$hd_UserName'].value;
	            //document.Form1['Spec$txtEndDate'].value = document.Form1['Spec$hd_UserDate'].value;
	        }
	    }
	    function doubleclickRec() {
	        var obj = null
	        var obj1 = null
	        if (document.getElementById('Spec_txtRecBy') != null) {
	            obj = document.getElementById('Spec_txtRecBy')
	            obj1 = document.getElementById('Spec_txtRecDate')
	        }
	        else if (document.getElementById('Material_txtRecBy') != null) {
	            obj = document.getElementById('Material_txtRecBy')
	            obj1 = document.getElementById('Material_txtRecDate')
	        }
	        else if (document.getElementById('Color_txtRecBy') != null) {
	            obj = document.getElementById('Color_txtRecBy')
	            obj1 = document.getElementById('Color_txtRecDate')
	        }
	        else if (document.getElementById('Custom_txtRecBy') != null) {
	            obj = document.getElementById('Custom_txtRecBy')
	            obj1 = document.getElementById('Custom_txtRecDate')
	        }


	        if (obj != null) {
	            obj.value = document.getElementById('hd_UserName').value;
	        }
	        if (obj1 != null) {

	            obj1.value = document.getElementById('hd_UserDate').value;
	            //document.Form1['Spec$txtRecBy'].value = document.Form1['Spec$hd_UserName'].value;
	            //document.Form1['Spec$txtRecDate'].value = document.Form1['Spec$hd_UserDate'].value;
	        }
	    }
	    function doubleclickRev() {
	        var obj = null
	        var obj1 = null
	        if (document.getElementById('Spec_txtRevBy') != null) {
	            obj = document.getElementById('Spec_txtRevBy')
	            obj1 = document.getElementById('Spec_txtRevDate')
	        }
	        else if (document.getElementById('Material_txtRevBy') != null) {
	            obj = document.getElementById('Material_txtRevBy')
	            obj1 = document.getElementById('Material_txtRevDate')
	        }
	        else if (document.getElementById('Color_txtRevBy') != null) {
	            obj = document.getElementById('Color_txtRevBy')
	            obj1 = document.getElementById('Color_txtRevDate')
	        }
	        else if (document.getElementById('Custom_txtRevBy') != null) {
	            obj = document.getElementById('Custom_txtRevBy')
	            obj1 = document.getElementById('Custom_txtRevDate')
	        }



	        if (obj != null) {
	            obj.value = document.getElementById('hd_UserName').value;
	        }
	        if (obj1 != null) {
	            obj1.value = document.getElementById('hd_UserDate').value;
	        }
	        //	        document.Form1['Spec$txtRevBy'].value = document.Form1['Spec$hd_UserName'].value;
	        //	        document.Form1['Spec$txtRevDate'].value = document.Form1['Spec$hd_UserDate'].value;


	    }
	    function doubleclickVendor() {
	        var obj = null
	        var obj1 = null
	        if (document.getElementById('Spec_txtVendorName') != null) {
	            obj = document.getElementById('Spec_txtVendorName')
	            obj1 = document.getElementById('Spec_txtVendorDate')
	        }
	        else if (document.getElementById('Material_txtVendorName') != null) {
	            obj = document.getElementById('Material_txtVendorName')
	            obj1 = document.getElementById('Material_txtVendorDate')
	        }
	        else if (document.getElementById('Color_txtVendorName') != null) {
	            obj = document.getElementById('Color_txtVendorName')
	            obj1 = document.getElementById('Color_txtVendorDate')
	        }
	        else if (document.getElementById('Custom_txtVendorName') != null) {
	            obj = document.getElementById('Custom_txtVendorName')
	            obj1 = document.getElementById('Custom_txtVendorDate')
	        }



	        if (obj != null) {
	            obj.value = document.getElementById('hd_UserName').value;
	        }
	        else if (document.getElementById('Spec_Status_txt_VendorBy') != null) {
	            document.getElementById('Spec_Status_txt_VendorBy').value = document.getElementById('hd_UserName').value;
	        }
	        if (obj1 != null) {
	            obj1.value = document.getElementById('hd_UserDate').value;
	        }
	        else if (document.getElementById('Spec_Status_txt_VendorDate') != null) {
	            document.getElementById('Spec_Status_txt_VendorDate').value = document.getElementById('hd_UserDate').value;
	        }

	    }	   

            function stopRKey(evt) {
                var evt = (evt) ? evt : ((event) ? event : null);
                var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
                if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
            }

            function checkSubmit() {
                if (document.getElementById("<%=HFSubmitForm.ClientID %>").value == 1)
                    return false;
                else {
                    document.getElementById("<%=HFSubmitForm.ClientID %>").value = 1;
                    return true;
                }
            }

            function enterMeasurement() {

            var $confirmDialog = $("#confirm");
            //$confirmDialog.html(' <p> <%= GetSystemText("Enter Measurement name") %> </p>' +
           // '<input type=text width="60px" name="name" id="name"');
            $confirmDialog.dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                height: 160,
                width: 430,
                title: '<%= GetSystemText("Measurement") %>',
                buttons: {
                    '<%= GetSystemText("OK") %>': function () {
                        $("#measName").val($("#txtWorkFlowItemName").val());
                        $("#measType").val($("#drlWorkflowItemTypeId").val());

                        if ($("#measType").val()=="" ||  $("#measName").val()==""){
                        alert('<%= GetSystemText("Enter Measurement Type and Name") %>');
                        return false;
                        }
                        $(this).dialog("close");
                        <%= ClientScript.GetPostBackEventReference(New PostBackOptions(btnMakeMeasurement)) %>;       
                        return true;
                    }
                }
            });

            $confirmDialog.dialog('open');
            return false;
        }

            document.onkeypress = stopRKey;

            
            
        </script> 
       
        <script language="javascript" src='../System/Jscript/mamagi/jquery.mamagi.yunique.js'></script>
        <script language="javascript" src='../System/Jscript/mamagi/scroll.comment.js'></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
        <div id="fixed_icons" ><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><asp:HiddenField ID="HiddenField1" runat="server" /><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnMakeMeasurement" runat="server" visible="false" MESSAGE="NONE" onclientclick="javascript:enterMeasurement();return false;"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnSave" OnClientClick="javascript:if(checkSubmit()==false){return false;}" runat="server" MESSAGE="NONE"></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnGoToStyle" runat="server" ></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="btnPreview" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnDelete" runat="server"  ></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnLog" runat="server" ></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="btnNewIssue" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:BWImageButton id="btnChangeLog" runat="server" CausesValidation="False"/>
                        <asp:HiddenField ID="HFSubmitForm" runat="server" Value="0" />
					</TD>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<asp:PlaceHolder id="phSeasonYearColor" runat="server"></asp:PlaceHolder>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="100%"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr><td><asp:placeholder id="phSpec" runat="server"></asp:placeholder>
			<asp:PlaceHolder id="phMaterial" runat="server"></asp:PlaceHolder>
			<asp:PlaceHolder id="phCustom" runat="server"></asp:PlaceHolder>
			</td></tr>
			</table>
			

			<br />
			<br />
			<div align="center" >
			    <asp:Label runat="server" ID="lblMessage" Visible ="False" Font-Size="X-Large" ForeColor="Red" Font-Bold="True" ></asp:Label>
			</div>
			<input type="hidden" runat="server"  id="hd_UserName" />
<input type="hidden" runat="server"  id="hd_UserDate" />
		
			<input type="hidden" runat="server" id="measName" name="measName"/>
            <input type="hidden" runat="server" id="measType" name="measType"/>
            
            <div id="confirm" style="display:none;">
            <asp:placeholder id="plhMeasData" runat="server"></asp:placeholder>
            </div>
			</form>
			
	</body>
</HTML>
