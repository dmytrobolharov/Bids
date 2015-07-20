

/****** Object:  StoredProcedure [dbo].[spx_BatchQueueMaterialFindReplaceColor_SELECT]    Script Date: 01/16/2011 18:06:47 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplaceColor_SELECT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplaceColor_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplaceColor_SELECT]
( 
	@BatchQueueMaterialReplaceID uniqueidentifier,
	@MaterialID uniqueidentifier
) 
AS


SELECT MaterialColorID, MaterialID, MaterialColorImageID, MaterialColorImageVersion, ColorFolderID, ColorPaletteID, ColorID, ColorCode, ColorNo, ColorName, 
      SeasonYearID, MaterialFindID, MaterialReplaceID, BatchQueueMaterialReplaceID, ColorCode + ' - ' + ColorName AS ColorFullName
FROM   dbo.vwx_BatchQueue_MaterialReplace_StyleColor_SEL
WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID AND  MaterialID = @MaterialID 
GROUP BY MaterialColorID, MaterialID, MaterialColorImageID, MaterialColorImageVersion, ColorFolderID, ColorPaletteID, ColorID, ColorCode, ColorNo, ColorName, 
      SeasonYearID, MaterialFindID, MaterialReplaceID, BatchQueueMaterialReplaceID
GO


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01012', GetDate())
GO
