IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_TACal_HighlightColor]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_TACal_HighlightColor]
GO

CREATE FUNCTION [dbo].[fnx_TACal_HighlightColor]
(
    @ActualEnd DATETIME
	, @TaskRevisedEnd DATETIME
	, @TaskPlanEnd DATETIME
)

RETURNS NVARCHAR(10)

AS

BEGIN
	RETURN
	CASE 
	WHEN @ActualEnd IS NOT NULL
		THEN CASE 
				WHEN @TaskRevisedEnd IS NOT NULL
					THEN CASE 
							WHEN CAST(@TaskPlanEnd AS DATE) >= CAST(@TaskRevisedEnd AS DATE)
								THEN CASE 
										WHEN CAST(@ActualEnd AS DATE) > CAST(@TaskPlanEnd AS DATE)
											THEN '#FF6868'
										WHEN CAST(@ActualEnd AS DATE) > CAST(@TaskRevisedEnd AS DATE)
											THEN '#ffff68'
										ELSE NULL
										END
							ELSE CASE 
									WHEN CAST(@ActualEnd AS DATE) > CAST(@TaskRevisedEnd AS DATE)
										THEN '#FF6868'
									WHEN CAST(@ActualEnd AS DATE) > CAST(@TaskPlanEnd AS DATE)
										THEN '#ffff68'
									ELSE NULL
									END
							END
				ELSE CASE 
						WHEN CAST(@ActualEnd AS DATE) > CAST(@TaskPlanEnd AS DATE)
							THEN '#FF6868'
						ELSE NULL
						END
				END
	ELSE CASE 
			WHEN @TaskRevisedEnd IS NOT NULL
				THEN CASE 
						WHEN CAST(@TaskPlanEnd AS DATE) >= CAST(@TaskRevisedEnd AS DATE)
							THEN CASE 
									WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(@TaskPlanEnd AS DATE)
										THEN '#FF6868'
									WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(@TaskRevisedEnd AS DATE)
										THEN '#ffff68'
									ELSE NULL
									END
						ELSE CASE 
								WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(@TaskRevisedEnd AS DATE)
									THEN '#FF6868'
								ELSE '#ffff68'
								END
						END
			ELSE CASE 
					WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(@TaskPlanEnd AS DATE)
						THEN '#FF6868'
					ELSE NULL
					END
			END
	END
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09090', GetDate())
GO
