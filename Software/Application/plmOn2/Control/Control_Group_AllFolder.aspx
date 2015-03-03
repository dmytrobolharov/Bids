<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Group_AllFolder.aspx.vb" Inherits="plmOnApp.Control_Group_AllFolder" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>User Access</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <script src="../System/Jscript/jquery-1.8.0.js"></script>
	</HEAD>
	<body>
		<form onkeypress="if(event.keyCode==13) {document.getElementById('btnImgSearch').click(); return false}"
			id="Form1" method="post" runat="server">
			<asp:ScriptManager ID="scriptMgr" runat="server" EnablePartialRendering="true"/>
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:imagebutton id="btnInvSearch" tabIndex="0" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:BWImageButton id="btnLockFolder" runat="server" ></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<TD class="FontHead" align="right" width="75"></TD>
					<TD width="40"></TD>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<TD align="right" width="40">
						<asp:Image id="iconLock" runat="server" ImageUrl="../System/Icons/icon_lock32.gif"></asp:Image></TD>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<asp:UpdatePanel ID="updatePnl" runat="server">
            <ContentTemplate>
            <TABLE id="radioAll" class="workflows" width="100%">
						<TR>
							<TD width="20"></TD>
							<TD class="fontHead" width="200"></TD>
							<TD width="125">
								<asp:RadioButtonList id="rbAccessAll" runat="server" Width="200px"  RepeatDirection="Horizontal" CssClass="fontHead">									
								</asp:RadioButtonList>
                           </TD>
							<TD>
								<asp:Panel class="partial" id="pnlPartial" runat="server">
									<asp:CheckBox id="cbAccessViewAll" runat="server" OnClick="return false"	CssClass="fontHead" ></asp:CheckBox>
									<asp:CheckBox id="cbAccessCreateAll" runat="server" CssClass="fontHead" OnClick="checkedUncheckedAllCheckbox(this);" ></asp:CheckBox>
									<asp:CheckBox id="cbAccessModifyAll" runat="server" CssClass="fontHead" OnClick="checkedUncheckedAllCheckbox(this);" ></asp:CheckBox>
									<asp:CheckBox id="cbAccessDeleteAll" runat="server" CssClass="fontHead"  ForeColor="Red" OnClick="checkedUncheckedAllCheckbox(this);" ></asp:CheckBox>
                                    <asp:CheckBox id="cbAccessRemoveAll" runat="server" CssClass="fontHead"  ForeColor="Red" OnClick="checkedUncheckedAllCheckbox(this);" ></asp:CheckBox>
									<asp:CheckBox id="cbAccessPrintAll" runat="server" CssClass="fontHead" OnClick="checkedUncheckedAllCheckbox(this);" ></asp:CheckBox>
								</asp:Panel></TD>
						</TR>
					</TABLE>
			<asp:datalist id="dlType" runat="server" Width="100%" BorderColor="Silver" BorderStyle="Solid"
				BorderWidth="1px">
				<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
				<FooterTemplate>
				</FooterTemplate>
				<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<TABLE class="workflows" width="100%">
						<TR>
							<TD width="20">
								<asp:Image id="iconStatus" runat="server"></asp:Image></TD>
							<TD class="fontHead" width="200"><%#Container.DataItem("TypeName")%></TD>
							<TD width="125">
								<asp:RadioButtonList id="rbAccess" runat="server" Width="200px" RepeatDirection="Horizontal" CssClass="fontHead">									
								</asp:RadioButtonList>
                                </TD>
							<TD>
								<asp:Panel class="partial" id="pnlPartial" runat="server">
									<asp:CheckBox id="cbAccessView" runat="server" OnClick="return false"	CssClass="fontHead" Text='<%#GetSystemText("View") %>'></asp:CheckBox>
									<asp:CheckBox id="cbAccessCreate" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Create") %>'></asp:CheckBox>
									<asp:CheckBox id="cbAccessModify" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Modify") %>'></asp:CheckBox>
									<asp:CheckBox id="cbAccessDelete" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Delete") %>' ForeColor="Red"></asp:CheckBox>
                                    <asp:CheckBox id="cbAccessRemove" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Remove") %>' ForeColor="Red"></asp:CheckBox>
									<asp:CheckBox id="cbAccessPrint" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Print") %>'></asp:CheckBox>
								</asp:Panel></TD>
						</TR>
					</TABLE>
				</ItemTemplate>
			</asp:datalist>
			</ContentTemplate>
        </asp:UpdatePanel>
			</form>
		<SCRIPT language="javascript">
//		    var frm = document.Form1;
//		    function CheckAll(checkAllBox) {
//		        var actVar = checkAllBox.checked;
//		        for (i = 0; i < frm.length; i++) {
//		            e = frm.elements[i];
//		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
//		                e.checked = actVar;
//		        }
		    //		    }

		    var $rds = $("input[value='0']").filter("input[name!='rbAccessAll']");
		    var $rdsCheckedNone = $("input:radio:checked[value='0']");
		    var $rdsCheckedFull = $("input:radio:checked[value='3']");
		    var $rdsCheckedPartial = $("input:radio:checked[value='2']");
		    if ($rdsCheckedNone.length === $rds.length) {
		        var $p = $("input[value='0'][name='rbAccessAll']");
		        $p.prop('checked', true);
		        $p.closest('.workflows').find('.partial').css('display', 'none');
		    }
		    else {
		        if ($rdsCheckedFull.length === $rds.length) {
		            var $p = $("input[value='3'][name='rbAccessAll']");
		            $p.prop('checked', true);
		            $p.closest('.workflows').find('.partial').css('display', 'none');
		        }
		        else {
		            if ($rdsCheckedPartial.length === $rds.length) {
		                var $p = $("input[value='2'][name='rbAccessAll']");
		                $p.prop('checked', true);
		                $p.closest('.workflows').find('.partial').css('display', 'block');
		            }
		            else {
		                var $p = $("input[value='0'][name='rbAccessAll']");
		                $p.closest('.workflows').find('.partial').css('display', 'none');
                     }
                }
            }

		    

		    
		    

         var $cbxView = $("input[data-group='AccessView']").filter("input[id!='cbAccessViewAll']");
         var $cbxCreate = $("input:checkbox:checked[data-group='AccessCreate']");
         var $cbxModify = $("input:checkbox:checked[data-group='AccessModify']");         
         var $cbxDelete = $("input:checkbox:checked[data-group='AccessDelete']");
         var $cbxPrint = $("input:checkbox:checked[data-group='AccessPrint']");
         var $cbxRemove = $("input:checkbox:checked[data-group='AccessRemove']");

         if ($cbxCreate.length === $cbxView.length) {
             $("input:checkbox[data-group='AccessCreate']").prop('checked', true);
         }
         if ($cbxModify.length === $cbxView.length) {
             $("input:checkbox[data-group='AccessModify']").prop('checked', true);
         }
         if ($cbxDelete.length === $cbxView.length) {
             $("input:checkbox[data-group='AccessDelete']").prop('checked', true);
         }
         if ($cbxPrint.length === $cbxView.length) {
             $("input:checkbox[data-group='AccessPrint']").prop('checked', true);
         }
         if ($cbxRemove.length === $cbxView.length) {
             $("input:checkbox[data-group='AccessRemove']").prop('checked', true);
         }
        

		    function changeIcon(btn) {
		        var Img = $(btn).closest('.workflows').find("img");
		        var curValue = btn.value;
		        switch (curValue) {
		            case '0':
		                $(Img).attr("src", "../System/icons/icon_ball_red.gif");
		                break;
		            case "3":
		                $(Img).attr("src", "../System/icons/icon_ball_green.gif");
		                break;
		            case "2":
		                $(Img).attr("src", "../System/icons/icon_ball_yellow.gif");
		                break;
		            default:
		                $(Img).attr("src", "../System/icons/icon_ball_red.gif");
		                break;
		        }

		    }

		    function checkedRadioBtn(btn) {
		        var curValue = $(btn).val();
		        $("#radioAll").find('.partial').css('display', 'none');
		        $("#radioAll").find("input:radio").prop('checked', false);
		        if (curValue === "2")
		            visiblePartial(btn);
		        else
		            hidePartial(btn);

		        changeIcon(btn);
		    }

		    function visiblePartial(btn) {
		        $(btn).closest('.workflows').find('.partial').css('display', 'block');
		    }

		    function hidePartial(btn) {
		        $(btn).closest('.workflows').find('.partial').css('display', 'none');
		    }

		    function checkedUncheckedAllRadio(btn) {
		        var curValue = $(btn).val();
		        $("input:radio").prop('checked', false);

		        $("input:radio[value=" + curValue + "]").each(function (index) {
		            $(this).prop('checked', true);
		            changeIcon(this);
		            if (curValue === "2")
		                visiblePartial(this);
		            else
		                hidePartial(this);
		        });
		        $("input:checkbox[data-group!='AccessView']").prop('checked', false);
		    }

		    function checkedUncheckedAllCheckbox(btn) {
		        var curName = $(btn).attr('data-group'); 

		        $("input[data-group='" + curName + "']").each(function (index) {
		            if ($(this).prop('checked'))
		                $(this).prop('checked', false);
		            else
		                $(this).prop('checked', true);
		        });
		        if ($(btn).prop('checked'))
		            $(btn).prop('checked', false);
		        else
		            $(btn).prop('checked', true);
		    }
		</SCRIPT>
		<asp:Label id="lblWarning" runat="server" CssClass="fontHead"></asp:Label>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
