IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_MeasurementPages_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_MeasurementPages_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Style_MeasurementPages_SELECT]
	@StyleID UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	SELECT meas.AMLMeasHdrId, wi.WorkFlowItemName
	FROM pWorkflowItem wi INNER JOIN pAMLMeasHdr meas ON wi.WorkFlowItemID = meas.WorkFlowItemId
	WHERE wi.StyleID = @StyleID
	UNION
	SELECT meas.AMLMeasHdrId, wi.WorkFlowItemName + ' (linked)'--+ '&nbsp;<img align="absMiddle" src="../System/Icons/icon_link.gif" border="0"/>'
	FROM pWorkFlowItemLinked wil INNER JOIN pAMLMeasHdr meas ON wil.WorkFlowItemID = meas.WorkFlowItemId INNER JOIN pWorkFlowItem wi ON wil.WorkFlowItemID = wi.WorkFlowItemID
	WHERE wil.StyleID = @StyleID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06331', GetDate())
GO
