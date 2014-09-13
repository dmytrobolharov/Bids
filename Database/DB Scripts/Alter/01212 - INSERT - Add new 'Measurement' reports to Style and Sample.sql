BEGIN TRANSACTION
	BEGIN TRY
		
		/*Delelete old records before inserts*/
		DELETE
		FROM rReportStylePageItem
		WHERE ReportFormName = 'Style_MeasurementImperial_Body_LLT'
			OR ReportFormName = 'Style_MeasurementMetric_Body_LLT'
			OR ReportFormName = 'Style_MeasurementWorkSheet_Body_LLT'
		
		/*Style Measurement Workflow - Imperial*/
		INSERT INTO [rReportStylePageItem](
			[ReportPageID]
			,[ReportMapID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportSrmOn]
		)
		VALUES(
			'CAF68662-E70F-442F-BDBA-2EDE1B3CB0DB'
			,'40000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Measurement Imperial View'
			,'Style Measurement'
			,'SQL'
			,'Style_Measurement_Imperial_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,1
			,'PDF'
			,1
		)
		
		/*Style Measurement Workflow - Metric*/
		INSERT INTO [rReportStylePageItem](
			[ReportPageID]
			,[ReportMapID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportSrmOn]
		)
		VALUES(
			'B9A5DC32-DC70-49D0-A345-68C8CBE8449E'
			,'40000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Measurement Metric View'
			,'Style Measurement'
			,'SQL'
			,'Style_Measurement_Metric_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,1
			,'PDF'
			,1
		)
		
		/*Style Measurement Workflow - Worksheet*/
		INSERT INTO [rReportStylePageItem](
			[ReportPageID]
			,[ReportMapID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportSrmOn]
		)
		VALUES(
			'DCFD6435-E77A-48B5-81C2-E0B5D42750E1'
			,'40000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Measurement WorkSheet'
			,'Style Measurement'
			,'SQL'
			,'Style_Measurement_Worksheet_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,1
			,'PDF'
			,1
		)

		/*Style Measurement Workflow - Sample*/
		INSERT INTO [rReportStylePageItem](
			[ReportPageID]
			,[ReportMapID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportSrmOn]
		)
		VALUES(
			'DCFD6435-E77A-48B5-81C2-E0B5D42750E2'
			,'40000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Measurement Sample'
			,'Style Measurement'
			,'SQL'
			,'Style_Measurement_Sample_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,1
			,'PDF'
			,1
		)

		/*Style Measurement Workflow - How to Measure*/
		INSERT INTO [rReportStylePageItem](
			[ReportPageID]
			,[ReportMapID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportSrmOn]
		)
		VALUES(
			'DCFD6435-E77A-48B5-81C2-E0B5D42750E3'
			,'40000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Measurement - How To Measure'
			,'Style Measurement'
			,'SQL'
			,'Style_Measurement_HowToMeasure_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,1
			,'PDF'
			,1
		)

		/*Sample Request Submit - Measurement*/
		INSERT INTO [rReportSampleRequestSubmitItem](
			[ReportSampleRequestSubmitPageID]
			,[ReportSampleRequestSubmitFolderID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportPageApproved]
			,[ReportPageSort]
		)
		VALUES(
			'0004EA80-C34C-4BBD-8F35-E1DBCAA76000'
			,'F1000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'SampleRequestSubmit_SpecImage_Header_LLT'
			,'Sample Header'
			,'Sample Request Header'
			,'SQL'
			,'SampleRequestSubmit_Measurement_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleID'
			,1
			,'PDF'
			,0
			,'009'
		)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH
	GO
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
    VALUES ('DB_Version', '4.0.0000', '01212', GetDate())
GO
