/****** Object:  StoredProcedure [dbo].[spx_RadGridField_ColumnOrder_SELECT]    Script Date: 11/28/2012 16:49:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_RadGridField_ColumnOrder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_RadGridField_ColumnOrder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_RadGridField_ColumnOrder_SELECT]    Script Date: 11/28/2012 16:49:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_RadGridField_ColumnOrder_SELECT]
	@FormName NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT ColumnUniqueName, ColumnOrderIndex FROM pRadGridFieldSort
	WHERE RadGridFormName = @FormName AND ColumnOrderIndex <> -1 AND TeamID = @TeamID
	ORDER BY ColumnOrderIndex
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04481', GetDate())
GO
