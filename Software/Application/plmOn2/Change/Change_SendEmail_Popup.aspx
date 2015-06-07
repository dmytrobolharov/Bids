<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Change_SendEmail_Popup.aspx.vb" Inherits="plmOnApp.Change_SendEmail_Popup" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
		<title>Email</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/jquery-ui-1.8.21.custom.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/jquery.tagit.css" type="text/css" rel="stylesheet" />     
		<link href="../System/CSS/tagit.ui-zendesk.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

        <style type="text/css">
            .tdBtnAddEmail 
            {
                vertical-align: top;
            }
        </style>    
          
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/tag-it.js"></script>
		
        <style type="text/css">
            UL.tagit LI.tagit-choice { background: #0099CC; color: #FFFFFF; font-weight:bold}
        </style>
    </head>
	<body>
	
		<form id="Form1" method="post" runat="server" width="100%">
			<asp:Panel id="pnlUserOption" runat="server" width="100%">
                <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                        </td>
                        <td width="100%">
                            <cc1:ConfirmedImageButton ID="btnSend" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                            <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <br />
				 
                <table cellspacing="0" cellpadding="0" width="400" border="0" style="margin: 40px; width: 90%">
                    <tr>
                        <td width="100">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr style="margin: 10px; width: 99%;">
                        <td class="fontHead" width="100">
                            <asp:Label ID="lblEmailTo" runat="server"></asp:Label>
                        </td>
                        <td style="width: 99%">
                            <ul id="singleFieldTags" style="width: 97%; font-size: 0.7em">
                            </ul>
                            <asp:TextBox ID="txtEmailTo" runat="server" CssClass="font" border="0"></asp:TextBox>
                            <asp:TextBox ID="txtEmailAdd" runat="server" CssClass="font" border="0"></asp:TextBox>
                        </td>
                        <td class="tdBtnAddEmail">
                            <cc1:ConfirmedImageButton ID="btnAddEmail" runat="server" Message="NONE" OnClientClick="javascript:var popup=window.open('../Change/Change_AddEmail_Popup.aspx','ChangeLogNotificationAddEmail','toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=0,width=540,height=480,left=80,top=50');popup.focus();return false;">
                            </cc1:ConfirmedImageButton>
                        </td>
                    </tr>
                    <tr style="margin: 40px;">
                        <td class="fontHead" style="height: 20px" width="100">
                            <asp:Label ID="lblSubject" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="font" Width="99%" Height="27px" Style="margin-left: 40px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr width="99%">
                        <td width="99%" colspan="3">
                            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true">
                                <Scripts>
                                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                                </Scripts>
                                <CdnSettings TelerikCdn="Disabled" />
                            </telerik:RadScriptManager>
                            <telerik:RadEditor ID="RadEditor1" runat="server" Style="width: 99%">
                                <Tools>
                                    <telerik:EditorToolGroup>
                                        <telerik:EditorTool Name="Undo" />
                                        <telerik:EditorTool Name="Redo" />
                                        <telerik:EditorSeparator />
                                        <telerik:EditorTool Name="Paste" />
                                        <telerik:EditorTool Name="PasteStrip" />
                                        <telerik:EditorTool Name="FormatBlock" />
                                        <telerik:EditorTool Name="FontName" />
                                        <telerik:EditorTool Name="RealFontSize" />
                                        <telerik:EditorTool Name="Bold" />
                                        <telerik:EditorTool Name="Italic" />
                                        <telerik:EditorTool Name="Underline" />
                                        <telerik:EditorTool Name="StrikeThrough" />
                                        <telerik:EditorSeparator />
                                        <telerik:EditorTool Name="JustifyLeft" />
                                        <telerik:EditorTool Name="JustifyCenter" />
                                        <telerik:EditorTool Name="JustifyRight" />
                                        <telerik:EditorTool Name="JustifyFull" />
                                        <telerik:EditorTool Name="JustifyNone" />
                                        <telerik:EditorSeparator />
                                        <telerik:EditorTool Name="ForeColor" />
                                        <telerik:EditorTool Name="BackColor" />
                                        <telerik:EditorSeparator />
                                        <telerik:EditorTool Name="InsertUnorderedList" />
                                        <telerik:EditorTool Name="InsertOrderedList" />
                                    </telerik:EditorToolGroup>
                                </Tools>
                                <Content>
     
                                </Content>
                            </telerik:RadEditor>
                        </td>
                    </tr>
                </table>
			</asp:Panel>
		</form>
		
        <telerik:RadCodeBlock runat="server" ID="RadCode">
            <script type="text/javascript">
                $(document).ready(function () {
                    $('#txtEmailTo').hide();
                    $('#txtEmailAdd').hide();

                    var eventTags = $('#singleFieldTags');
                    $("#singleFieldTags").tagit({
                        onTagAdded: function (evt, tag) {

                            if (!validateEmail($("#singleFieldTags").tagit('tagLabel', tag))) {
                                alert('<%=GetSystemText("Wrong email") %>');
                                $("#singleFieldTags").tagit('removeTag', tag);

                            }

                        },
                        singleFieldNode: $('#txtEmailTo'),

                        singleField: true


                    });
                });


                function validateEmail(email) {
                    var re = /^([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}$/;
                    return re.test(email);
                }
                function addTag(tag) {
                    $("#singleFieldTags").tagit("createTag", tag);
                } 
            </script>
        </telerik:RadCodeBlock>
    </body>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</html>
