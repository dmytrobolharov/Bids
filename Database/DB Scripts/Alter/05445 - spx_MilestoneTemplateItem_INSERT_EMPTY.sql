/****** Object:  StoredProcedure [dbo].[spx_MilestoneTemplateItem_INSERT_EMPTY]    Script Date: 03/29/2013 13:30:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItem_INSERT_EMPTY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItem_INSERT_EMPTY]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItem_INSERT_EMPTY]
	@MilestoneTemplateID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	INSERT INTO pMilestoneTemplateItem(MilestoneTemplateID, CUser, CDate, MUser, MDate)
	VALUES(@MilestoneTemplateID, @CUser, @CDate, @CUser, @CDate)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05445', GetDate())
GO
