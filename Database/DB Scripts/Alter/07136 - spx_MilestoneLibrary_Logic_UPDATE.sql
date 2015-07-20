IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneLibrary_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneLibrary_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneLibrary_Logic_UPDATE]
	@MilestoneID UNIQUEIDENTIFIER,
	@AssignedTo nVARCHAR(MAX)
AS
BEGIN
	
	MERGE pMilestoneAssignedTo T
	USING (SELECT at.value AS AssignedToID, @MilestoneID AS MilestoneID FROM dbo.fnx_Split(@AssignedTo, ',') at) S
	ON T.MilestoneID = S.MilestoneID AND T.AssignedToID = S.AssignedToID
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (MilestoneID, AssignedToID) VALUES(S.MilestoneID, S.AssignedToID)
	WHEN NOT MATCHED BY SOURCE THEN DELETE;	
	
	
	IF EXISTS(SELECT * FROM pMilestoneItem WHERE MilestoneID = @MilestoneID AND Duration IS NOT NULL)
	BEGIN
		UPDATE pMilestone 
			SET Duration = (SELECT SUM(Duration) 
							FROM pMilestoneItem 
							WHERE MilestoneID = @MilestoneID 
								AND Duration IS NOT NULL 
							GROUP BY MilestoneID)
	END
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07136', GetDate())
GO
