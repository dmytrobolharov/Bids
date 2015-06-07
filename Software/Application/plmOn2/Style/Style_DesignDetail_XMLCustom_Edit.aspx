﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DesignDetail_XMLCustom_Edit.aspx.vb" Inherits="plmOnApp.Style.DesignDetail.Style_DesignDetail_XMLCustom_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script> 
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>   
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <table id="Table1" class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td><td><cc1:confirmedimagebutton 
					id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
    				id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
			</tr>
		</table>

		<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'></uc2:style_header>
		<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			</tr>
		</table>
		
        <br/><br/>    
        <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                <td width="125" align="right" nowrap="nowrap">
                    <asp:Label runat="server" ID="Label5" class="fontHead" >Select Season / Year:</asp:Label>
                </td>
                <td>
                    <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                </td>
            </tr>
        </table>
        <br /><br />
        
        <table border="0">  
        <tr>
            <td>
            
                <asp:PlaceHolder runat="server" ID="plhHeader" ></asp:PlaceHolder>
                
                <br /><br />
                
                <table border="1" >
                    <tr>
                        <td> 
                            <asp:Label runat="server" ID="lblHeader" CssClass="fontHead" >1.CONSTRUCTION</asp:Label>
                            <br />
                            <asp:PlaceHolder runat="server" ID="plhContruction" ></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
                <cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton>
            </td>
        </tr>

                
        <tr runat="server" id="trColors" >
            <td colspan ="2">
                <br /><br />
                <table border="1"  width="100%">
                <tr><td>
                    <asp:Label runat="server" ID="Label1" CssClass="fontHead" >2.COLOURS</asp:Label><br />
                    <asp:datalist id="dlColors" runat="server" RepeatDirection="Horizontal" 
                        RepeatColumns="2" EnableViewState="False" DataKeyField="DesignDetailStyleColorID">
                        <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
                        <ItemTemplate>
                            <table border="0">
                                <tr>
                                    <td><asp:label runat="server" ID="lblColorway" /></td>
                                    <td width="25">&nbsp;</td>
                                    <td><asp:TextBox  id="txtNotes" runat="server" TextMode="MultiLine" 
                                        onKeyUp="javascript:Count(this,110);" onChange="javascript:Count(this,110);" 
                                        Rows="2" Width="250" ></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:datalist>	            

                </td>
                </tr>
                </table>
            </td>
        </tr>
        
         <tr runat="server" id="tr1" >
            <td colspan ="2">
                <br /><br />
                
                <table border="1" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="50%">
                        <asp:Label runat="server" ID="Label2" CssClass="fontHead" >3.FINISHING</asp:Label><br />
                        <asp:PlaceHolder runat="server" ID="plhFinishing" ></asp:PlaceHolder>
                        <br />
                        <br />
                        <asp:Label runat="server" ID="Label3" CssClass="fontHead" >5.APPROVAL</asp:Label><br />
                        <asp:TextBox  id="txtApproval" runat="server" TextMode="MultiLine" Rows="2" Width="50%"
                            onKeyUp="javascript:Count(this,200);" onChange="javascript:Count(this,200);" ></asp:TextBox>
                    </td>
                    <td width="20">&nbsp;</td>
                    <td valign="top" width="50%" >
                        <asp:Label runat="server" ID="Label4" CssClass="fontHead" >4.FURTHER COMMENTS</asp:Label><br />
                        
                        <asp:TextBox  id="txtComments" runat="server" TextMode="MultiLine" Width="50%" Rows="5"
                        onKeyUp="javascript:Count(this,200);" onChange="javascript:Count(this,200);" ></asp:TextBox>
                    </td>
                </tr>
                </table>
                
            </td>
        </tr>
                
        </table>
        <br /><br />            
        <table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar">
					<asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			</tr>
		</table>	            
    </form>
    <script language="javascript">
        function Count(text, maxL) {

            if (text.value.length > maxL) {
                text.value = text.value.substring(0, maxL);
                alert(" Max lenght " + maxL + " chars");
            }
        }
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
