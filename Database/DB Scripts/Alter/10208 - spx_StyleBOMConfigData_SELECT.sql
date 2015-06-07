/****** Object:  StoredProcedure [dbo].[spx_StyleBOMConfigData_SELECT]    Script Date: 19.03.2015 14:32:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMConfigData_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMConfigData_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMConfigData_SELECT]    Script Date: 19.03.2015 14:32:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMConfigData_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT pStyleBOMConfig.*, ISNULL(pControlBOMConfig.AutoSetSize, 0) AS AutoSetSize, ISNULL(pControlBOMConfig.ShowLinePlanColors, 0) AS ShowLinePlanColors
	FROM pStyleBOMConfig 
	INNER JOIN pStyleBOMDimension ON pStyleBOMConfig.StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID
	INNER JOIN pStyleHeader ON pStyleBOMDimension.StyleID = pStyleHeader.StyleID
	LEFT OUTER JOIN pControlBOMConfig ON pStyleHeader.StyleType = pControlBOMConfig.StyleTypeID 
		AND pControlBOMConfig.StyleCategoryID = pStyleHeader.StyleCategory
		AND pControlBOMConfig.DivisionID = pStyleHeader.DivisionID
	WHERE pStyleBOMDimension.StyleBOMDimensionID=@StyleBOMDimensionID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10208', GetUTCDate())
GO
