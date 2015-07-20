IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageNewDesc_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageNewDesc_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ImageNewDesc_Update] (
@ImageID UNIQUEIDENTIFIER , 
@ImageDesc nVARCHAR(200)
)
AS 
BEGIN
	UPDATE pImage SET ImageDescription = @ImageDesc WHERE ImageID = @ImageID 
END 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03720', GetDate())
GO