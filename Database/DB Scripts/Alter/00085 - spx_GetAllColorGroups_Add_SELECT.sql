IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetAllColorGroups_Add_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GetAllColorGroups_Add_SELECT]
GO

ALTER TABLE pColorGroup 
DROP COLUMN SizeHomeID
  
GO  

ALTER TABLE pColorGroup ADD
	CustomField1 nvarchar(200) NULL,
    CustomField2 nvarchar(200) NULL,
    Active int NULL

GO

CREATE PROCEDURE [dbo].[spx_GetAllColorGroups_Add_SELECT]  (
 @StyleID UNIQUEIDENTIFIER,
 @StyleSet int,
 @SeasonYearID NVARCHAR(50)= NULL 
)
AS
BEGIN 

 IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
  Select * from pColorGroup AS CG where CG.ColorGroupID NOT IN (Select ColorGroupID FROM pStyleColorGroup Where StyleID= @StyleID and StyleSet=@StyleSet and SeasonYearID=@SeasonYearID) AND CG.Active = 1 order by Sort, ColorGroupName  
 ELSE  
  Select * from pColorGroup AS CG where CG.ColorGroupID NOT IN (Select ColorGroupID FROM pStyleColorGroup Where StyleID= @StyleID and StyleSet=@StyleSet) AND CG.Active = 1 order by Sort, ColorGroupName  
  
END 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '085', GetDate())

GO
