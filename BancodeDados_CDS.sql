drop database DB_CDS; 

create database DB_CDS;
use DB_CDS;


create table tb_artista(
   Cod_Art int not null auto_increment,
   Nome_Art varchar (100) not null unique,
   constraint Pk_Id_Art primary key (Cod_Art)
);

desc tb_artista;


create table tb_gravadora(
   Cod_Grav int not null,
   Nome_Grav varchar (50) not null unique,
   constraint Pk_Id_Grav primary key (Cod_Grav),
   constraint Unic_Nome_Grav unique (Nome_Grav)
);

desc tb_gravadora;


create table tb_categoria(
   Cod_Cat int not null,
   Nome_Cat varchar (50) not null unique,
   constraint Pk_Id_Cat primary key (Cod_Cat),
   constraint Unic_Nome_Cat unique (Nome_Cat)
);

desc tb_categoria;


create table tb_estado(
   Sigla_Est char (2) not null,
   Nome_Est char (50) not null,
   constraint Pk_Id_Sigla primary key (Sigla_Est),
   constraint Unic_Nome_Est unique (Nome_Est)
);

desc tb_estado;


create table tb_cidade(
   Cod_Cid int not null,
   Sigla_Est char (2) not null,
   Nome_Cid varchar (100),
   constraint Pk_Id_Cid primary key (Cod_Cid),
   constraint Fk_Id_Sigla foreign key (Sigla_Est) references tb_estado (Sigla_Est)
);

desc tb_cidade;


create table tb_cliente(
   Cod_Cli int not null,
   Cod_Cid int not null,
   Nome_Cli varchar (100) not null,
   End_Cli varchar (200) not null,
   Renda_Cli decimal (10,2) not null,
   Sexo_Cli char (1) not null,
   constraint Pk_Id_Cli primary key (Cod_Cli),
   constraint Fk_Id_Cid foreign key (Cod_Cid) references tb_cidade (Cod_Cid),
   constraint Ck_Id_Renda_Cli check (Renda_Cli >= 0),
   constraint Ck_Sexo check (Sexo_Cli in ('M', 'F'))
);

desc tb_cliente;


create table tb_conjuge(
   Cod_Cli int not null,
   Nome_Conj varchar (100) not null,
   Renda_Conj decimal (10,2) not null,
   Sexo_Conj char (1) not null,
   PRIMARY KEY (Cod_Cli),
   FOREIGN KEY (Cod_Cli) references tb_cliente (Cod_Cli),
   constraint Ck_Renda_Conj check (Renda_Conj >= 0),
   constraint Sk_Sexo_Conj check (Sexo_Conj in('M', 'F'))
);

desc tb_conjuge;


create table tb_funcionario(
   Cod_Func int not null,
   Nome_Func varchar (100) not null,
   End_Func varchar (200) not null,
   Sal_Func decimal (10,2) not null,
   Sexo_Func char (1),
   constraint Pk_Id_Cod_Func primary key (Cod_Func),
   constraint Ck_Sal_Func check (Sal_Func >= 0),
   constraint Sk_Sexo_Func check (Sexo_Func in ('M', 'F'))
);

desc tb_funcionario;


create table tb_dependente(
   Cod_Dep int not null,
   Cod_Func int not null,
   Nome_Dep varchar (100) not null,
   Sexo_Dep char (1) not null,
   constraint Pk_Id_Cod_Dep primary key (Cod_Dep),
   constraint Fk_Id_Cod_Func foreign key (Cod_Func) references tb_funcionario (Cod_Func),
   constraint Sk_Sexo_Dep check (Sexo_Dep in ('M', 'F'))
);

desc tb_dependente;


create table tb_titulo(
   Cod_Tit int not null,
   Cod_Cat int not null,
   Cod_Grav int not null,
   Nome_CD varchar (100) not null unique,
   Val_CD decimal (10,2) not null,
   Qtd_Estq int not null,
   constraint Pk_Id_Cod_Tit primary key (Cod_Tit),
   constraint Fk_Id_Cod_Cat foreign key (Cod_Cat) references tb_categoria (Cod_Cat),
   constraint Fk_Id_Cod_Grav foreign key (Cod_Grav) references tb_gravadora (Cod_Grav),
   constraint Unic_Nome_CD unique (Nome_CD),
   constraint Ck_Val_CD check (Val_CD >0),
   constraint Ck_Qtd_Estq check (Qtd_Estq >= 0)
   );
   

   desc tb_titulo;
   
   
   create table tb_pedido(
      Num_Ped int not null,
      Cod_Cli int not null,
      Cod_Func int not null,
      Data_Ped datetime not null,
      Val_Ped decimal (10,2) not null default 0.00,
      constraint Pk_Id_Num_Ped primary key (Num_Ped),
      FOREIGN KEY (Cod_Cli) references tb_cliente (Cod_Cli),
      FOREIGN KEY (Cod_Func) references tb_funcionario
);
   
   desc tb_pedido;