IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingDuty_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingDuty_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleCostingDuty_UPDATE]
(
	@ControlItemID AS UNIQUEIDENTIFIER
	, @UpdateSQL AS NVARCHAR(4000)
)
AS
BEGIN
	EXEC sp_ExecuteSQL @UpdateSQL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09195', GetDate())
GO
