/****** Object:  StoredProcedure [dbo].[spx_CalendarHistory_INSERT]    Script Date: 04/15/2013 11:09:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarHistory_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_CalendarHistory_INSERT]    Script Date: 04/15/2013 11:09:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CalendarHistory_INSERT]
@CalendarHeaderID UNIQUEIDENTIFIER,
@TeamID UNIQUEIDENTIFIER,
@CreatedDate DATETIME
AS 
BEGIN

IF EXISTS(SELECT * FROM pCalendarHistory WITH(NOLOCK) WHERE TeamID = @TeamID AND CalendarHeaderID = @CalendarHeaderID)
BEGIN
	UPDATE pCalendarHistory SET CDate = @CreatedDate WHERE CalendarHeaderID = @CalendarHeaderID AND TeamID = @TeamID
END
ELSE
BEGIN
	INSERT INTO pCalendarHistory (CalendarHeaderID, TeamID, CDate) VALUES (@CalendarHeaderID, @TeamID, @CreatedDate)
END

DELETE FROM pCalendarHistory 
WHERE TeamID = @TeamID 
AND CalendarHeaderID NOT IN (
			SELECT TOP 10 CalendarHeaderID FROM pCalendarHistory WITH(NOLOCK) 
			WHERE TeamID = @TeamID ORDER BY CDate DESC
)

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05564', GetDate())
GO
