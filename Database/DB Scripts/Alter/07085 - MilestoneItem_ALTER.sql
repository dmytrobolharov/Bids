ALTER TABLE pMilestoneTemplateItem ADD DueDate DATETIME, MilestoneItemStatus INT, Comment NVARCHAR(400)
ALTER TABLE pCalendarMilestoneItem ADD MilestoneItemStatus INT, Comment NVARCHAR(400)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07085', GetDate())
GO
