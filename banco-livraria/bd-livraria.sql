create database db_livraria;
use db_livraria;

create table tb_livro(
	PK_ID_livro int not null primary key auto_increment,
    nome_livro varchar (100),
    genero_livro enum ('romance', 'misterio', 'aventura', 'suspense','comedia','ficcao','policial','biografia'),
    data_publi date,
    capa_livro enum ('roller', 'mole','cartao','parana'),
    valor_livro decimal (10.2),
    rating enum ('otimo','bom', 'regular','ruim','pessimo')
);

describe tb_livro;
select * from tb_livro; 

insert into tb_livro
(nome_livro,genero_livro,data_publi,capa_livro,valor_livro,rating) value
('1q84','ficcao','2009-08-02','mole',50.00,'otimo'),
('perdida','romance','2011-08-26','roller',49.00,'regular'),
('garota exemplar','suspense','2011-10-11','roller',69.00,'otimo'),
('Operação cavalo de troia','ficcao','1960-10-09','mole',79.00,'otimo'); 

select * from tb_livro;
select nome_livro, genero_livro from tb_livro;
select nome_livro, genero_livro from tb_livro 
where rating = 'otimo' and valor_livro < 80.00;

create table tb_autor(
	pk_id_autor int not null auto_increment,
	nome_autor varchar (100),
	endereco_autor varchar (50),
	pais_origem varchar (50),
    constraint pk_id_autor primary key (pk_id_autor)
);

describe tb_autor;
select * from tb_autor;

insert into tb_autor
(nome_autor, endereco_autor, pais_origem) value
('haruk murakami', 'sao paulo', 'Brasil'),
('Carina Rissi', 'Rio de Janeiro', 'Brasil'),
('Gillian Flynn', 'Pernambuco', 'Brasil'),
('jj benitez', 'Santa Catarina', 'Brasil');

create table tb_editora(
pk_id_editora int primary key not null auto_increment,
nome_editora varchar(20),
telefone_editora varchar(20),
endereco_editora varchar(50)
);

describe tb_editora;
select*from tb_editora;

insert into tb_editora (nome_editora,telefone_editora,endereco_editora) value
('saraiva','(11)91111-1111','Rua Lapa Tito, 54'),
('verus editora','(11)92222-2222','Rua Lapa Tito, 1'),
('intrinseca','(21)93333-3333','Rua Maikon, 10');

select*from tb_editora;

describe tb_livro;

alter table tb_livro add column fk_id_autor int;

alter table tb_livro 
add constraint fk_id_autor 
foreign key (fk_id_autor)
references tb_autor(pk_id_autor);

/* Add chave estrangeira editora */
alter table tb_livro add column fk_id_editora int;

/* Add fazendo a ligação */
alter table tb_livro
add constraint fk_id_editora
foreign key (fk_id_editora) references tb_editora(pk_id_editora);

select*from tb_livro
where nome_livro like '%p%';

select * from tb_livro;

update tb_livro 
set capa_livro = 'parana' 
where pk_id_livro = 4;

update tb_livro set capa_livro = 'parana', valor_livro = 100
where genero_livro = 'ficcao';

select * from tb_autor;

update tb_livro set fk_id_autor = 4
where nome_livro = 'Operação cavalo de troia';

select tb_livro.nome_livro, tb_livro.valor_livro, tb_autor.nome_autor 
from tb_livro join tb_autor
on tb_autor.pk_id_autor = tb_livro.fk_id_autor; 

select tb_livro.nome_livro, tb_livro.valor_livro, tb_editora.nome_editora
from tb_livro join tb_editora
on tb_editora.pk_id_editora = tb_livro.fk_id_editora;