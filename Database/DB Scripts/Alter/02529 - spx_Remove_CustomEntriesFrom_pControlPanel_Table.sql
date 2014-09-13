
/****** Object:  StoredProcedure [dbo].[spx_Remove_CustomEntriesFrom_pControlPanel_Table]    Script Date: 12/30/2011 19:47:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Remove_CustomEntriesFrom_pControlPanel_Table]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Remove_CustomEntriesFrom_pControlPanel_Table]
GO


CREATE PROCEDURE [dbo].[spx_Remove_CustomEntriesFrom_pControlPanel_Table]
(
@ControlPanelName AS VARCHAR(100)
)
--spx_Remove_CustomEntriesFrom_pControlPanel_Table 'Custom 10'
AS
BEGIN
	IF EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName=@ControlPanelName)
	BEGIN
		
		UPDATE pControlPanel SET
			IsDataValidation=1	
		WHERE 
		ControlPanelName=@ControlPanelName
		
	END
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02529'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02529', GetDate())
	
END
GO