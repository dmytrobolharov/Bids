IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Component_WhereUsed]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Component_WhereUsed]
GO


CREATE PROCEDURE [dbo].[spx_Style_Component_WhereUsed](
@MaterialID uniqueidentifier,
@TeamID UNIQUEIDENTIFIER ,
@WhereClause nvarchar (500)


)

AS 


		SELECT DISTINCT qwer.* INTO #tmp0 FROM (	
		SELECT c.*,b.MChange
		FROM pStyleMaterials b
			INNER JOIN vwx_StyleHeader_SEL c ON c.StyleID = b.StyleID
			WHERE b.MaterialID = @MaterialID
		UNION
			SELECT c.*,a.MChange
		FROM pStyleBOM a 
			INNER JOIN vwx_StyleHeader_SEL c ON c.StyleID = a.StyleID
			--INNER JOIN pStyleMaterials psm ON psm.MaterialID = a.MaterialID
			WHERE a.MaterialID = @MaterialID) qwer
			
			EXEC('SELECT * FROM #tmp0 ' + @WhereClause)
			
			DROP TABLE #tmp0
			
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08376', GetDate())
GO

