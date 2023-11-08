create database DB_CDS;
USE DB_CDS;

-- tabela artista
create table tb_artista (
 pk_Cod_artista int primary key not null auto_increment,
 nome_artista varchar (100) not null unique key
);

-- tabela gravadora
create table tb_gravadora(
	pk_cod_gravadora int primary key not null auto_increment,
    nome_gravadora varchar (50) unique key not null
);

-- tabela categoria
create table tb_categoria(
	pk_cod_categoria int primary key not null auto_increment,
	nome_categoria varchar (50) unique key not null
);

-- tabela estado
create table tb_estado(
	pk_Sigla_Estado char(2) primary key not null,
    nome_estado char(50) not null unique
);

-- tabela cidade
create table tb_cidade(
	pk_cod_cidade int primary key not null auto_increment,
    fk_sigla_estado char(2) not null,
    nome_cidade varchar (100) not null unique key,
    
    foreign key(fk_sigla_estado) references tb_estado(pk_Sigla_Estado) -- chave primária da tabela estado
);

-- tabela cliente
create table tb_cliente(
	pk_cod_cliente int not null primary key auto_increment,
    fk_cod_cidade int not null,
    nome_cliente varchar(100) not null,
    endereco_cliente varchar(200) not null,
    renda_cliente decimal(10,2) not null default 0 CHECK (renda_cliente >= 0),
    sexo_cliente char(1) not null default 'F' CHECK (sexo_cliente = 'M' OR sexo_cliente = 'F'),

	foreign key(fk_cod_cidade) references tb_cidade(pk_cod_cidade) -- chave primária da tabela cidade
);

-- tabela conjuge
create table tb_conjuge(
	fk_cod_cliente int not null,
    nome_conjuge varchar(100) not null,
    renda_conjuge decimal(10,2) not null default 0 CHECK (renda_conjuge >= 0),
    sexo_conjuge char(1) not null default 'M' CHECK (sexo_conjuge = 'F' OR sexo_conjuge = 'M'),
    
    foreign key (fk_cod_cliente) references tb_cliente(pk_cod_cliente) -- chave primária da tabela cliente
);

-- tabela funcionário
create table tb_funcionario(
	pk_cod_funcionario int not null primary key auto_increment,
    nome_funcionario varchar(100) not null,
    endereco_funcionario varchar(200) not null,
    salario_funcionario decimal(10,2) not null default 0 CHECK (salario_funcionario >= 0),
    sexo_funcionario char(1) not null default 'M' CHECK (sexo_funcionario = 'M' OR sexo_funcionario = 'F')
);

-- tabela dependente
create table tb_dependente(
	pk_cod_dependente int not null primary key auto_increment,
    fk_cod_funcionario int not null,
    nome_dependente varchar(100) not null,
    sexo_dependente char(1) not null default 'M' CHECK (sexo_dependente = 'M' OR sexo_dependente = 'F'),
    
    foreign key(fk_cod_funcionario) references tb_funcionario(pk_cod_funcionario) -- chave primária da tabela funcionario
);

-- tabela titulo
create table tb_titulo(
	pk_cod_titulo int not null primary key auto_increment,
    cod_categoria int not null,
    cod_gravadora int not null,
    nome_cd varchar(100) unique,
    valor_cd decimal(10,2) not null CHECK(valor_cd > 0),
    quantidade_estoque int not null CHECK (quantidade_estoque >= 0)
);

-- tabela pedido
create table tb_pedido(
	pk_num_pedido int not null primary key auto_increment,
    cod_cliente int not null,
    cod_funcionario int not null,
    data_pedido datetime not null,
    valor_pedido decimal(10,2) not null default 0 CHECK (valor_pedido >= 0),
    
    foreign key(cod_cliente) references tb_titulo(pk_cod_titulo) -- chave primária da tabela titulo
);

-- tabela titulo pedido
create table tb_tituloPedido(
	fk_num_pedido int not null,
    fk_cod_titulo int not null,
    quantidade_cd int not null CHECK (quantidade_cd >= 1),
    valor_cd decimal(10,2) not null CHECK (valor_cd > 0),
    
    primary key(fk_num_pedido, fk_cod_titulo),
    foreign key(fk_num_pedido) references tb_pedido(pk_num_pedido), -- chave primária da tabela pedido
    foreign key(fk_cod_titulo) references tb_titulo(pk_cod_titulo) -- chave primária da tabela titulo
);


-- tabela titulo artista
create table tb_tituloArtista(
	cod_titulo int not null,
    cod_artista int not null,
    
    primary key(cod_titulo, cod_artista),
    foreign key(cod_titulo) references tb_titulo(pk_cod_titulo), -- chave primária da tabela titulo
    foreign key(cod_artista) references tb_artista(pk_Cod_artista) -- chave primária da tabela artista
);

desc tb_tituloArtista;