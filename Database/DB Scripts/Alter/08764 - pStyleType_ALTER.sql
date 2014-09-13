IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleType' AND COLUMN_NAME = 'PlanningItemCalendarSearchSchema')
BEGIN
	ALTER TABLE pStyleType ADD PlanningItemCalendarSearchSchema NVARCHAR(200) NULL
END
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleType' AND COLUMN_NAME = 'PlanningItemCalendarSchema')
BEGIN
	ALTER TABLE pStyleType ADD PlanningItemCalendarSchema NVARCHAR(200) NULL
END
GO

IF EXISTS(SELECT * FROM dbo.pStyleType WHERE StyleTypeID = 10)
BEGIN
	UPDATE dbo.pStyleType 
	Set PlanningItemCalendarSchema = 'PlanningItem_Calendar_Apparel.xml', 
		PlanningItemCalendarSearchSchema = 'PlanningItem_Calendar_Search_Apparel.xml'
	WHERE StyleTypeID = 10
END
GO

IF EXISTS(SELECT * FROM dbo.pStyleType WHERE StyleTypeID = 18)
BEGIN
	UPDATE dbo.pStyleType 
	Set PlanningItemCalendarSchema = 'PlanningItem_Calendar_Accessory.xml', 
		PlanningItemCalendarSearchSchema = 'PlanningItem_Calendar_Search_Accessory.xml'
	WHERE StyleTypeID = 18
END
GO

IF EXISTS(SELECT * FROM pStyleType WHERE StyleTypeID = 19)
BEGIN
	UPDATE pStyleType 
	Set PlanningItemCalendarSchema = 'PlanningItem_Calendar_Silhouette_Apparel.xml', 
		PlanningItemCalendarSearchSchema = 'PlanningItem_Calendar_Search_Silhouette_Apparel.xml'
	WHERE StyleTypeID = 19
END
GO

IF EXISTS(SELECT * FROM pStyleType WHERE StyleTypeID = 20)
BEGIN
	UPDATE pStyleType 
	Set PlanningItemCalendarSchema = 'PlanningItem_Calendar_Silhouette_Accessory.xml', 
		PlanningItemCalendarSearchSchema = 'PlanningItem_Calendar_Search_Silhouette_Accessory.xml'
	WHERE StyleTypeID = 20
END
GO

IF EXISTS(SELECT * FROM pStyleType WHERE StyleTypeID = 21)
BEGIN
	UPDATE pStyleType 
	Set PlanningItemCalendarSchema = 'PlanningItem_Calendar_Suit.xml', 
		PlanningItemCalendarSearchSchema = 'PlanningItem_Calendar_Search_Suit.xml'
	WHERE StyleTypeID = 21
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08764', GetDate())
GO
