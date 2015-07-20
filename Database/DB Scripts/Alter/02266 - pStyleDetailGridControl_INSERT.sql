IF EXISTS(SELECT WorkflowID FROM pStyleDetailGridControl WHERE WorkflowID = '90000000-0000-0000-0000-000000000009')
   BEGIN
        PRINT 'Record already exists'
   END
ELSE
BEGIN
	INSERT INTO pStyleDetailGridControl
	(
			[WorkflowID]
			,[ControlPanelID]
			,[SchemaFile]
			,[SPXInsert]
			,[SPXTemplateInsert]
			,[SPXCopyInsert]
			,[SPXControlGridItemInsert]
			,[ControlPanelItemSchema]
			,[StyleDetailGridControlID]
			,[SampleWorkflowID]
			,[SPXSampleRequestMaterialTemplateInsert]
			,[SPXSampleRequestMaterialTempItemDelete]
			,[SampleRequestSubmitGroupSearch]
			,[SampleRequestSubmitGroupDefault]
			,[SPXSampleRequestSubmitGroupInsert]
			,[SampleRequestSubmitGroupXML]
	)
	VALUES
	(
			'90000000-0000-0000-0000-000000000009'
			,NULL
			,'Style_DetailGrid_Custom_Default.xml'
			,'spx_StyleDetailGrid_Custom1_INSERT'
			,NULL
			,'spx_StyleDetailGrid_Custom1_Copy_INSERT'
			,NULL
			,NULL
			,newid()
			,NULL
			,NULL
			,NULL
			,NULL
			,NULL
			,NULL
			,NULL
	)
END
GO 


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02266'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02266', GetDate())
END

GO
