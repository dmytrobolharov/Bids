/****** Object:  View [dbo].[vwx_StylePOM_Select]    Script Date: 03/22/2013 15:01:48 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StylePOM_Select]'))
DROP VIEW [dbo].[vwx_StylePOM_Select]
GO
/****** Object:  View [dbo].[vwx_StylePOM_Select]    Script Date: 03/22/2013 15:01:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

General - Rajul Radadia - March 22, 2013

*/
CREATE VIEW [dbo].[vwx_StylePOM_Select]
AS
SELECT 	p.AMLMeasPOMId, 
		p.IsLength, 
		p.IsWidth, 
		p.SortId, 
		p.POM_Row, 
		p.Refcode, 
		p.Description, 
		COALESCE(TolPlus,0) as TolPlus, 
		COALESCE(TolMinus,0) as TolMinus,  
        i.Incr, 
		p.BeforeTreat, 
		p.ShrinkX, 
		p.ShrinkY, 
		p.FabricType, 
		p.CADModelId 
FROM 	pamlmeaspom p, 
		pamlmeasigc i 
WHERE 	p.amlmeashdrid=i.amlmeashdrid AND 
		p.AMLMeasPOMId=i.AMLMeasPOMId AND 
		p.POM_Row=i.POM_Row

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05396', GetDate())
GO