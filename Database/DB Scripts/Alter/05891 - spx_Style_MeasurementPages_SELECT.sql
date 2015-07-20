/****** Object:  StoredProcedure [dbo].[spx_Style_MeasurementPages_SELECT]    Script Date: 06/14/2013 10:31:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_MeasurementPages_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_MeasurementPages_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_Style_MeasurementPages_SELECT]    Script Date: 06/14/2013 10:31:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Style_MeasurementPages_SELECT]
	@StyleID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT meas.AMLMeasHdrId, wi.WorkFlowItemName
    FROM pWorkflowItem wi INNER JOIN pAMLMeasHdr meas ON wi.WorkFlowItemID = meas.WorkFlowItemId
    WHERE wi.StyleID = @StyleID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05891', GetDate())
GO
