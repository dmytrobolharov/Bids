IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderLocking_Logic_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleHeaderLocking_Logic_SELECT]
GO 


CREATE PROCEDURE [dbo].[spx_StyleHeaderLocking_Logic_SELECT] (
	@TeamID	UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER 
)
AS

DECLARE @UnlockHeader INT 
DECLARE @StyleLocked INT 

SELECT @UnlockHeader = UnlockHeader FROM Users WHERE TeamID = @TeamID 
SELECT @StyleLocked = HeaderLocked  FROM pStyleHeader WHERE StyleID = @StyleID

IF @StyleLocked > 0 AND @UnlockHeader = 1 
	SELECT 1 
ELSE 
	SELECT 0

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01528', GetDate())
GO




