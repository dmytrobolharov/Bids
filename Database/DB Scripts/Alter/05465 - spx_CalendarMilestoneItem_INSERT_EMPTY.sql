IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneItem_INSERT_EMPTY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneItem_INSERT_EMPTY]
GO


CREATE PROCEDURE [dbo].[spx_CalendarMilestoneItem_INSERT_EMPTY]
	@CalendarHeaderID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	declare @Sort INT = (SELECT MAX(CASE WHEN ISNUMERIC(SortOrder) = 1 THEN CAST(SortOrder as INT) ELSE 0 END) + 1 FROM pMilestoneTemplateItem)
	if @Sort IS NULL
		set @Sort = 1
	
	INSERT INTO pCalendarMilestoneItem(CalendarHeaderID, CUser, CDate, MUser, MDate, SortOrder)
	VALUES(@CalendarHeaderID, @CUser, @CDate, @CUser, @CDate, RIGHT('000' + CAST(@Sort as VARCHAR(3)), 3))
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05465', GetDate())
GO
