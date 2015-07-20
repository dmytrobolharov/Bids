IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContentType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialContentType_SELECT]
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
ORDER BY Custom

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07405', GetDate())
GO
