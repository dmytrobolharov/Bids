IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Care_SELECT]') AND type in (N'P', N'PC'))  
DROP PROCEDURE [dbo].[rpx_Style_Care_SELECT]  
GO  
  
/****** Object:  StoredProcedure [dbo].[rpx_Style_Care_SELECT]    Script Date: 06/9/2011 19:14:04 ******/  
SET ANSI_NULLS ON  
GO  
  
SET QUOTED_IDENTIFIER ON  
GO  
  
Create PROCEDURE [dbo].[rpx_Style_Care_SELECT]   
 @StyleId varchar(255),   
 @StyleSet int,  
 @ImageURL nvarchar(255) = null  
AS  
  
SELECT cw.Custom AS CareWash,  
 ('file://' + @ImageURL + '\Wash\' + RTRIM(cw.CustomKey) + '.jpg') AS CareWashImage,   
 cb.Custom AS CareBleach,  
 ('file://' + @ImageURL + '\Bleach\' + RTRIM(cb.CustomKey) + '.jpg') AS CareBleachImage,   
 cd.Custom AS CareDry,  
 ('file://' + @ImageURL + '\Dry\' + RTRIM(cd.CustomKey) + '.jpg') AS CareDryImage,   
 cc.Custom AS CareCycle,  
 ('file://' + @ImageURL + '\Cycle\' + RTRIM(cc.CustomKey) + '.jpg') AS CareCycleImage,   
 ci.Custom AS CareIron,  
 ('file://' + @ImageURL + '\Iron\' + RTRIM(ci.CustomKey) + '.jpg') AS CareIronImage,   
 dc.Custom AS CareDryClean,  
 ('file://' + @ImageURL + '\DryClean\' + RTRIM(dc.CustomKey) + '.jpg') AS CareDryCleanImage,   
 sc.StyleCareInstruction,  
 scs.Custom AS Special  
FROM pStyleCare sc LEFT OUTER JOIN  
 pStyleCareBleach cb ON sc.StyleCareBleach = cb.CustomKey LEFT OUTER JOIN  
  pStyleCareCycle cc ON sc.StyleCareCycle = cc.CustomKey LEFT OUTER JOIN  
 pStyleCareWash cw ON sc.StyleCareWash = cw.CustomKey LEFT OUTER JOIN  
 pStyleCareDry cd ON sc.StyleCareDry = cd.CustomKey LEFT OUTER JOIN  
 pStyleCareDryClean dc ON sc.StyleCareDryClean = dc.CustomKey LEFT OUTER JOIN  
 pStyleCareIron ci ON sc.StyleCareIron = ci.CustomKey LEFT OUTER JOIN  
 pStyleCareSpecial scs ON sc.StyleCareSpecial = scs.CustomKey  
WHERE ((sc.StyleId = @StyleId)   
AND (sc.StyleSet = @StyleSet))  
  
Go  
  
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01697'))  
BEGIN  
 INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)  
 VALUES     ('DB_Version', '4.1.0000', '01697', GetDate())  
END  

