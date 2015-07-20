IF NOT EXISTS(SELECT * FROM pMilestoneItemStatus WHERE MilestoneItemStatus = N'In Progres')
BEGIN
	INSERT pMilestoneItemStatus (MilestoneItemStatusID, MilestoneItemStatus, MilestoneItemStatusRepID, Active) 
	VALUES (1, N'In Progres', N'6394af95-4772-4278-816b-6a0a8babc332', 1)
END

IF NOT EXISTS(SELECT * FROM pMilestoneItemStatus WHERE MilestoneItemStatus = N'Approved')
BEGIN
	INSERT pMilestoneItemStatus (MilestoneItemStatusID, MilestoneItemStatus, MilestoneItemStatusRepID, Active) 
	VALUES (2, N'Approved', N'10bbfa0b-8db1-4f55-b57e-954f9973d7b8', 1)
END

IF NOT EXISTS(SELECT * FROM pMilestoneItemStatus WHERE MilestoneItemStatus = N'Complete')
BEGIN
	INSERT pMilestoneItemStatus (MilestoneItemStatusID, MilestoneItemStatus, MilestoneItemStatusRepID, Active) 
	VALUES (3, N'Complete', N'33dcd33d-99f3-4bf5-b09c-5629c19946d0', 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07174', GetDate())
GO

