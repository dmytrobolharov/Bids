IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Care_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Care_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rpx_Style_Care_SELECT] 
	@StyleId varchar(255), 
	@StyleSet int
AS

SELECT	cw.Custom AS CareWash,
	dbo.fnx_GetStreamingCareImagePath(RTRIM(cw.CustomKey), 'Wash') AS CareWashImage, 
	cb.Custom AS CareBleach,
	dbo.fnx_GetStreamingCareImagePath(RTRIM(cb.CustomKey), 'Bleach') AS CareBleachImage, 
	cd.Custom AS CareDry,
	dbo.fnx_GetStreamingCareImagePath(RTRIM(cd.CustomKey), 'Dry') AS CareDryImage,
	cc.Custom AS CareCycle,
	dbo.fnx_GetStreamingCareImagePath(RTRIM(cc.CustomKey), 'Cycle') AS CareCycleImage,
	ci.Custom AS CareIron,
	dbo.fnx_GetStreamingCareImagePath(RTRIM(ci.CustomKey), 'Iron') AS CareIronImage,
	dc.Custom AS CareDryClean,
	dbo.fnx_GetStreamingCareImagePath(RTRIM(dc.CustomKey), 'DryClean') AS CareDryCleanImage,
	sc.StyleCareInstruction,
	scs.Custom AS Special
FROM	pStyleCare sc LEFT OUTER JOIN
	pStyleCareBleach cb ON sc.StyleCareBleach = cb.CustomKey LEFT OUTER JOIN
 	pStyleCareCycle cc ON sc.StyleCareCycle = cc.CustomKey LEFT OUTER JOIN
	pStyleCareWash cw ON sc.StyleCareWash = cw.CustomKey LEFT OUTER JOIN
	pStyleCareDry cd ON sc.StyleCareDry = cd.CustomKey LEFT OUTER JOIN
	pStyleCareDryClean dc ON sc.StyleCareDryClean = dc.CustomKey LEFT OUTER JOIN
	pStyleCareIron ci ON sc.StyleCareIron = ci.CustomKey LEFT OUTER JOIN
	pStyleCareSpecial scs ON sc.StyleCareSpecial = scs.CustomKey
WHERE	((sc.StyleId = @StyleId) 
AND (sc.StyleSet = @StyleSet))

Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01709'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01709', GetDate())
END
GO