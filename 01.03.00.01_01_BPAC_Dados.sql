USE BNP_Bolsa

DROP PROCEDURE IF EXISTS dbo.SP_BOL_EventosInventario;

create procedure dbo.SP_BOL_EventosInventario
(@empresaId int,
@dataMovimento date,
@tipoMovimento int
)
 
as
 
begin
 
    declare @numeroLote int,
	@codigoCliente int
 
	select @codigoCliente = CodCliente from Cli_IntDiversos where CodSistema = 80 and CodIntegracao = @empresaid
 
	set @numeroLote = (select max(nApurcEvntoCtbil) from Cbv_EvntoCtbilApura
					   join CBV_Instituicao
					     on CBV_Instituicao.Id = Cbv_EvntoCtbilApura.nInstcEvnto
					   where dApurcEvnto = @dataMovimento
					     and CBV_instituicao.ClienteId = @codigoCliente)
	select
	  dApurcEvnto as dataMovimento,
	  @empresaId as empresaId,
	  @tipoMovimento as tipoMovimento,
	  @numeroLote as numeroLote,
	  cEvntoCtbil as codigoEvento,
 
	  (case CBV_evntoCtbilApura.cTpoCategEvntoApura when 1 then 'LN' when 2 then 'DV' when 3 then 'MV' when 4 then 'VJR' when 5 then 'VJORA' end) as atributo01,
	  (case CBV_evntoCtbilApura.cTpoMercd
		when 1 then 'VIS'
		when 2 then 'OPC'
		when 3 then 'OPV'
		when 4 then 'EOC'
		when 5 then 'EOV'
		when 6 then 'TER'
		when 7 then 'FRA'
		when 8 then 'EMP'
		when 9 then 'LEI'
	   end) as atributo02,
	  cast(null as varchar(50)) as atributo03,
	  cast(null as varchar(50)) as atributo04,
	  cast(null as varchar(50)) as atributo05,
	  cast(null as varchar(50)) as atributo06,
	  cast(null as varchar(50)) as atributo07,
	  cast(null as varchar(50)) as atributo08,
	  cast(null as varchar(50)) as atributo09,
	  cast(null as varchar(50)) as atributo10,
	  sum(vApuraEvntoCtbil) as ValorEvento
	from CBV_evntoCtbilApura
	join CBV_Instituicao
		on CBV_Instituicao.Id = Cbv_EvntoCtbilApura.nInstcEvnto
	join CBV_Acao
	  on CBV_Acao.Id = CBV_EvntoCtbilApura.nAcaoEvnto
	where dApurcEvnto = @dataMovimento
	  and CBV_EvntoCtbilApura.nApurcEvntoCtbil = @numeroLote
	  and CBV_Instituicao.ClienteId = @codigoCliente
    group by	
	  dApurcEvnto,
	  cEvntoCtbil,
	  (case CBV_evntoCtbilApura.cTpoCategEvntoApura when 1 then 'LN' when 2 then 'DV' when 3 then 'MV' when 4 then 'VJR' when 5 then 'VJORA' end),
	  (case CBV_evntoCtbilApura.cTpoMercd
		when 1 then 'VIS'
		when 2 then 'OPC'
		when 3 then 'OPV'
		when 4 then 'EOC'
		when 5 then 'EOV'
		when 6 then 'TER'
		when 7 then 'FRA'
		when 8 then 'EMP'
		when 9 then 'LEI'
	   end)
	
end;

-- Atualização da versão
UPDATE dbo.TMA_APLICIMPLCLI set vParmAplic = '01.03.00.01'
where iparmaplic = 'versao' and nMdulosist = ( select nMdulosist from dbo.TMA_MduloSist where iMduloSist = 'bolsa-ear' )
go

UPDATE dbo.TMA_ModDadoAplic set CVRSAOMODDADO= '01.03.00.01' WHERE iModDado='BolsaWeb'
go

UPDATE dbo.TMA_ModDadoAplic set dAtulzVrsaoModDado= getdate() WHERE iModDado='BolsaWeb'
go

UPDATE dbo.SEC_Sistema set versao = '01.03.00.01' where Sigla='BVW'
go