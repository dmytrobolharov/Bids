/****** Object:  StoredProcedure [dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]    Script Date: 11/28/2012 16:50:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_RadGridField_ColumnGroupByOrder_SELECT]    Script Date: 11/28/2012 16:50:08 ******/
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
	
	SELECT ColumnUniqueName, ColumnGroupByIndex FROM pRadGridFieldSort
	WHERE RadGridFormName = @FormName AND ColumnGroupByIndex <> -1 AND TeamID = @TeamID
	ORDER BY ColumnGroupByIndex
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04482', GetDate())
GO
