ALTER TABLE pStyleCalendarTemp ALTER COLUMN CalendarDescription NVARCHAR(MAX) NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07045', GetDate())
GO
