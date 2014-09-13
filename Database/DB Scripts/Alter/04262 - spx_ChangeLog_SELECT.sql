IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLog_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ChangeLog_SELECT]
	@ChangeTableID UNIQUEIDENTIFIER,
	@ChangeTransTablePKID UNIQUEIDENTIFIER,
	@StartDate DATETIME,
	@EndDate DATETIME,
	@WhereCond NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00008' -- Style full changelog
	BEGIN
		SELECT * INTO #tmpChange FROM (
			-- style workflows linked on StyleID
			SELECT * FROM vwx_ChangeLogItem_SEL 
			WHERE (
					ChangeTableID IN (
						'036F8B4C-C1CC-DF11-AF06-005056C00008', 
						'00000003-C1CC-DF11-AF06-005056C00008', 
						'DD12FAAE-7ACD-DF11-AF06-005056C00008', 
						'00000002-C1CC-DF11-AF06-005056C00008',
						'00000006-C1CC-DF11-AF06-005056C00008'
					) OR ChangeTableID IN (
						SELECT c.ChangeTableID FROM pChangeTable c 
						INNER JOIN pStyleWorkflowToChangeTable sc ON sc.ChangeTableID = c.ChangeTableID 
						WHERE ChangeTableFieldName = 'StyleID'
					)
				)
				AND ChangeTablePKID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate
				
			UNION ALL
			-- style workflows linked on WorkFlowItemID
			SELECT cli.* FROM vwx_ChangeLogItem_SEL cli
			INNER JOIN pChangeTable c ON cli.ChangeTableID = c.ChangeTableID
			INNER JOIN pStyleWorkflowToChangeTable sc ON sc.ChangeTableID = c.ChangeTableID AND c.ChangeTableFieldName = 'WorkFlowItemID'
			LEFT JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = cli.ChangeTablePKID
			WHERE wi.StyleID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate
		    
			UNION ALL
			-- pStyleCare is linked on StyleCareId
			SELECT l.* FROM vwx_ChangeLogItem_SEL l INNER JOIN pStyleCare c ON c.StyleCareId = l.ChangeTablePKID    
			WHERE ChangeTableID = 'D616FAAE-7ACD-DF11-AF06-005056C00008' AND c.StyleId = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate
		) Change
	    
		EXEC('SELECT * FROM #tmpChange ' + @WhereCond)	    
		DROP TABLE #tmpChange
    END
    
    ELSE IF @ChangeTableID = '30000000-cccc-dfdf-af06-005056c00008' -- MaterialRequest full changelog
	BEGIN
		SELECT * INTO #tmpChangeDefaultMR FROM (			
			SELECT * FROM vwx_ChangeLogItemMR_SEL 
			WHERE (
					ChangeTableID IN (
						'10000000-cccc-dfdf-af06-005056c00008', 
						'10000000-caca-afaf-af06-005056c00008', 
						'20000000-cccc-dfdf-af06-005056c00008'
					) OR ChangeTableID IN (
						SELECT c.ChangeTableID FROM pChangeTable c 
						INNER JOIN pMaterialRequestToChangeTable sc ON sc.ChangeTableID = c.ChangeTableID						
					)
				)
				 AND ChangeTablePKID = @ChangeTransTablePKID
				 --IN ( select MaterialTradePartnerColorID from pMaterialTradePartnerColor 
				 --WHERE MaterialTradePartnerID in (select MaterialTradePartnerID from pMaterialTradePartnerColor where MaterialTradePartnerColorID=@ChangeTransTablePKID)
				 --and  	MaterialID in (select MaterialID from pMaterialTradePartnerColor where MaterialTradePartnerColorID=@ChangeTransTablePKID)			 
				-- )
				AND ChangeDate BETWEEN @StartDate AND @EndDate	
				
				UNION ALL
					SELECT * FROM vwx_ChangeLogItemMR_SEL 
			WHERE (
					ChangeTableID IN (
						'30000000-cccc-dfdf-af06-005056c00008' 
					) OR ChangeTableID IN (
						SELECT c.ChangeTableID FROM pChangeTable c 
						INNER JOIN pMaterialRequestToChangeTable sc ON sc.ChangeTableID = c.ChangeTableID						
					)
				)
				 AND ChangeTablePKID IN ( select MaterialTradePartnerColorID from pMaterialTradePartnerColor 
				 WHERE MaterialTradePartnerID in (select MaterialTradePartnerID from pMaterialTradePartnerColor where MaterialTradePartnerColorID=@ChangeTransTablePKID)
				 and  	MaterialID in (select MaterialID from pMaterialTradePartnerColor where MaterialTradePartnerColorID=@ChangeTransTablePKID)			 
				 )
				AND ChangeDate BETWEEN @StartDate AND @EndDate		
		) Change

		EXEC('SELECT * FROM #tmpChangeDefaultMR ' + @WhereCond)
		DROP TABLE #tmpChangeDefaultMR
    END
    
    ELSE IF @ChangeTableID = '00000010-c1cc-df11-af06-005056c00008' -- pMaterial
    BEGIN
		SELECT * INTO #tmpChangeMaterial FROM (			
			SELECT * FROM vwx_ChangeLogItemMaterial_SEL 
			WHERE ChangeTableID = @ChangeTableID AND ChangeTransTablePKID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate			
		) Change

		EXEC('SELECT * FROM #tmpChangeMaterial ' + @WhereCond)
		DROP TABLE #tmpChangeMaterial
    END
    
    ELSE IF @ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' -- pStyleMaterial
    BEGIN
		SELECT * INTO #tmpChangeStyleMaterial FROM (			
			SELECT * FROM vwx_ChangeLogItem_StyleMaterial_SEL 
			WHERE ChangeTableID = @ChangeTableID AND ChangeTransTablePKID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate			
		) Change

		EXEC('SELECT * FROM #tmpChangeStyleMaterial ' + @WhereCond)
		DROP TABLE #tmpChangeStyleMaterial
    END
    
    ELSE IF @ChangeTableID = '00000008-C1CC-DF11-AF06-005056C00008' -- pLinePlanShowroomStyleColor
    BEGIN
		SELECT * INTO #tmpChangeLinePlanShowroomStyleColor FROM (			
			SELECT * FROM vwx_ChangeLogItem_ShowroomStyleColor_SEL 
			WHERE ChangeTableID = @ChangeTableID AND ChangeTransTablePKID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate			
		) Change

		EXEC('SELECT * FROM #tmpChangeLinePlanShowroomStyleColor ' + @WhereCond)
		DROP TABLE #tmpChangeLinePlanShowroomStyleColor
    END
    ELSE IF @ChangeTableID = 'BC046C90-216E-4B97-8D9A-3D30191285CC' --pColorFolder
    BEGIN
    SELECT * INTO #tmpChangeDefaultColor FROM (			
			SELECT a.*, '' AS ColorCode FROM vwx_ChangeLogItem_SEL a 
			WHERE ChangeTableID = @ChangeTableID AND ChangeTablePKID = @ChangeTransTablePKID
				AND a.ChangeDate BETWEEN @StartDate AND @EndDate
			UNION
			SELECT a.*, ('<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(b.ColorFolderID AS NVARCHAR(40))+ '&CPID=' + CAST(b.ColorPaletteID AS NVARCHAR(40)) + '''  />') AS ColorCode
			 FROM  vwx_ChangeLogItem_SEL a LEFT OUTER JOIN
			pColorPalette b ON b.ColorPaletteID = a.ChangeTablePKID 
			WHERE ChangeTableID = '9C79E7A4-B799-4186-9A21-4EA6DB908498' AND b.ColorFolderID = @ChangeTransTablePKID --pColorPalette
			AND a.ChangeDate BETWEEN @StartDate AND @EndDate
		) Change

		EXEC('SELECT * FROM #tmpChangeDefaultColor ' + @WhereCond)
		DROP TABLE #tmpChangeDefaultColor
    END
    ELSE IF  @ChangeTableID = '7938A3FD-0580-435F-A3A6-895CA0333A8F' -- ColorSeasonYear
    BEGIN
		SELECT * INTO #tmpChangeSYColor FROM (			
			SELECT * FROM vwx_ChangeLogItem_SEL 
			WHERE ChangeTableID = @ChangeTableID AND ChangeTablePKID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate
			UNION
			SELECT a.* FROM  vwx_ChangeLogItem_SEL a LEFT OUTER JOIN
			pColorFolderSeasonYear b ON b.SeasonYearID = a.ChangeTablePKID
			WHERE ChangeTableID = '7938A3FD-0579-435F-A3A6-895CA0333A8F' AND b.ColorFolderID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate	
		) Change

		EXEC('SELECT * FROM #tmpChangeSYColor ' + @WhereCond)
		DROP TABLE #tmpChangeSYColor
    END
    
    ELSE  -- default behaviour
    BEGIN
		SELECT * INTO #tmpChangeDefault FROM (			
			SELECT * FROM vwx_ChangeLogItem_SEL 
			WHERE ChangeTableID = @ChangeTableID AND ChangeTablePKID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate			
		) Change

		EXEC('SELECT * FROM #tmpChangeDefault ' + @WhereCond)
		DROP TABLE #tmpChangeDefault
    END
    
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04262', GetDate())
GO