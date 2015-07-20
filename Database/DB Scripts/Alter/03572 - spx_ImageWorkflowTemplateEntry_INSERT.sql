/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowTemplateEntry_INSERT]    Script Date: 05/29/2012 17:48:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowTemplateEntry_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowTemplateEntry_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowTemplateEntry_INSERT]    Script Date: 05/29/2012 17:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ImageWorkflowTemplateEntry_INSERT]
	@ImageWorkflowTemplateItemID UNIQUEIDENTIFIER,
	@ImageWorkflowTemplateID UNIQUEIDENTIFIER,
	@Sort VARCHAR(4),
	@CreatedBy NVARCHAR(200),
	@CreatedDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS(SELECT * FROM pImageWorkflowTemplateEntry 
					WHERE ImageWorkflowTemplateID = @ImageWorkflowTemplateID AND ImageWorkflowTemplateItemID = @ImageWorkflowTemplateItemID)
	BEGIN
		INSERT INTO pImageWorkflowTemplateEntry(ImageWorkflowTemplateID, ImageWorkflowTemplateItemID, Sort, Active,
			CUser, CDate, MUser, MDate)
		VALUES(@ImageWorkflowTemplateID, @ImageWorkflowTemplateItemID, @Sort, 1,
			@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03572', GetDate())
GO 