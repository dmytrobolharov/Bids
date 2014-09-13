
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Grid_Style.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Grid_Style.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Wizard.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Wizard.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Summary.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Summary.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Vendor.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Vendor.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Calendar.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Calendar.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Schedule.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Schedule.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Sample.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Sample.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		
	 

		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Image_Multiple.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Image_Multiple.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Quote_Empty.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Quote_Empty.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Quote.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Quote.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Quote_Grid.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Quote_Grid.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Summary_Log.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Summary_Log.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	  
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_MeasEval_Load.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_MeasEval_Load.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_WorkFlow_Submit_MeasSampleSize.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_WorkFlow_Submit_MeasSampleSize.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_MeasEvalHowTo.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_MeasEvalHowTo.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_WorkFlow_Submit_MeasQASampleSize.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_WorkFlow_Submit_MeasQASampleSize.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Custom_VendorAdd.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Custom_VendorAdd.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_MeasEval_Update.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_MeasEval_Update.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Add_Select.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Add_Select.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Add_Selected.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Add_Selected.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Add_Style.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Add_Style.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Calendar.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Calendar.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Grid.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Grid.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_StyleWorkflow_Grid.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_StyleWorkflow_Grid.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_StyleWorkflow_New.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_StyleWorkflow_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Trade_List.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Trade_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Vendor_List.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Vendor_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_View.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_View.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Grid_All.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Grid_All.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Grid_Calendar.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Grid_Calendar.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Grid_My.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Grid_My.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Late.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Late.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Style.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Style.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Comments.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Comments.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Image_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Image_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Image_New.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Image_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Material_Template_Add.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Material_Template_Add.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_MeasEval_Library.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_MeasEval_Library.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_MeasQA_Load.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_MeasQA_Load.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_QA_Library.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_QA_Library.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_QA_Template.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_QA_Template.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Spec_Critical.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Spec_Critical.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Spec_Explode.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Spec_Explode.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Spec_Library.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Spec_Library.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Spec_Rules.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Spec_Rules.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Spec_SampleSize.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Spec_SampleSize.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_Spec_Template.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_Spec_Template.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Submit_TechPack.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Submit_TechPack.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='SampleRequest_Workflow_Wizard_TradePartnerList.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('SampleRequest_Workflow_Wizard_TradePartnerList.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Sample Request'))
	END
	GO
	
	
	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04004', GetDate())
GO	
	
	
	