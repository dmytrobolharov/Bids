IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@SampleWorkflowID  NVARCHAR(5)
	
SELECT @SampleWorkflowID  = a.SampleWorkflowID
FROM pSampleRequestSubmitBOM a WITH(NOLOCK)
WHERE a.SampleRequestSubmitID = @SampleRequestSubmitID

SELECT TOP 1  b.ControlPanelSchema AS SchemaGridDefault, a.ControlPanelItemSchema AS SchemaTemplateItemGrid,
	a.SampleRequestSubmitGroupSearch, a.SampleRequestSubmitGroupDefault, a.SPXSampleRequestSubmitGroupInsert,
	a.SampleRequestSubmitGroupXML
FROM pStyleDetailGridControl a
	INNER JOIN dbo.pControlPanel b ON a.ControlPanelID =  b.ControlPanelID
WHERE a.SampleWorkflowID  = @SampleWorkflowID 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02572'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02572', GetDate())

END

GO

