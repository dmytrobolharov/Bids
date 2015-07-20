IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Component_Where]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOM_Component_Where]
GO
/****** Object:  StoredProcedure [dbo].[spx_Stylebom_Component_Where]    Script Date: 09/08/2011 10:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[spx_StyleBOM_Component_Where](
@MaterialID uniqueidentifier,
@MaterialVersion int,
@TeamID UNIQUEIDENTIFIER ,
@FieldSeason varchar (100), 
@FieldYear varchar (100)

)

AS 

CREATE TABLE #tmp (
	StyleID UNIQUEIDENTIFIER 
)

INSERT INTO #tmp (StyleID)
SELECT DISTINCT StyleID
FROM pStylebom a
WHERE a.MaterialID =  @MaterialID -- 
and MChange =  @MaterialVersion -- 



SELECT a.StyleSeasonYearID , a.StyleID ,c.StyleNo ,c.DesignSketchVersion, 
	c.DesignSketchID,c.SizeClass,c.SizeRange,c.Description,c.MaterialName,
	c.CustomField2,c.CustomField4
FROM pStyleSeasonYear a 
	INNER JOIN #tmp b ON a.StyleID = b.StyleID 
	INNER JOIN pStyleHeader c ON c.StyleID = b.StyleID 

DROP TABLE #tmp

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01910'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01910', GetDate())
END

GO