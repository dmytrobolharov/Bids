IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarHeader_Copy]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarHeader_Copy]
GO


CREATE PROCEDURE [dbo].[spx_CalendarHeader_Copy]
	@CalendarHeaderID UNIQUEIDENTIFIER,
	@NewCalendarHeaderID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME 
AS
BEGIN

	-- copy calendar header record
	INSERT INTO pCalendarHeader (CalendarHeaderID, CalendarName, MilestoneTemplateID, 
		StartDate, EndDate, SeasonYearID, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, 
		CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, 
		Active, Sort, CDate, CUser, MDate, MUser)
	SELECT @NewCalendarHeaderID, CalendarName + ' - copy', MilestoneTemplateID, 
		StartDate, EndDate, SeasonYearID, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, 
		CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, 
		Active, Sort, @CDate, @CUser, @CDate, @CUser
	FROM pCalendarHeader 
	WHERE CalendarHeaderID = @CalendarHeaderID
	
	INSERT INTO pCalendarHeaderToDivision (CalendarHeaderToDivisionID, CalendarHeaderID, DivisionID)
	SELECT NEWID(), @NewCalendarHeaderID, DivisionID
	FROM pCalendarHeaderToDivision 
	WHERE CalendarHeaderID = @CalendarHeaderID
	
	-- copy line lists
	INSERT INTO pCalendarLineFolder(CalendarHeaderID, LineFolderID)
	SELECT @NewCalendarHeaderID, LineFolderID
	FROM pCalendarLineFolder 
	WHERE CalendarHeaderID = @CalendarHeaderID
	
	-- copy milestone items
	CREATE TABLE #NewToOld_Item (
		CalendarMilestoneItemID uniqueidentifier, 
		NewCalendarMilestoneItemID uniqueidentifier
	)
	
	INSERT INTO #NewToOld_Item (CalendarMilestoneItemID, NewCalendarMilestoneItemID)
	SELECT CalendarMilestoneItemID, NEWID()
	FROM pCalendarMilestoneItem 
	WHERE CalendarHeaderID = @CalendarHeaderID

	INSERT INTO pCalendarMilestoneItem (CalendarMilestoneItemID, CalendarHeaderID, MilestoneTemplateItemID, 
		CalendarMilestoneItemName, CalendarMilestoneItemDescription, DependentWorkflowTypeID, 
		[Days], MilestoneDate, SortOrder, CUser, CDate, MUser, MDate)
	SELECT #NewToOld_Item.NewCalendarMilestoneItemID, @NewCalendarHeaderID, MilestoneTemplateItemID, 
		CalendarMilestoneItemName, CalendarMilestoneItemDescription, DependentWorkflowTypeID, 
		[Days], MilestoneDate, SortOrder, @CUser, @CDate, @CUser, @CDate
	FROM pCalendarMilestoneItem INNER JOIN #NewToOld_Item ON pCalendarMilestoneItem.CalendarMilestoneItemID = #NewToOld_Item.CalendarMilestoneItemID
	
	INSERT INTO pCalendarMilestoneItemWorkflow (CalendarMilestoneItemID, WorkflowID)
	SELECT #NewToOld_Item.NewCalendarMilestoneItemID, WorkflowID
	FROM pCalendarMilestoneItemWorkflow INNER JOIN #NewToOld_Item ON pCalendarMilestoneItemWorkflow.CalendarMilestoneItemID = #NewToOld_Item.CalendarMilestoneItemID

	INSERT INTO pCalendarMilestoneItemWorkflowStatus (CalendarMilestoneItemID, WorkflowStatusID)
	SELECT #NewToOld_Item.NewCalendarMilestoneItemID, WorkflowStatusID
	FROM pCalendarMilestoneItemWorkflowStatus INNER JOIN #NewToOld_Item ON pCalendarMilestoneItemWorkflowStatus.CalendarMilestoneItemID = #NewToOld_Item.CalendarMilestoneItemID
	
	DROP TABLE #NewToOld_Item

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05494', GetDate())
GO
