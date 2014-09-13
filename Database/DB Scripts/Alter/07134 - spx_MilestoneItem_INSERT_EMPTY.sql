IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneItem_INSERT_EMPTY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneItem_INSERT_EMPTY]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneItem_INSERT_EMPTY]
	@MilestoneID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @Sort INT = (SELECT MAX(CASE WHEN ISNUMERIC(Sort) = 1 THEN CAST(Sort as INT) ELSE 0 END) + 1 FROM pMilestoneItem)
	if @Sort IS NULL
		set @Sort = 1
	
	INSERT INTO pMilestoneItem(MilestoneID, DependencyID, CUser, CDate, MUser, MDate, Sort)
	VALUES(@MilestoneID, '00000000-0000-0000-0000-000000000000', @CUser, @CDate, @CUser, @CDate, @Sort)
	
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07134', GetDate())
GO
