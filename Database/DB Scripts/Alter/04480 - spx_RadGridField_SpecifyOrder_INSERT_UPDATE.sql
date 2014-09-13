/****** Object:  StoredProcedure [dbo].[spx_RadGridField_SpecifyOrder_INSERT_UPDATE]    Script Date: 11/28/2012 16:49:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_RadGridField_SpecifyOrder_INSERT_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_RadGridField_SpecifyOrder_INSERT_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_RadGridField_SpecifyOrder_INSERT_UPDATE]    Script Date: 11/28/2012 16:49:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_RadGridField_SpecifyOrder_INSERT_UPDATE]
	@FormName NVARCHAR(200),
	@ColumnUniqueName NVARCHAR(200),
	@ColumnOrderIndex INT = -1,
	@ColumnGroupByIndex INT = -1,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	/* Inserting the new record with order for column, or updating an existing one*/
    IF NOT EXISTS(SELECT * FROM pRadGridFieldSort WHERE RadGridFormName = @FormName AND ColumnUniqueName = @ColumnUniqueName)
    BEGIN
		INSERT INTO pRadGridFieldSort (RadGridFormName, ColumnUniqueName, ColumnOrderIndex, ColumnGroupByIndex, TeamID)
		VALUES(@FormName, @ColumnUniqueName, @ColumnOrderIndex, @ColumnGroupByIndex, @TeamID)
    END
    ELSE
    BEGIN
		IF (@ColumnOrderIndex <> -1)
			UPDATE pRadGridFieldSort SET ColumnOrderIndex = @ColumnOrderIndex
			WHERE RadGridFormName = @FormName AND ColumnUniqueName = @ColumnUniqueName
			AND TeamID = @TeamID
			
		IF (@ColumnGroupByIndex <> -1)
			UPDATE pRadGridFieldSort SET ColumnGroupByIndex = @ColumnGroupByIndex
			WHERE RadGridFormName = @FormName AND ColumnUniqueName = @ColumnUniqueName
			AND TeamID = @TeamID
    END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04480', GetDate())
GO
