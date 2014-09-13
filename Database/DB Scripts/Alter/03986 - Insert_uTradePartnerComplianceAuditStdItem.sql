if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'CL')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
           ([AuditStandardId]
           ,[AuditStandardItemCode]
           ,[AuditStandardItemName]           
           ,[Sort]
           ,[Active]
	      )
		VALUES
           ('00000000-0000-0000-0000-000000000001'
           ,'CL'
           ,'Child Labor'           
           ,1
           ,1
           )
	end
GO

if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'FCL')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
           ([AuditStandardId]
           ,[AuditStandardItemCode]
           ,[AuditStandardItemName]           
           ,[Sort]
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000001'
           ,'FCL'
           ,'Forced and Compulsory Labor'           
           ,2
           ,1
           )
		end
GO

if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'HS')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
				   ([AuditStandardId]
				   ,[AuditStandardItemCode]
				   ,[AuditStandardItemName]           
				   ,[Sort]
				   ,[Active]
				   )
			 VALUES
				   ('00000000-0000-0000-0000-000000000001'
				   ,'HS'
				   ,'Health and Safety'           
				   ,3
				   ,1
				   )
	end
GO

if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'FARCB')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
           ([AuditStandardId]
           ,[AuditStandardItemCode]
           ,[AuditStandardItemName]           
           ,[Sort]
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000001'
           ,'FARCB'
           ,'Freedom of Association and Right to Collective Bargaining'          
           ,4
           ,1
           )
	end 
GO

if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'DIS')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
			([AuditStandardId]
			,[AuditStandardItemCode]
			,[AuditStandardItemName]           
			,[Sort]
			,[Active]
			)
		VALUES
			('00000000-0000-0000-0000-000000000001'
			,'DIS'
			,'Discrimination'           
			,5
			,1
			)
	end
GO

if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'DP')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
           ([AuditStandardId]
           ,[AuditStandardItemCode]
           ,[AuditStandardItemName]           
           ,[Sort]
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000001'
           ,'DP'
           ,'Disciplinary Practices'           
           ,6
           ,1
           )
	end
GO

if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'WH')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
           ([AuditStandardId]
           ,[AuditStandardItemCode]
           ,[AuditStandardItemName]           
           ,[Sort]
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000001'
           ,'WH'
           ,'Working Hours'           
           ,7
           ,1
           )
	end
GO

if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'RN')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
           ([AuditStandardId]
           ,[AuditStandardItemCode]
           ,[AuditStandardItemName]           
           ,[Sort]
           ,[Active]
           )
		VALUES
           ('00000000-0000-0000-0000-000000000001'
           ,'RN'
           ,'Remuneration'           
           ,8
           ,1
           )
	end
GO

if not exists (select * from [uTradePartnerComplianceAuditStandardItem] WHERE [AuditStandardItemCode] = 'MS')
	begin
		INSERT INTO [dbo].[uTradePartnerComplianceAuditStandardItem]
           ([AuditStandardId]
           ,[AuditStandardItemCode]
           ,[AuditStandardItemName]           
           ,[Sort]
           ,[Active]
           )
		 VALUES
           ('00000000-0000-0000-0000-000000000001'
           ,'MS'
           ,'Management Systems'           
           ,9
           ,1
           )
	end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03986', GetDate())
GO