/****** Object:  StoredProcedure [dbo].[spx_ChangeTable_NewMaterialRequestWorkflow_INSERT]    Script Date: 01/29/2013 16:32:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTable_NewMaterialRequestWorkflow_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeTable_NewMaterialRequestWorkflow_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTable_NewMaterialRequestWorkflow_INSERT]    Script Date: 01/29/2013 16:32:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ChangeTable_NewMaterialRequestWorkflow_INSERT]
	@MaterialRequestWorkflowID NVARCHAR(10)
AS
BEGIN
	DECLARE @ChangeTableID UNIQUEIDENTIFIER = NEWID()
	
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, 
	ChangeTablePKName, ChangeTableXML)
	VALUES (@ChangeTableID, 'pMaterialRequestWorkflow', 'MaterialID', 'MaterialRequestWorkflowID',
	'ChangeLogItem_AdvancedMR.xml')
	
	INSERT INTO pMaterialRequestToChangeTable(MaterialRequestWorkflowID, ChangeTableID)
	VALUES (@MaterialRequestWorkflowID, @ChangeTableID)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04913', GetDate())
GO
