IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingComparisonLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingComparisonLogic_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingComparisonLogic_INSERT] (
	@StyleCostingComparisonID uniqueidentifier,
	@ListOfScenarioIDs varchar(max),
	@CreatedBy nvarchar(200),
	@CreatedDate datetime
)
AS
BEGIN

	-- delete old temporary data
	DELETE FROM pStyleCostingComparisonTemp
	WHERE DATEDIFF(HOUR, CDate, @CreatedDate) > 24
	
	-- insert new records
	INSERT INTO pStyleCostingComparisonTemp (StyleCostingComparisonID, StyleCostingScenarioID, CUser, CDate)
	SELECT @StyleCostingComparisonID, value, @CreatedBy, @CreatedDate
	FROM dbo.fnx_Split(@ListOfScenarioIDs,',')

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04099', GetDate())
GO
