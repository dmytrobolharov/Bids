IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@SampleWorkflowID  NVARCHAR(5)
	
SELECT @SampleWorkflowID  = a.SampleWorkflowID
FROM pSampleRequestSubmit a WITH(NOLOCK)
WHERE a.SampleRequestSubmitID = @SampleRequestSubmitID

SELECT TOP 1  b.ControlPanelSchema AS SchemaGridDefault, a.ControlPanelItemSchema AS SchemaTemplateItemGrid,
	a.SampleRequestSubmitGroupSearch, a.SampleRequestSubmitGroupDefault, a.SPXSampleRequestSubmitGroupInsert,
	a.SampleRequestSubmitGroupXML
FROM pStyleDetailGridControl a
	INNER JOIN dbo.pControlPanel b ON a.ControlPanelID =  b.ControlPanelID
WHERE a.SampleWorkflowID  = @SampleWorkflowID 


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03042'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03042', GetDate())     

END	  
  
GO