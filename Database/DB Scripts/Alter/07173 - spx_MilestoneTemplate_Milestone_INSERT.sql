IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplate_Milestone_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplate_Milestone_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplate_Milestone_INSERT]
	@MilestoneTemplateID UNIQUEIDENTIFIER,
	@MilestoneID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @MilestoneTemplateItemID UNIQUEIDENTIFIER = NEWID(),
			@SortOrder INT
	
	SELECT @SortOrder = MAX(CASE WHEN ISNUMERIC(SortOrder) = 1 THEN CAST(SortOrder AS INT) ELSE 0 END) + 1
	FROM pMilestoneTemplateItem WHERE @MilestoneTemplateID = @MilestoneTemplateID
	IF @SortOrder IS NULL SET @SortOrder = 1
	
	INSERT INTO pMilestoneTemplateItem(MilestoneTemplateItemID, MilestoneTemplateID, 
		MilestoneTemplateItemName, MilestoneTemplateItemDescription, Days, AlertDays,
		SortOrder, CUser, CDate, MUser, MDate)
	SELECT @MilestoneTemplateItemID, @MilestoneTemplateID, 
		MilestoneName, MilestoneDescription, Duration, 0,
		RIGHT('0000' + CAST(@SortOrder AS nVARCHAR(4)), 4), @CUser, @CDate, @CUser, @CDate 
	FROM pMilestone WHERE MilestoneID = @MilestoneID
	
	DECLARE @Items TABLE(ItemNewID UNIQUEIDENTIFIER, ItemOldID UNIQUEIDENTIFIER)
	INSERT INTO @Items(ItemNewID, ItemOldID) 
	SELECT NEWID(), MilestoneItemID FROM pMilestoneItem WHERE MilestoneID = @MilestoneID
	
	INSERT INTO pMilestoneTemplateItem(MilestoneTemplateItemID, MilestoneTemplateID, 
		MilestoneTemplateItemName, MilestoneTemplateItemDescription, Days, AlertDays,		
		DependentWorkflowTypeID, DependencyID, SortOrder, ParentID,
		CUser, CDate, MUser, MDate)
	SELECT i.ItemNewID, @MilestoneTemplateID, 
		mi.MilestoneItemName, mi.MilestoneItemDescription, mi.Duration, mi.AlertDays,		
		mi.DependentWorkflowTypeID, i2.ItemNewID, mi.Sort, @MilestoneTemplateItemID,
		@CUser, @CDate, @CUser, @CDate 
	FROM @Items i
	INNER JOIN pMilestoneItem mi ON i.ItemOldID = mi.MilestoneItemID
	LEFT JOIN @Items i2 ON mi.DependencyID = i2.ItemOldID
	WHERE MilestoneID = @MilestoneID
	
	INSERT INTO pMilestoneTemplateItemWorkflow(MilestoneTemplateItemID, WorkflowID)
	SELECT i.ItemNewID, miw.WorkflowID
	FROM @Items i
	INNER JOIN pMilestoneItemWorkflow miw ON i.ItemOldID = miw.MilestoneItemID
	
	INSERT INTO pMilestoneTemplateItemWorkflowStatus(MilestoneTemplateItemID, WorkflowStatusID)
	SELECT i.ItemNewID, miws.WorkflowStatusID
	FROM @Items i
	INNER JOIN pMilestoneItemWorkflowStatus miws ON i.ItemOldID = miws.MilestoneItemID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07173', GetDate())
GO
