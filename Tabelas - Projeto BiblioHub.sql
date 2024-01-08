create table bibliohub.Biblioteca(

	cnpj varchar(50) primary key,
	nome varchar(50) not null,
	cidade varchar(50) not null,
	rua varchar(50) not null,
	bairro varchar(50) not null,
	hr_funcionamento varchar(30) not null

);

create table bibliohub.TelefonesBiblio(
	
	cnpj varchar(50) references bibliohub.Biblioteca(cnpj) on update cascade on delete cascade not null,
	telefoneBiblio varchar(50) not null,
	primary key(cnpj, telefoneBiblio)
);

create table bibliohub.Pessoais(

	CPF varchar(50) primary key,
	nome varchar(30) not null

);

create table bibliohub.TelefonesPessoa(

	CPF varchar(50) references bibliohub.Pessoais(CPF) not null,
	telefonePessoa varchar(50) not null,
	primary key(CPF, telefonePessoa)

);

create table bibliohub.EmailsPessoa(

	CPF varchar(50) references bibliohub.Pessoais(CPF) not null,
	emailPessoa varchar(50) not null,
	primary key(CPF, emailPessoa)

);

create table bibliohub.Sessao(

	id_sessao int primary key,
	nome varchar(30) not null,
	descricao varchar(50) not null,
	quant_livros_sessao int not null

);

create table bibliohub.Livros(

	ISBN varchar(60) primary key,
	titulo varchar(50) not null,
	editora varchar(30) not null,
	autor varchar(30) not null,
	dt_publi date not null,
	id_sessao int references bibliohub.Sessao(id_sessao) on delete cascade

);


create table bibliohub.Emprestimo(

	id_emprestimo int primary key,
	dt_emprestimo date not null,
	dt_devolucao date not null,
	status varchar(30) not null,
	ISBN varchar(60) references bibliohub.Livros(ISBN) on update cascade

);

create table bibliohub.ConsultarLivros_Biblio(

	cnpj varchar(50) references bibliohub.Biblioteca(cnpj) on update cascade on delete cascade not null,
	ISBN varchar(60) references bibliohub.Livros(ISBN) on update cascade on delete cascade not null,
	quant_livros_biblio int not null

);

create table bibliohub.Emprestimo_efetuado(

	id_emprestimo int references bibliohub.Emprestimo(id_emprestimo),
	CPF varchar(50) references bibliohub.Pessoais(CPF),
	data date not null

);
