-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 10 May 2012	                                                                        */
-- * WorkItem #8296										*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_Sample_StyleSeasonYear_SELECTED]    Script Date: 05/10/2012 18:55:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_StyleSeasonYear_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_StyleSeasonYear_SELECTED]
GO


/****** Object:  StoredProcedure [dbo].[spx_Sample_StyleSeasonYear_SELECTED]    Script Date: 05/10/2012 18:55:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_Sample_StyleSeasonYear_SELECTED]  (  
@StyleID UNIQUEIDENTIFIER ,
@SampleRequestTradeID UNIQUEIDENTIFIER,
@FlagBOM INT 
)  
AS
BEGIN
	IF @FlagBOM=0
	BEGIN
		SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear   
		FROM pStyleSeasonYear a  
		INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
		INNER JOIN   dbo.pSampleRequestTrade c ON a.StyleSeasonYearID = c.StyleSeasonYearID
		WHERE a.StyleID = @StyleID  AND c.SampleRequestTradeID = @SampleRequestTradeID
		ORDER BY b.CurrentSeason DESC, b.Year DESC, b.Season  
	END
	ELSE
	BEGIN
		SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear   
		FROM pStyleSeasonYear a  
		INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
		INNER JOIN   dbo.pSampleRequestBOMTrade c ON a.StyleSeasonYearID = c.StyleSeasonYearID
		WHERE a.StyleID = @StyleID  AND c.SampleRequestTradeID = @SampleRequestTradeID
		ORDER BY b.CurrentSeason DESC, b.Year DESC, b.Season  
	END 
END
GO




	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03433', GetDate())



GO
