IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Where_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_Where_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_Material_Where_SELECT](
@MaterialID UNIQUEIDENTIFIER, 
@TeamID UNIQUEIDENTIFIER 
) 
AS 


	SELECT a.MaterialID, a.MChange 
    FROM pStyleMaterials a , pStyleHeader b  
    WHERE a.StyleID = b.StyleID 
	AND b.StyleType IN ( 
		SELECT StyleTypeID FROM sAccessStyleFolder 
		WHERE ( AccessRoleId =3 OR AccessView = 1 )  
		AND TeamId = @TeamId  
	) 
    GROUP BY a.MChange, a.MaterialID
    HAVING a.MaterialID = @MaterialID  
    UNION
    SELECT a.MaterialID, a.MChange 
    FROM pStyleBOM a , pStyleHeader b  
    WHERE a.StyleID = b.StyleID 
	AND b.StyleType IN ( 
		SELECT StyleTypeID FROM sAccessStyleFolder 
		WHERE ( AccessRoleId =3 OR AccessView = 1 )  
		AND TeamId = @TeamId  
	) 
    GROUP BY a.MChange, a.MaterialID
    HAVING a.MaterialID = @MaterialID  
    ORDER BY a.MChange DESC 
    


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03140'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03140', GetDate())

END
GO

