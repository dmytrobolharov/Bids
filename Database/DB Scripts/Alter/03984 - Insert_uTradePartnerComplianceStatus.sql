if not exists (select * from [uTradePartnerComplianceStatus] WHERE [StatusId] = '00000000-0000-0000-0000-000000000000')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceStatus]
           ([StatusId]           
           ,[StatusCode]
           ,[StatusDesc]
           ,[Sort]
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000000'           
           ,''
           ,''
           ,0
           ,1 
        )

	end
GO

if not exists (select * from [uTradePartnerComplianceStatus] WHERE [StatusId] = '00000000-0000-0000-0000-000000000001')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceStatus]
           ([StatusId]           
           ,[StatusCode]
           ,[StatusDesc]
           ,[Sort]
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000001'           
           ,'F'
           ,'FAIL'
           ,1
           ,1
           )
	end
GO


if not exists (select * from [uTradePartnerComplianceStatus] WHERE [StatusId] = '00000000-0000-0000-0000-000000000002')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceStatus]
           ([StatusId]           
           ,[StatusCode]
           ,[StatusDesc]
           ,[Sort]
           ,[Active]
           )
		 VALUES
           ('00000000-0000-0000-0000-000000000002'           
           ,'P'
           ,'PASS'
           ,2
           ,1
           )
	end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03984', GetDate())
GO