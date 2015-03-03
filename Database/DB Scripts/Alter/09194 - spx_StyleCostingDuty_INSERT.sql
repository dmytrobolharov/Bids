IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingDuty_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingDuty_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCostingDuty_INSERT]
(
	@NewID AS UNIQUEIDENTIFIER
	, @UpdateSQL AS NVARCHAR(4000)
)
AS
BEGIN
	INSERT INTO pStyleCostingDuty (CustomID, Active)
	VALUES (@NewID, 1)

	EXEC sp_ExecuteSQL @UpdateSQL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09194', GetDate())
GO
