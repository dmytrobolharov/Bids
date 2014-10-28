<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Style_Search.aspx.vb" Inherits="plmOnApp.Line_List_Style_Search" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style Search</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
        <style type="text/css"">
             .imgContainer
            {
                position:relative;
            }
            .imgContainer div 
            {
                position:absolute;
                left:0;
                background-color: White;
                visibility: hidden;
            }
        </style>
        <style type="text/css">
             .imgContainer
            {
                position:relative;
            }
            .imgContainer div 
            {
                position:absolute;
                background-color: White;
                left: 0px;
                visibility: hidden;
            }
        
            .imgContainer div:before,
            .frame_before {
                content: "";
                display: inline-block;
                height: 100%;
                vertical-align: middle;
            }

            .imgContainer img {
                vertical-align: middle;
            }           
        </style>
        <!--[IF IE]>
        <style type="text/css">
            .imgContainer div {
                list-style:none;
                behavior: expression(
                    function(t){
                        t.insertAdjacentHTML('afterBegin','<span class="frame_before"></span>');
                        t.runtimeStyle.behavior = 'none';
                    }(this)
                );
            }
        </style>
        <![endif]-->		
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td>
					<asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton>
					<cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
				    <!--<cc1:confirmedimagebutton id="btnNewStyle" runat="server" Message="NONE"></cc1:confirmedimagebutton>-->
					<cc1:confirmedimagebutton id="imgBtnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Style</asp:Label></td>
				</tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	            border="0">
	            <TR class="fontHead">
                    
		            <TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></TD>
                    <TD width="55"><asp:Label runat="server" ID="lblChkAll">Select All</asp:Label></TD>
                    <TD width="20" height="25" align="left">
                        <asp:CheckBox onclick="SelectAll(this)" runat="server" id="checkAll"/>
                    </TD>
                    
		            <TD height="25">
			            <DIV align="left">&nbsp;
				            <asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="10" Visible="False" Runat="server">10</asp:label></DIV>
		            </TD>
		            <TD width="20"><asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton></TD>
		            <TD width="20"><asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton></TD>					
		            <TD noWrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></TD>
		            <TD width="20"><asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton></TD>
		            <TD width="20"><asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton></TD>
		            <TD width="10">&nbsp;</TD>
		            <TD noWrap height="25"><div align="left"><b>
                           <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                           <asp:label id="lblRecordFound" Runat="server" />
                         </b></div>
                    </TD>	
		            <TD height="25">
			            <P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
				            <asp:dropdownlist id="ddlSortBy" runat="server">
					            <asp:ListItem Value="ASC">ASC</asp:ListItem>
					            <asp:ListItem Value="DESC">DESC</asp:ListItem>
				            </asp:dropdownlist>
				            <asp:ImageButton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton></P>
		            </TD>
                    
	            </TR>
            </TABLE>
            <TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	            <TR>
		            <TD vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="styleSeasonYearId" RepeatLayout="Table" RepeatColumns="1"
				            RepeatDirection="Horizontal" EnableViewState="false">
				            <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				            <ItemTemplate>
					            <table borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						            border="0">
						            <tr>
							            <td>
								            <asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#GetSystemText("Click here to select style") & "..."%>' CssClass="font"></asp:CheckBox>
							            </td>
						            </tr>
					            </table> 
					            
                                	
				            </ItemTemplate>
				            <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			            </asp:datalist></TD>
	            </TR>
            </TABLE>
		</form>
        <script type="text/javascript" language="javascript">
            window.onload = SetImageHoverEffects;

            function SetImageHoverEffects() {
                var width = 0;
                var height = 0;

                var intervalHandlers = new Array();

                $(".imgContainer").each(function (index) {
                    $(this).attr("id", index);

                    var hasDesignBack = false;

                    hasDesignBack = $(this).find(".imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1;

                    if (hasDesignBack) {
                        width = Math.max(width, Math.max($(this).find(".imgDesign").width(), $(this).find(".imgDesignBack").width()));
                        height = Math.max(height, Math.max($(this).find(".imgDesign").height(), $(this).find(".imgDesignBack").height()));
                    }

                    else {
                        width = Math.max(width, $(this).find(".imgDesign").width());
                        height = Math.max(height, $(this).find(".imgDesign").height());
                    }

                    $(this)
                    .mouseover(function () {
                        if (hasDesignBack) {
                            $(this).find(".imgDesignContainer").fadeOut();
                            clearInterval(intervalHandlers[$(this).attr("id")]);
                            var elementToToggle = $(this).find(".imgDesignContainer");
                            intervalHandlers[$(this).attr("id")] = setInterval(function () {
                                elementToToggle.fadeToggle()
                            }, 1200);
                        }
                    })
                    .mouseleave(function () {
                        if (hasDesignBack) {
                            clearInterval(intervalHandlers[$(this).attr("id")]);
                            $(this).find(".imgDesignContainer").fadeIn();
                        }
                    });
                });

                $(".imgContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgDesignBackContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgDesignContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgContainer").each(function (index) {
                    $(this).find(".imgDesignContainer").css("visibility", "visible");

                    if ($(this).find(".imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1) {
                        $(this).find(".imgDesignBackContainer").css("visibility", "visible");
                    }
                });
            };
            var frm = document.Form1;
            function SelectAll(checkAllBox) {
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox')
                        e.checked = actVar;
                }
            }
        </script>
	</body>
</html>
