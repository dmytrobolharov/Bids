/****** Object:  StoredProcedure [dbo].[spx_TACalHoliday_ByHolidayDate_SELECT]    Script Date: 07/31/2014 11:56:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalHoliday_ByHolidayDate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalHoliday_ByHolidayDate_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalHoliday_ByHolidayDate_SELECT]    Script Date: 07/31/2014 11:56:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalHoliday_ByHolidayDate_SELECT]
	@HolidayDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT TACalHolidayId, TACalHolidayName, TACalHolidayCountry, InternalHoliday 
    FROM pTACalHoliday 
    WHERE TACalHolidayDate = @HolidayDate
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08502', GetDate())
GO
