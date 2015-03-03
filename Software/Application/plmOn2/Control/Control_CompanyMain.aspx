<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_CompanyMain.aspx.vb" Inherits="plmOnApp.Control_CompanyMain" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Company</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
		
    <style type="text/css">
        .style4
        {
            width: 252px;
        }
        .style7
        {
            width: 1131px;
        }
        .style8
        {
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: bold;
            FONT-SIZE: 11px;
            COLOR: Black;
            width: 414px;
        }
        .style9
        {
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: bold;
            FONT-SIZE: 11px;
            COLOR: Black;
            width: 52px;
        }
        .style11
        {
            width: 924px;
        }
        .style12
        {
            width: 98px;
        }
        .style15
        {
            width: 27%;
        }
        .style16
        {
            width: 97px;
        }
        .style17
        {
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: normal;
            FONT-SIZE: 11px;
            COLOR: Black;
            width: 52px;
        }
        .style18
        {
            width: 52px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Panel ID="pnlAddSave" runat="server">
		 <table class="TableHeader" id="toolbar1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="btnInvSearch"
                        runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
                </td><td>
                <cc1:ConfirmedImageButton ID="btnNewCompany" runat="server" 
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveCompany" runat="server" 
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnAddNewCompany" runat="server" 
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" OnClientClick="return btnClose_Click()"
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
	            </td>
                
                <td align="right" width="75"></td>
                <td width="40"></td>
                <td></td>
			</tr>
		</table>
		
		</asp:Panel>
		
		
		<asp:Panel ID="pnlNewCompany" runat="server">
		    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
            height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td align="left" style="width:50%"><B class="fonthead">&nbsp;
                        <asp:Label  ID="lblNewCompany" runat="server"></asp:Label>
                        <asp:TextBox  Width="200px" ID="txtNewCompany" runat="server" CssClass="font" MaxLength="60"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CompanyNameValidator" runat="server" ControlToValidate="txtNewCompany"
                        ErrorMessage="*" Display="Dynamic" CssClass="fontHead" ToolTip ="Company Required"></asp:RequiredFieldValidator>
                    </td>                  
                </tr>
            </table>			
		</asp:Panel>			
        
                    
    <asp:Panel ID="pnlCompany" runat="server">
        <table ID="tblHeader" runat="server" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
		    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
		    <tr>
			    <td>&nbsp;<asp:label id="lblHeader1" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
		    </tr>
		</table>    
                    
        <table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" 
            style="border-bottom: orange thin solid; border-left-style: none; background-color: white" 
            width="100%">           

            <tr>
                 <td align="left">
                     <table bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="1" 
                        width="100%">
                        <tr valign="top" width="100%">  
                            <td align="left" width="100%">
                                <asp:Label ID="lblEditCompany" runat="server"></asp:Label>
                                <asp:TextBox Width="200px" ID="txtCompany" runat="server" CssClass="fontHead" MaxLength="60"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCompany"
                                ErrorMessage="*" Display="Dynamic" CssClass="fontHead" ToolTip ="Company Required"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                   </td>                  
            </tr>
            <tr>
                <td class="style7">
                    <table bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="1" 
                        width="100%">
                        <tr valign="top" width="100%">                        
                           <td align="left" width="100%">
                                <asp:Label ID="lblGradingType" class="fontHead"  runat="server" width="150"></asp:Label>
                                <asp:RadioButton ID="rbRelative" runat="server" Checked="True" 
                                   GroupName="rbGradingType" Text="" width="130" />
                                <asp:RadioButton ID="rbIncremental" runat="server" GroupName="rbGradingType"/>
                            </td>
                        </tr>                        
                        <tr>
                           <td align="left">
                                <asp:Label ID="lblGradesLSample" class="fontHead" runat="server" width="150"></asp:Label>
                                <asp:RadioButton ID="rbConvert2Negative" runat="server" Checked="True" GroupName="rbGradesLSample" width="130" />
                                <asp:RadioButton ID="rbKeepAsEntred" runat="server" GroupName="rbGradesLSample"/>
                            </td>
                        </tr>
                        <tr>
                           <td align="left">
                                <asp:Label ID="lblMeasurements" class="fontHead" runat="server" width="150"></asp:Label>
                                <asp:RadioButton ID="rbMetric" runat="server" Checked="True" GroupName="rbMeasurements" width="130" />
                                <asp:RadioButton ID="rbImperial" runat="server" GroupName="rbMeasurements" />
                            </td>
                        </tr>
                    </table>
                </td>
                <tr>
                    <td class="style18">
                        &nbsp;</td>
                </tr>
                <tr>                    
                    <td align="left">                        
                        <asp:CheckBox ID="chkActive" runat="server" Checked="" />
                        <asp:Label ID="lblActive" runat="server"></asp:Label>
                    </td>
                    <td align="right" class="style8">
                        <asp:Label ID="lblLastModifiedLabel" runat="server"></asp:Label>
                    </td>
                </tr>
            </tr>
        </table>
    </asp:Panel>
                    
		
		
	<br>	 
		 
	 <cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview>
    <table id="Table2" class="TableHeader" runat="server" cellSpacing="0" cellPadding="0" width="100%" border="0">			
		<tr valign="middle">
		    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="ImageButton1"
                runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
            </td>
		    <td>
		        <cc1:ConfirmedImageButton id="btnEdit" runat="server"  Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
		        <cc1:bwimagebutton id="btnAdd" runat="server"  ></cc1:bwimagebutton>       
		        <cc1:ConfirmedImageButton id="btnDelete" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton id="btnSave" visible="false" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75"></td>
            <td width="40"></td>
            <td></td>
	    </TR>	    
    </table>
    
       
	  <table id="Table3" class="TableHeader" runat="server" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
				<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
				<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
				<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
				<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
				<TD width="10">&nbsp;</TD>
				<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
				<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
				<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
						<asp:ListItem Value="5">5</asp:ListItem>
						<asp:ListItem Value="10">10</asp:ListItem>
						<asp:ListItem Value="15">15</asp:ListItem>
						<asp:ListItem Value="20">20</asp:ListItem>
						<asp:ListItem Value="25">25</asp:ListItem>
						<asp:ListItem Value="30">30</asp:ListItem>
						<asp:ListItem Value="40">40</asp:ListItem>
						<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
					</asp:dropdownlist></TD>
				<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></TD>
			</TR>
		</table>
		<table id="Table4" height="15" runat="server" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			<tr>
				<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
				<td vAlign="top" width="100%">
					<table height="45">
						<tr>
							<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True">
			<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
			<headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
            <PagerStyle Visible="False"></PagerStyle>
            	<Columns>   
                    <asp:TemplateColumn >
                        <HeaderStyle Width="50px" CssClass="TableHeaderRed"></HeaderStyle>
					    <ItemStyle Width="50px"></ItemStyle>
                        <HeaderTemplate >
                            <input type="checkbox" onclick="SelectAll(this)" id="checkAll" />                           
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkDelete" />                            
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                        <ItemStyle Width="20px"></ItemStyle>
						<HeaderTemplate>
							<DIV align="center">
									<asp:Label id="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Image id="imgIsLink" runat="server" ImageUrl="../System/Icons/icon_link.gif" />    
						</ItemTemplate>
					</asp:TemplateColumn>
                </Columns>	           
			<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
		</asp:datagrid>				
	    <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
	    
	   <asp:Panel ID="pnlClassProduct" runat="server"> 
	     <table class="TableHeader" cellspacing="0" cellpadding="0" width="500" border="0">
            <tr>               
                <TD width="550" class="style2" align="left" nowrap>
                    <asp:label id="lblSizeClass1" runat="server" CssClass="font"></asp:label>
                    <asp:dropdownlist id="dpSizeClass" runat="server"
                        CssClass="fontHead" Width="200px" 
                        OnSelectedIndexChanged="dpSizeClass_SelectedIndexChanged" AutoPostBack="True">
                    </asp:dropdownlist>
               </TD>	
            </tr>
			
		 </table>
		 <table class="TableHeader" cellspacing="0" cellpadding="0" width="500" border="0">
			<TR>
				<TD align="center" width="150px"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblAvailable" runat="server"></asp:Label></B></FONT></TD>
				<TD width="100px"></TD>
				<TD align="center" width="150px"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblSelected" runat="server"></asp:Label></B></FONT></TD>
				
			</TR>
			<TR>
			<TD>&nbsp;</TD><TD>&nbsp;</TD><TD>&nbsp;</TD>
			</TR>
			<TR>
				<TD align="center" width="150px"><asp:listbox id="lstSelect" runat="server" 
                        CssClass="fonthead" Width="150px" Height="350px" SelectionMode="Multiple" BorderStyle="Outset" d></asp:listbox></TD>
				<TD class="fonthead" align="center" width="100px">(+/-)<br>
					<br>
					<asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
					<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
					<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
					<!--<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>-->
				</TD>
				<TD align="center" width="150px"><asp:listbox id="lstSelected" CssClass="fonthead" 
                        Width="150px" Height="350px" SelectionMode="Multiple" Runat="server"></asp:listbox></TD>
				<TD width="30%" class="style1"></TD>
			</TR>
        </table>
     </asp:Panel>  
        
        
    </form>
</body>

 <script language="javascript">
     var frm = document.form1;

     function SelectAll(checkAllBox) {
         var actVar = checkAllBox.checked;
         for (i = 0; i < frm.length; i++) {
             e = frm.elements[i];
             if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                 if (e.disabled == false)
                 e.checked = actVar;
         }
     }


     function DoubleClick(strParam) {
         //disabled for 4.0
         var lstRight = document.getElementById("lstSelected");
         var lstLeft = document.getElementById("lstSelect");

         if (strParam == 'left') {
             if (lstLeft.selectedIndex != -1) {
                 lstRight.appendChild(lstLeft.options.item(lstLeft.selectedIndex));
                 lstLeft.remove(lstLeft.selectedIndex);
             }
             lstLeft.selectedIndex = -1;
         }
     }

    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</html>
