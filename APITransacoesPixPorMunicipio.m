// ==========================================
// Autor: Denis Cassio Pardinho
// Data: 12/01/2025 18:15:59
// Descrição: Esta função em Power Query (M) gera dinamicamente uma tabela com transações do Pix por município, consultando a API do Banco Central do Brasil.
// Versão: 1.0
// Repositório: https://github.com/deniscassiopard/APITransacoesPixPorMunicipio
// Licença: MIT
// ==========================================

let
	// Função que consulta a API do Banco Central para um mês específico.
    APITransacoesPixPorMunicipio = (mes as text) as table =>
	
    let
		// Faz a requisição para a API do Banco Central com o mês passado como parâmetro.
        Fonte = Json.Document(Web.Contents("https://olinda.bcb.gov.br/olinda/servico/Pix_DadosAbertos/versao/v1/odata/TransacoesPixPorMunicipio(DataBase='" & mes & "')?$top=100000000&$format=json&$select=AnoMes,Municipio_Ibge,Municipio,Estado_Ibge,Estado,Sigla_Regiao,Regiao,VL_PagadorPF,QT_PagadorPF,VL_PagadorPJ,QT_PagadorPJ,VL_RecebedorPF,QT_RecebedorPF,VL_RecebedorPJ,QT_RecebedorPJ,QT_PES_PagadorPF,QT_PES_PagadorPJ,QT_PES_RecebedorPF,QT_PES_RecebedorPJ")),
        
		// Converte o JSON retornado em uma tabela.
		Tabela = Table.FromList(Fonte[value], Splitter.SplitByNothing(), null, null, ExtraValues.Error),
		
        // Expande a coluna "Column1" para obter os campos desejados da API.
		Expandido = Table.ExpandRecordColumn(Tabela, "Column1", {"AnoMes", "Municipio_Ibge", "Municipio", "Estado_Ibge", "Estado", "Sigla_Regiao", "Regiao", "VL_PagadorPF", "QT_PagadorPF", "VL_PagadorPJ", "QT_PagadorPJ", "VL_RecebedorPF", "QT_RecebedorPF", "VL_RecebedorPJ", "QT_RecebedorPJ", "QT_PES_PagadorPF", "QT_PES_PagadorPJ", "QT_PES_RecebedorPF", "QT_PES_RecebedorPJ"})
    in
        Expandido,

	// Lista com os meses que serão consultados na API.
    Meses = 
    {	
        "202301", "202302", "202303", "202304", "202305", "202306", "202307", "202308", "202309", "202310", "202311", "202312",
        "202401", "202402", "202403", "202404", "202405", "202406", "202407", "202408", "202409", "202410", "202411", "202412",
        "202501"
    },

	// Combina os dados de todos os meses da lista em uma única tabela
    DadosCombinados = Table.Combine(List.Transform(Meses, each APITransacoesPixPorMunicipio(_))),
	
	// Ordena os dados pela coluna "AnoMes" em ordem decrescente.
    #"Linhas Classificadas" = Table.Sort(DadosCombinados, {"AnoMes", Order.Descending}),
	
	// Converte os tipos das colunas para os tipos adequados (números, textos, entre outros.).
    #"Tipo Alterado" = 
	Table.TransformColumnTypes(#"Linhas Classificadas",
		{
			{"AnoMes", Int64.Type}, {"Municipio_Ibge", Int64.Type}, {"Estado_Ibge", Int64.Type}, {"VL_PagadorPF", type number}, {"QT_PagadorPF", type number}, {"VL_PagadorPJ", type number}, 
			{"QT_PagadorPJ", type number}, {"VL_RecebedorPF", type number}, {"QT_RecebedorPF", type number}, {"VL_RecebedorPJ", type number}, {"QT_RecebedorPJ", type number}, 
			{"QT_PES_PagadorPF", type number}, {"QT_PES_PagadorPJ", type number}, {"QT_PES_RecebedorPF", type number}, {"QT_PES_RecebedorPJ", type number}, {"Sigla_Regiao", type text}, 
			{"Estado", type text}, {"Municipio", type text}, {"Regiao", type text}
		}
	)
in
    #"Tipo Alterado"