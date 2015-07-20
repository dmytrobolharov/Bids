IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SaveSearchItemTemp_CLEAN]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SaveSearchItemTemp_CLEAN]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SaveSearchItemTemp_CLEAN]
	@TeamID uniqueidentifier
AS

DELETE FROM pSavedSearchItemTemp 
WHERE TeamID = @TeamID 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03938', GetDate())
GO
