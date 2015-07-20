/****** Object:  StoredProcedure [dbo].[spx_ImageUnversioned_SELECT]    Script Date: 7/16/2014 12:04:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ImageUnversioned_SELECT]
(@ImageID uniqueidentifier)
AS 



SELECT  ISNULL(Unversioned,0) AS Unversioned
FROM   pImage WITH (NOLOCK)
WHERE  (ImageID = @ImageID)
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08345', GetDate())
GO
