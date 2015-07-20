<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Meas_HowTo.aspx.vb"
    Inherits="plmOnApp.Style.Measurements.Style_Meas_HowTo" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>How To Measure</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server" onkeypress="if(event.keyCode==13) {document.getElementById('btnImgSearch').click(); return false}">    
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="btnInvSearch"
                    runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
            </td>
            <td>                
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0">How To Measure</asp:Label>
            </td>
        </tr>
    </table>
    <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr class="fontHead">
            <td align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td class="fontHead" width="50">
                <div align="right">
                    <asp:Label ID="lblSearch" runat="server"></asp:Label></div>
            </td>
            <td width="75">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="font"></asp:TextBox>
            </td>
            <td width="10">
                <asp:ImageButton ID="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"
                    CausesValidation="False"></asp:ImageButton>
            </td>
            <td>
                <div align="left">
                    &nbsp;
                    <asp:Label ID="lblCurrentIndex" Text="0" Visible="False" runat="server"></asp:Label><asp:Label
                        ID="lblPageSize" Text="24" Visible="False" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
            </td>
            <td width="150">
                <div align="center">
                    <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
            </td>
            <td>
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" runat="server" Visible="true"></asp:Label>&nbsp;<asp:Label
                            ID="lblRecCount" runat="server" Visible="true">Records Found</asp:Label></b></div>
                </B>
            </td>
        </tr>
    </table>    
    <asp:DataList ID="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
        BorderColor="WhiteSmoke" BackColor="White" DataKeyField="AMLMeasPomId" OnEditCommand="DataList_EditCommand"
        OnUpdateCommand="DataList_UpdateCommand" OnCancelCommand="DataList_CancelCommand">        
        <HeaderTemplate>
            <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="Toolbar">
                    <td class="fontHead" width="20" height="20">
                        &nbsp;
                    </td>
                    <td class="fontHead" width="75">
                        <asp:Label ID="lblCode" runat="server">POM</asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblPointofMeasure" runat="server">Description</asp:Label>
                    </td>                    
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblHowToMeasure" runat="server">How to Measure</asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblHowToImage" runat="server">Image</asp:Label>
                    </td>
                </tr>
            </table>
        </HeaderTemplate>
        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
        <FooterTemplate>
        </FooterTemplate>
        <ItemStyle BackColor="White"></ItemStyle>
        <ItemTemplate>
            <table width="100%">
                <tr>
                    <td width="20" height="20">
                        <asp:LinkButton ID="btnEdit" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
                            CommandName="edit" CausesValidation="false" >
                        </asp:LinkButton>
                    </td>
                    <td class="font" width="75">
                        <asp:Label runat="server" ID="lblPom"><%#Container.DataItem("RefCode")%></asp:Label>
                    </td>
                    <td class="font" width="200">
                        <asp:Label runat="server" ID="lblPointMeasur"><%#Container.DataItem("Description")%></asp:Label>
                    </td>                    
                    <td class="font" width="200">
                        <asp:Label runat="server" ID="lblHowTomeasurText"><%#Container.DataItem("How2MeasText")%></asp:Label>
                    </td>
                    <td class="font" width="200">
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# GetImageThumbnail(DataBinder.Eval(Container.DataItem, "ImageId").ToString,"50","jpg") %>'>
                        </asp:Image>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
        <EditItemTemplate>
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="500">
                        <asp:LinkButton ID="btnSave" runat="Server" 
                            CommandName="update" >
                        </asp:LinkButton>                        
                        <asp:LinkButton ID="btnCancel" runat="Server" 
                            CommandName="cancel" CausesValidation="false"></asp:LinkButton>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
                <tr>
                    <td valign="top" width="400">
                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>                                
                                <td class="fontHead" valign="top" width="100">
                                    <asp:Label ID="lblPomCde" runat="server">POM:</asp:Label>
                                </td>
                                <td class="font">                                    
                                    <asp:TextBox ID="txtPOM" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Refcode").ToString %>'
                                        MaxLength="3" ReadOnly="true">
                                    </asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnPOM" Value='<%# DataBinder.Eval(Container.DataItem, "Refcode").ToString %>'/>                                 
                                </td>
                                <tr>
                                    <td style="height: 22px" width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        <asp:Label ID="lblPtMeasur" runat="server">Description:</asp:Label>
                                    </td>
                                    <td class="font">
                                        <asp:TextBox ID="txtPointMeasure" ReadOnly="true" runat="server" Width="250px" Text='<%# DataBinder.Eval(Container.DataItem, "Description").ToString  %>'>
                                        </asp:TextBox>
                                        <asp:HiddenField runat="server" ID="hdnPointMeasure" Value='<%# DataBinder.Eval(Container.DataItem, "Description").ToString %>' />                                        
                                    </td>
                                </tr>                                
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" valign="top" width="100">
                                        <br>
                                        <asp:Label ID="lblHTmeasure" runat="server">How to Measure:</asp:Label>
                                    </td>
                                    <td class="font">
                                        <asp:TextBox ID="txtHowToMeasure" runat="server" Width="250" Text='<%# DataBinder.Eval(Container.DataItem, "How2MeasText").ToString  %>'
                                            ToolTip="Enter how to measure here.."  Columns="50" Wrap="false" TextMode="MultiLine"
                                            Rows="5">
                                        </asp:TextBox>
                                        <asp:HiddenField runat="server" ID="hdnHowToMeasure" Value='<%# DataBinder.Eval(Container.DataItem, "How2MeasText").ToString  %>' />
                                    </td>
                                </tr>
                        </table>
                    </td>
                    <td valign="top">
                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" valign="top" width="100">
                                  <asp:Label ID="lblImgFile" runat="server">ImageFile:</asp:Label>
                                </td>
                                <td class="font">
                                    <input class="font" id="txtImagePath" type="file" runat="server"/>
                                    <input class="font" id="hidImageId" type="hidden" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ImageId").ToString  %>'/>
                                </td>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td colspan="2">
                                        <asp:Image ID="imgHowToImage" runat="server" ImageUrl='<%# GetImageThumbnail(DataBinder.Eval(Container.DataItem, "ImageId").ToString,"200","jpg") %>'>
                                        </asp:Image>
                                    </td>
                                </tr>
                        </table>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke" border="0">
                <tr>
                    <td width="20">
                        &nbsp;
                    </td>
                    <td class="font" width="100">
                        <asp:Label ID="lblCreatedBy" runat="server">Created By:</asp:Label>
                    </td>
                    <td class="font">
                        <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; Container.DataItem("CDate").ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="20" bgcolor="whitesmoke">
                        &nbsp;
                    </td>
                    <td class="font" width="100">
                        <asp:Label ID="lblModifiedBy" runat="server">Modified By:</asp:Label>
                    </td>
                    <td class="font">
                        <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; Container.DataItem("MDate").ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:DataList></form>

    <script language="javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
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
