/****** Object:  StoredProcedure [dbo].[spx_pSeasonYear_Season_Control_Insert]    Script Date: 07/31/2013 15:53:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pSeasonYear_Season_Control_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pSeasonYear_Season_Control_Insert]
GO
/****** Object:  StoredProcedure [dbo].[spx_pSeasonYear_Season_Control_Insert]    Script Date: 07/31/2013 15:53:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_pSeasonYear_Season_Control_Insert]
(
@Season NVARCHAR(20), 
@CUser AS NVARCHAR(50),
@CDate AS DATETIME 
) 
AS
DECLARE @Year NVARCHAR(4)

DECLARE cur_SY CURSOR FOR
SELECT DISTINCT(Custom) FROM pYear
OPEN cur_SY;
FETCH NEXT FROM cur_SY INTO @Year
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (SELECT COUNT(Season) FROM pSeasonYear WHERE YEAR = @Year and Season = @Season) = 0
	INSERT INTO pSeasonYear 
	(
	SeasonYearID,
	Season,
	Year,
	Active,
	CustomID,
	CUser,
	CDate
	) 
	VALUES
	(
	NEWID(),
	@Season,
	@Year,
	1,
	NEWID(),
	@CUser,
	@CDate
	)
	FETCH NEXT FROM cur_SY INTO @Year
END
CLOSE cur_SY;
DEALLOCATE cur_SY;



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06101', GetDate())
GO
