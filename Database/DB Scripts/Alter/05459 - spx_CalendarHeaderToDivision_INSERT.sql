IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarHeaderToDivision_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarHeaderToDivision_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_CalendarHeaderToDivision_INSERT]
	@CalendarHeaderId UNIQUEIDENTIFIER, 
	@Divisions VARCHAR(MAX) 
AS
BEGIN

	DELETE FROM pCalendarHeaderToDivision WHERE CalendarHeaderID = @CalendarHeaderId
	
	INSERT INTO pCalendarHeaderToDivision (CalendarHeaderID, DivisionID)
	SELECT @CalendarHeaderId, ltrim(rtrim(value))
	FROM dbo.fnx_Split(@Divisions,',')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05459', GetDate())
GO
