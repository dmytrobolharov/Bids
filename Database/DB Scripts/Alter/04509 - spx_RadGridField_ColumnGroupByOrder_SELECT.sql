/****** Object:  StoredProcedure [dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]    Script Date: 11/30/2012 13:38:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]    Script Date: 11/30/2012 13:38:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]
	@FormName NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT ColumnUniqueName, ColumnGroupByIndex, ColumnGroupBySortOrder FROM pRadGridFieldSort
	WHERE RadGridFormName = @FormName AND ColumnGroupByIndex <> -1 AND TeamID = @TeamID
	ORDER BY ColumnGroupByIndex
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04509', GetDate())
GO

