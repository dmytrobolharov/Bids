IF NOT EXISTS (SELECT * FROM pStyleRemovalReason WHERE RemovalReason = 'Internal Cancel' AND RemovalReasonCode = 1)
BEGIN
	INSERT INTO pStyleRemovalReason
	SELECT NEWID(), 1, 'Internal Cancel', NULL, NULL, NULL, NULL, 1
END

IF NOT EXISTS (SELECT * FROM pStyleRemovalReason WHERE RemovalReason = 'Customer Cancel' AND RemovalReasonCode = 2)
BEGIN
	INSERT INTO pStyleRemovalReason
	SELECT NEWID(), 2, 'Customer Cancel', NULL, NULL, NULL, NULL, 1
END

IF NOT EXISTS (SELECT * FROM pStyleRemovalReason WHERE RemovalReason = 'Duplicate Style' AND RemovalReasonCode = 3)
BEGIN
	INSERT INTO pStyleRemovalReason
	SELECT NEWID(), 3, 'Duplicate Style', NULL, NULL, NULL, NULL, 1
END

IF NOT EXISTS (SELECT * FROM pStyleRemovalReason WHERE RemovalReason = 'Other' AND RemovalReasonCode = 4)
BEGIN
	INSERT INTO pStyleRemovalReason
	SELECT NEWID(), 4, 'Other', NULL, NULL, NULL, NULL, 1
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04972', GetDate())
GO
