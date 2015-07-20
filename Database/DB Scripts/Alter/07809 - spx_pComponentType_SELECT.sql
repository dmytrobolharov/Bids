IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pComponentType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pComponentType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_pComponentType_SELECT] (@ComponentTypeID int)
AS 

SELECT     *
FROM         dbo.pComponentType WITH (NOLOCK)
WHERE     (ComponentTypeID =  @ComponentTypeID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07809', GetDate())
GO
