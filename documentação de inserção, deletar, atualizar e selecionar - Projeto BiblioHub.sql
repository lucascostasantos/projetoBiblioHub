/* OBSERVAÇÃO: Algumas alteração foram necessárias para que o projeto funcionasse da maneira correta
abaixo está listada todas:
	1. O diagrama foi atualizado no relacionamento 'Livros pertence Sessão' agora é 'Sessao têm Livro', e o 
	atributo 'quantidade na sessão' que estava no relacionamento, foi retirado e adicionado na entidade Sessao.
	2. Na transformação, mudou no 2º relacionamento que agora é 'Sessao têm Livro', eu atualizei o documento com a nova explicação e adicionei novamente
	no gitHub.
	3. Foi acrescentado integridade de dados na etapa 4, por isso, o documento das tabelas também foi atualizado.
	4. Todos os documento que estavam no gitHub.
*/

insert into bibliohub.Biblioteca(cnpj, nome, cidade, rua, bairro,hr_funcionamento)
values
(1, 'Biblioteca A', 'Parelhas', 'Rua 1', 'Centro', '07:00:00 - 18:00:00'); 

insert into bibliohub.TelefonesBiblio(cnpj, telefoneBiblio)
values
(1, '9897-7584');

insert into bibliohub.Pessoais(CPF, nome)
values
('123', 'Lucas'),
('456', 'João');

insert into bibliohub.TelefonesPessoa(CPF, telefonePessoa)
values
(123, '8674-9483');

insert  into bibliohub.EmailsPessoa(CPF, emailPessoa)
values
(123, 'lucascsparelhas@gmail.com'),
(123, 'lucasdacosta059@gmail.com');

insert into bibliohub.Sessao(id_sessao, nome,descricao, quant_livros_sessao)
values
(1, 'Romance', 'Historia de amor', 2),
(2, 'Suspense', 'Historia de Misterio', 1);

insert into bibliohub.Livros(ISBN, titulo, editora, autor, dt_publi, id_sessao)
values
('1', 'Verity', 'edit 1', 'Collen Hoover', '2019-02-04', 2),
('2', 'É assim que acaba', 'edit 1', 'Collen Hoover', '2020-05-04', 1),
('3', 'A Biblioteca da Meia Noite', 'edit 2', 'Matt Haig', '2022-02-05', 1);

insert into bibliohub.Emprestimo(id_emprestimo, dt_emprestimo, dt_devolucao, status, ISBN)
values
(1,'2023-08-01', '2023-08-16', 'emprestado', '1'),
(2,'2023-08-01', '2023-08-16', 'emprestado', '2'),
(3,'2023-08-16', '2023-09-01', 'entregue', '3');

insert into bibliohub.ConsultarLivros_Biblio(cnpj, ISBN, quant_livros_biblio)
values
('1', '1', 1);

insert into bibliohub.Emprestimo_efetuado(id_emprestimo, CPF, data)
values
(1, '123', '2023-08-01'),
(2, '456', '2023-08-01'),
(3, '456', '2023-08-16');

/*---------------------------------------------------------------*/
/*Comandos De Deletar*/
/*Deletar um Livro*/
delete from bibliohub.Livros
where ISBN = 2;

/*Deletar uma Biblioteca*/
delete from bibliohub.Biblioteca
where cnpj = 1;

/*---------------------------------------------------------------*/
/*Comando de Atualizar*/
/*Atualizar a data de devolução de um livro(no caso se o livro for renovado)*/
update bibliohub.Emprestimo
set dt_devolucao = '2023-08-30'
where id_emprestimo=1;

/*Atualizar os status do emprestimo de um livro*/
update bibliohub.Emprestimo
set status = 'atrasado'
where id_emprestimo=1;

/*Atualizar a quantidade de um determinado livro em uma determinada Biblioteca*/
update bibliohub.ConsultarLivros_Biblio
set quant_livros_biblio = 1
where ISBN = '1';

/*Atualizar a quantidade de Livros de uma determinada Sessão*/
update bibliohub.Sessao
set quant_livros_sessao=10
where id_sessao=2;

/*---------------------------------------------------------------*/
/*Comando de Selecionar*/
/*Selecionar todos os Livros*/
select * from bibliohub.Livros;

/*Selecionar todas as Bibliotecas*/
select * from bibliohub.Biblioteca;

/*Selecionar todos os telefones que um determinada biblioteca tem*/
select * from bibliohub.TelefonesBiblio;

/*Selecionar todas as Sessões*/
select * from bibliohub.Sessao;

/*Selecionar todos os Empréstimo*/
select * from bibliohub.Emprestimo;

/*Selecionar todos os Empréstimo efetuado pela Pessoa*/
select * from bibliohub.Emprestimo_efetuado;

/*Selecionar todos os livros disponivel numa determinada biblioteca*/
select * from bibliohub.ConsultarLivros_Biblio;

/*Selecionar todas Pessoais que tem registro na biblioteca*/
select * from bibliohub.Pessoais;

/*Selecionar todos os telefones que um determinada pessoa tem*/
select * from bibliohub.TelefonesPessoa;

/*Selecionar todos os emails que um determinada pessoa tem*/
select * from bibliohub.EmailsPessoa;

/*Selecionar a quantidade de um determinado livros em uma determinada Biblioteca*/
select quant_livros_biblio from bibliohub.ConsultarLivros_Biblio
where ISBN='1' and cnpj='1';

/*---------------------------------------------------------------*/
/*Subconsultas*/
/*Selecionar todas as pessoas que fizeram empréstimo em uma determinada data*/
select nome from bibliohub.Pessoais
where CPF in (

	select CPF from bibliohub.Emprestimo_efetuado
	where data = '2023-08-01'

);

/*Selecionar os Livros que estão com status 'emprestado'*/
select titulo from bibliohub.Livros
where ISBN in (

	select isbn from bibliohub.Emprestimo
	where status = 'emprestado'

);

/*Selecionar todos os Livros que estão numa determinada Sessão*/
select titulo from bibliohub.Livros
where id_sessao in (

	select id_sessao from bibliohub.Sessao
	where id_sessao = 1

);

/*Verificar em qual sessão um determinado livro está*/
select nome from bibliohub.Sessao
where id_sessao = (

	select id_sessao from bibliohub.Livros
	where ISBN = '1'

);

/*Selecionar todos os Livros que estão numa determinada Sessão*/
select titulo, autor from bibliohub.Livros
where id_sessao in (

	select id_sessao from bibliohub.Sessao
	where id_sessao = 1

);

/*Selecionar todos os emprestimo que um determinada pessoa tem*/
select id_emprestimo, status from bibliohub.emprestimo
where id_emprestimo in (

	select id_emprestimo from bibliohub.Emprestimo_efetuado
	where CPF = '456'


);

/*Selecionar os livros que uma determinada pessoa pegou*/
select titulo from bibliohub.Livros
where ISBN in (
	
	select ISBN from bibliohub.emprestimo
	where id_emprestimo in (

		select id_emprestimo from bibliohub.Emprestimo_efetuado
		where CPF = '456'

	)
);