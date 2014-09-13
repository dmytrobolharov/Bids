/****** Object:  View [dbo].[vwx_StyleCADModelFabricType_Select]    Script Date: 03/22/2013 15:01:48 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleCADModelFabricType_Select]'))
DROP VIEW [dbo].[vwx_StyleCADModelFabricType_Select]
GO
/****** Object:  View [dbo].[vwx_StyleCADModelFabricType_Select]    Script Date: 03/22/2013 15:01:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

General - Rajul Radadia - April 9, 2013

*/
CREATE VIEW [dbo].[vwx_StyleCADModelFabricType_Select]
AS
SELECT DISTINCT 
	p.Piece_Image_Name as FabricType, 
	m.Model_Name, 
	m.ID 
 FROM 
	pBodyPatternSheetPiece p  
	LEFT JOIN pBodyPatternSheetModel m ON p.ModelID = m.ID   
 WHERE	
	m.Active = 1 AND p.Active = 1  

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05519', GetDate())
GO