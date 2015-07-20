/****** Object:  StoredProcedure [dbo].[spx_MaterialContentType_SELECT]    Script Date: 04/30/2014 09:21:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContentType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialContentType_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialContentType_SELECT]    Script Date: 04/30/2014 09:21:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_MaterialContentType_SELECT]
(@MaterialId uniqueidentifier,
@MaterialContentId uniqueidentifier)
AS 

/* Added       and Active =1    This will only select material contents that are active 1    Clay 5.09.08  */

SELECT CustomKey, Custom FROM pMaterialContentType WITH (NOLOCK)
WHERE     (CustomKey NOT IN
    (SELECT     MaterialContentCode
    FROM          pMaterialContent WITH (NOLOCK)
    WHERE      MaterialID = @MaterialID AND MaterialContentId <> @MaterialContentId))
and Active = 1
ORDER BY CustomSort


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07574', GetDate())
GO