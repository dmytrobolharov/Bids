<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_Version.aspx.vb" Inherits="plmOnApp.Image_Version" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Image version</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <script type="text/javascript">
        function changeCmpVersion(src, version) {
            $("#<%= imgCmpVersion.ClientID %>").attr("src", src).show();
            $("#<%= lblCmpVersion.ClientID %>").text(version);

            return false;
        }
    </script>
    <style type="text/css">
        .carousel {
        	margin: 0 30px;
        	width: 400px;
        	position: relative;
        }
        .carousel li {
        	margin: 10px 30px;
        	float: left;
        }
        .btnPrev, .btnNext {
        	position: absolute;
        	top:0;
        	bottom:0;        	
        	width:30px;        	
        	z-index: 1;  
        	cursor: pointer;      	        	
        }
        
        .btnPrev {
        	left:0;
        	background: #ccc url("../System/Images/bbPrev.gif") no-repeat 50% 50%;
        }        
        
        .btnNext {
        	right:0;
        	background: #ccc url("../System/Images/bbNext.gif") no-repeat 50% 50%;
        }
        
        .carousel .disabled {
        	background-color: #eee;
        	cursor: default;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Version...</asp:Label>
            </td>
        </tr>
    </table>
    <asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>    
    <table cellpadding="5" cellspacing="0" width="100%">
        <tr>
            <td width="50%" align="right" valign="middle">
                <table cellspacing="0" cellpadding="0">
                    <tr><td><asp:Image runat="server" ID="imgCurrent" /></td></tr>
                    <tr><td align="center"><asp:Literal runat="server" ID="lblCurrentVersion"></asp:Literal></td></tr>
                </table>
            </td>
            <td width="50%" align="left" valign="middle">
                <table cellspacing="0" cellpadding="0">
                    <tr><td><asp:Image runat="server" ID="imgCmpVersion" Visible="true" Style="display:none;" /></td></tr>
                    <tr><td align="center"><asp:Label runat="server" ID="lblCmpVersion"></asp:Label></td></tr>
                </table>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="1" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff" align="center">
                <div class="carousel">                
                <asp:Repeater ID="DataList1" runat="server" OnItemCommand="DataList1_ItemCommand">
                    <HeaderTemplate>
                        <ul>
                    </HeaderTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                    <ItemTemplate>
                        <li>
                            <table cellspacing="1" cellpadding="0" border="0">
                                <tr bgcolor="#ffffff">
                                    <td valign="middle" align="center">
                                        <cc1:confirmedimagebutton id="imgBtnImage" runat="server" message='NONE' commandname="Edit">
														    </cc1:confirmedimagebutton>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td class="font" valign="middle" align="center">
                                        <asp:Label ID="lblVersionH" runat="server"><%#GetSystemText("Version")%>:</asp:Label>
                                        <asp:Label ID="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>' />
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td class="font" valign="middle" align="center">
                                        <asp:Label ID="lblModified" runat="server"><%#GetSystemText("Last Modified")%>: <%#Convert.ToDateTime(SystemHandler.GetLocalTime(Eval("MDate"))).ToString(Me.GetFormatInfo.DateTimeLongFormat)%></asp:Label><br />
                                        <asp:Label ID="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%>: <%#Eval("MUser").ToString%></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>  
                <div class="btnPrev">&nbsp;</div>
                <div class="btnNext">&nbsp;</div>
                </div>
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript" language="javascript" src="../System/Jscript/jcarousellite_1.0.1.js"></script>
    <script type="text/javascript">
            if ($(".carousel li").length > 0) {
                $(".carousel").jCarouselLite({
                    btnNext: ".btnNext",
                    btnPrev: ".btnPrev",
                    circular: false,
                    visible: 4
                });
            }
     </script>

</body>
</html>
