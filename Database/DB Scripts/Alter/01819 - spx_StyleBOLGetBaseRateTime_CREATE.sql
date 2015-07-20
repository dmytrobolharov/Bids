SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOLGetBaseRateTime]
(
@StyleID nvarchar(50),
@StyleSet int,
@IsException int
)
AS
BEGIN

-- Total time for BOL Page without exceptions
IF @IsException = 0
BEGIN
	(SELECT V1.BaseRateId, 'Total time ' + T1.RateCode AS RateCode, sum (((V1.SAM * ISNULL(V1.Coef,1)) + (V1.SAM * ISNULL(V1.Coef,1) * CAST(ISNULL(V1.Adj,0) as numeric(10,2)) / 100))) AS TotalTime, T1.Sort FROM vw_StyleBOL_SELECT AS V1 INNER JOIN
		(SELECT BaseRateTypeId,RateCode, 0 AS Sort FROM pBOLBaseRateType UNION SELECT '00000000-0000-0000-0000-000000000000' AS BaseRateTypeId,'Other' AS RateCode, 1 As Sort) AS T1 ON V1.BaseRateId = T1.BaseRateTypeId
	WHERE V1.MacroId IS NULL and V1.StyleID = @StyleID and V1.StyleSet = @StyleSet and V1.IsException = @IsException
	GROUP BY T1.Sort,V1.BaseRateId, T1.RateCode)
	UNION
	(SELECT '00000000-0000-0000-0000-000000000000' AS BaseRateId, 'Total Time ' AS RateCode, sum (((V1.SAM * ISNULL(V1.Coef,1)) + (V1.SAM * ISNULL(V1.Coef,1) * CAST(ISNULL(V1.Adj,0) as numeric(10,2)) / 100))) AS TotalTime, 2 AS Sort FROM vw_StyleBOL_SELECT AS V1
	WHERE V1.MacroId IS NULL and V1.StyleID = @StyleID and V1.StyleSet = @StyleSet and V1.IsException = @IsException)
	ORDER BY Sort
END

-- Total time for BOL Page with Exceptions
IF @IsException = 1
BEGIN
	(SELECT V1.BaseRateId, 'Total time ' + T1.RateCode AS RateCode, sum (((V1.SAM * ISNULL(V1.Coef,1)) + (V1.SAM * ISNULL(V1.Coef,1) * CAST(ISNULL(V1.Adj,0) as numeric(10,2)) / 100))) AS TotalTime, T1.Sort FROM vw_StyleBOL_SELECT AS V1 INNER JOIN
		(SELECT BaseRateTypeId,RateCode, 0 AS Sort FROM pBOLBaseRateType UNION SELECT '00000000-0000-0000-0000-000000000000' AS BaseRateTypeId,'Other' AS RateCode, 1 As Sort) AS T1 ON V1.BaseRateId = T1.BaseRateTypeId
	WHERE V1.MacroId IS NULL and V1.StyleID = @StyleID and V1.StyleSet = @StyleSet
	GROUP BY T1.Sort,V1.BaseRateId, T1.RateCode)
	UNION
	(SELECT '00000000-0000-0000-0000-000000000000' AS BaseRateId, 'Total Time ' AS RateCode, sum (((V1.SAM * ISNULL(V1.Coef,1)) + (V1.SAM * ISNULL(V1.Coef,1) * CAST(ISNULL(V1.Adj,0) as numeric(10,2)) / 100))) AS TotalTime, 2 AS Sort FROM vw_StyleBOL_SELECT AS V1
	WHERE V1.MacroId IS NULL and V1.StyleID = @StyleID and V1.StyleSet = @StyleSet)
	ORDER BY Sort
END


END


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01819'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01819', GetDate())
END

GO
